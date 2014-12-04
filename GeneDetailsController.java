package com.takeda.tgd.controllers;

import com.takeda.tgd.entities.GeneSearchResults;
import com.takeda.tgd.entities.GeneSequences;
import com.takeda.tgd.entities.GeneTMPrediction;
import com.takeda.tgd.entities.SwissprotIsoforms;
import com.takeda.tgd.services.GeneDetailSearchService;
import com.takeda.tgd.services.GeneSearchService;
import java.io.File;
import java.io.FilenameFilter;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/Details/{id}")
public class GeneDetailsController {
    
    @Autowired
    private GeneDetailSearchService geneDetailSearchService;
    
    @Autowired
    private GeneSearchService geneSearchService;
    
    @RequestMapping(method=RequestMethod.GET)
    public String geneDetails(Model model, @PathVariable("id") Integer geneId){
        
        //Check to see if there are any records for this Gene ID
        List<GeneSearchResults> mineGene = geneSearchService.getGeneByGeneId(geneId);
        
        //If not, return an empty data set, triggering an error message on the page
        if (mineGene.isEmpty()){
            return "newtabDetails";
        }
        //If the gene ID is found, fetch associated information
        else {
            //Keep only the first record (there should only be one)
            model.addAttribute("mineGene", mineGene.get(0));
            
            //Fetch Swissprot Isoforms
            List<SwissprotIsoforms> spIsoforms = geneDetailSearchService.getSwissprotIsoformsByGeneId(geneId);
            model.addAttribute("spIsoforms", spIsoforms);
            
            return "newtabDetails";
        }
    }
    
}
