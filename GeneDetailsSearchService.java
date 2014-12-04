package com.takeda.tgd.services;

import com.takeda.tgd.dao.GeneDetailSearchDAO;
import com.takeda.tgd.entities.GeneSequences;
import com.takeda.tgd.entities.SwissprotIsoforms;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class GeneDetailSearchService {

    @Autowired
    private GeneDetailSearchDAO geneDetailSearchDAO;

    public List<GeneSequences> getGeneSequencesByGeneId(Integer geneId){
        return geneDetailSearchDAO.getGeneSequencesByGeneId(geneId);
    }

    public List<SwissprotIsoforms> getSwissprotIsoformsByGeneId(Integer geneId){
        return geneDetailSearchDAO.getSwissprotIsoformsByGeneId(geneId);
    }
    
}
