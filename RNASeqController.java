package com.takeda.tgd.controllers;


import com.takeda.tgd.entities.GeneSearchResults;
import com.takeda.tgd.services.GeneSearchService;
import java.math.BigDecimal;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/RNAseq/{symbol}")
/**
 *
 * @author bozhang1
 */
public class RNAseqController {
    
   
    @Autowired
    private GeneSearchService geneSearchService;
    
    @RequestMapping(method=RequestMethod.GET)
    public String spotfire(Model model, @PathVariable("symbol") String ncbiGeneSymbol){
        
        
        
        //Get Gene ID and Symbol
        List<GeneSearchResults> mineGenes = geneSearchService.getGeneByGeneSymbol(ncbiGeneSymbol);
        BigDecimal geneId = mineGenes.get(0).getGeneId();
        String geneSymbol = mineGenes.get(0).getNcbiGeneSymbol();
        model.addAttribute("geneId", geneId);
        model.addAttribute("geneSymbol", geneSymbol);
        
        return "rnaseq";
    }
        
}

