package com.takeda.tgd.models;

import javax.validation.constraints.Max;
import javax.validation.constraints.Size;

public class SearchRequest {
    
    @Max(999999999)
    private Integer geneId;
    
    @Size(max=40)
    private String swissProtId;
    

    public Integer getGeneId() {
        return geneId;
    }

    public void setGeneId(Integer geneId) {
        this.geneId = geneId;
    }
    
    public String getSwissProtId() {
        return swissProtId;
    }

    public void setSwissProtId(String swissProtId) {
        this.swissProtId = swissProtId;
    }

    
    
}
