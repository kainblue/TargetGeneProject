<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!--Home content Start-->
<div id="homeContent" class="bodyContent row">
    <div class="span12">
    
    <form:form id="searchForm" cssClass="form-horizontal" method="post" modelAttribute="searchRequest" action="${contextPath}/SearchResults" >
        <fieldset>
            <div class="row">

                <!--Left column start -->
                <div class="span6">
                    
                    <h2>Search</h2>
                    
                    <!--Gene ID-->
                    <div id="geneIdControlGroup" class="control-group">
                        <label class="control-label" for="geneIdInput">Gene ID</label>
                        <div class="controls ui-widget">
                            <form:input id="geneIdInput" path="geneId" cssErrorClass="error" maxlength="20" />
                            <form:errors path="geneId" cssClass="help-inline spring-form-error" element="span" />
                        </div>
                    </div>

                        <!--SwissProt ID-->
                    <div id="swissProtIdControlGroup" class="control-group">
                        <label class="control-label" for="swissProtIdInput">SwissProt ID</label>
                        <div class="controls ui-widget">
                            <form:input id="swissProtIdInput" path="swissProtId" cssErrorClass="error" maxlength="40" />
                            <form:errors path="swissProtId" cssClass="help-inline spring-form-error" element="span" />
                        </div>
                    </div>
                    
                    <div id="submitControlGroup" class="control-group">   
                        <div class="controls">
                            <a id="searchButton" class="btn btn-large btn-primary" ><i class="icon-search icon-white"></i> Search</a>
                        </div>
                    </div>
                    
                </div>
                <!--Left column end-->

                <!--Right column start-->
                
                <div class="span6">
                    
                    <h2>Browse</h2>
                    
                    <div class="row">
                        <div class="span1"></div>
                        <div class="span4">
                            <a id="browseButton" class="btn btn-block btn-large btn-primary" href="${contextPath}/Browse" ><i class="icon-list icon-white"></i> All Genes</a>
                        </div>
                        <div class="span1"></div>
                    </div>

                    <br/>

                    <div class="row">
                        <div class="span1"></div>
                        <div class="span4">
                            <a id="browseAdcButton" class="btn btn-block btn-large btn-info" href="${contextPath}/ADCList" ><i class="icon-list icon-white"></i> ADC List</a>
                        </div>
                        <div class="span1"></div>
                    </div>
                </div>
                
                <!--Right Column End-->

            </div>
            <!--
            <div class="row">
                <div class="form-actions" class="span12">
                </div>  
            </div>
            -->
        </fieldset>
    </form:form>
    </div>
    
</div>
<!--Home Content End-->

<style type="text/css">

    .ui-autocomplete {
        position: absolute;
        top: 100%;
        left: 0;
        z-index: 1000;
        float: left;
        display: none;
        min-width: 160px;
        _width: 160px;
        padding: 4px 0;
        margin: 2px 0 0 0;
        list-style: none;
        background-color: #ffffff;
        border-color: #ccc;
        border-color: rgba(0, 0, 0, 0.2);
        border-style: solid;
        border-width: 1px;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;
        -webkit-box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
        -moz-box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
        box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
        -webkit-background-clip: padding-box;
        -moz-background-clip: padding;
        background-clip: padding-box;
        *border-right-width: 2px;
        *border-bottom-width: 2px;
    }

    .ui-autocomplete .ui-menu-item > a.ui-corner-all {
        display: block;
        padding: 3px 15px;
        clear: both;
        font-weight: normal;
        line-height: 18px;
        color: #555555;
        white-space: nowrap;
    }

    .ui-autocomplete .ui-menu-item > a.ui-corner-all.ui-state-hover,
    .ui-autocomplete .ui-menu-item > a.ui-corner-all.ui-state-active {
        color: #ffffff;
        text-decoration: none;
        background-color: #0088cc;
        border-radius: 0px;
        -webkit-border-radius: 0px;
        -moz-border-radius: 0px;
        background-image: none;
    }

</style>


<script type="text/javascript" src="<c:url value="/static/js/jquery-ui.min.js" />"></script>
<script type="text/javascript">

    //Run when the document fully loads
    $(document).ready(function(){
       
        $('#homeTab').addClass("active"); //Set the home tab to active
        
        //Search Button
        //Submit the form when search button is clicked
        $('#searchButton').on('click', function(){
            $('#searchForm').submit();
        });
        
        //Error markings
        $('.spring-form-error').closest("div .control-group").addClass('error');

        //Autocomplete
        //handles autocomplete AJAX requests for the form fields
        $("#geneIdInput").autocomplete({
            source: function(request, response){
                $.ajax({
                    url: "${contextPath}/autocomplete",
                    method: "POST",
                    dataType: "json",
                    data: "field=geneId&fragment=" + request.term
                }).done(function(data){
                    response(data);
                });
            },
            minLength: 1,
            messages: {
                noResults: '',
                results: function(){}
            }
        });


        $("#swissProtIdInput").autocomplete({
            source: function(request, response){
                $.ajax({
                    url: "${contextPath}/autocomplete",
                    method: "POST",
                    dataType: "json",
                    data: "field=swissProtId&fragment=" + request.term
                }).done(function(data){
                    response(data);
                });
            },
            minLength: 1,
            messages: {
                noResults: '',
                results: function(){}
            }
        });
        

    });
    
</script>
