<%-- 
    Document   : newtabDetails
    Created on : Sep 29, 2014, 10:27:58 AM
    Author     : bozhang1
--%>

<script type="text/javascript">
    $('#navTabList').append('<li class="navTab disabled"><a>>></a></li><li id="listTab" class="navTab"><a href="${contextPath}/Browse">Gene List</a></li><li class="navTab disabled"><a>>></a></li><li id="detailsTab" class="navTab active"><a href="${contextPath}/Details/${mineGene.geneId}">Details</a></li>');
</script>

<style type="text/css">
    .btn-block {
        background-color:#e6e6e6;
    }
</style>

<c:choose>
    <c:when test="${mineGene == null}">
        <div class="alert alert-block alert-error">
            <h4>Error</h4>
            No records found for the submitted parameters.  Your request could not be completed.
        </div>
    </c:when>
    <c:otherwise>

        <h2>${mineGene.ncbiGeneSymbol}  (${mineGene.geneId})</h2>
    </c:otherwise>
</c:choose>
<!-- style for the division bar -->
<style type="text/css">
    .css3 {
        text-align: left;
        vertical-align: top;
        color: #0000cd;
        background: #c0c0c0;
        margin: 0;
        padding: 0;
        font: 10.0pt Arial;
        text-decoration: none;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        -ms-box-sizing: border-box;
    }
</style>
<!--Target Gene Info Start-->
<div class="css3">Target Gene Information</div>
<div class="span12">
    <dl class="dl-horizontal">
        <dt>Gene ID</dt>
        <dd><a href="http://www.ncbi.nlm.nih.gov/gene/?term=${mineGene.geneId}" target="_blank">${mineGene.geneId}</a></dd>

        <dt>SwissProt ID</dt>
        <dd><a href="http://www.uniprot.org/uniprot/${mineGene.swissProtId}" target="_blank">${mineGene.swissProtId}</a></dd>

        <dt>Mine ID</dt>
        <dd>${mineGene.mineId}</dd>

        <dt>ATG Name</dt>
        <dd>${mineGene.atgName}</dd>

        <dt>Stage</dt>
        <dd>
            <c:choose>
                <c:when test="${mineGene.stage == null}">
                    N/A
                </c:when>
                <c:otherwise>
                    ${mineGene.stage}
                </c:otherwise>
            </c:choose>
        </dd>

        <dt>Project</dt>
        <dd>
            <c:choose>
                <c:when test="${mineGene.projectInfoPage == null}">
                    N/A
                </c:when>
                <c:otherwise>
                    ${mineGene.projectInfoPage}
                </c:otherwise>
            </c:choose>
        </dd>

        <dt>Priority</dt>
        <dd>
            <c:choose>
                <c:when test="${mineGene.priority == null}">
                    N/A
                </c:when>
                <c:otherwise>
                    ${mineGene.priority}
                </c:otherwise>
            </c:choose>
        </dd>
    </dl>
</div>                    
<div class="span12"></div>
<!-- load init() function as page start which will get the tabs ready -->
<script type="text/javascript">
    $(document).ready(function(){
        init();
    });
</script>
<!--Target Gene Info End-->   
<!-- Tabs layout start -->
<!-- styles for the tabs -->
<style type="text/css">
    body { font-size: 80%; font-family: 'Lucida Grande', Verdana, Arial, Sans-Serif; }
    ul#tabs { list-style-type: none; margin: 30px 0 0 0; padding: 0 0 0.3em 0; }
    ul#tabs li { display: inline; }
    ul#tabs li a { color: #42454a; background-color: #dedbde; border: 1px solid #c9c3ba; border-bottom: none; padding: 0.3em; text-decoration: none; }
    ul#tabs li a:hover { background-color: #f1f0ee; }
    ul#tabs li a.selected { color: #000; background-color: #f1f0ee; font-weight: bold; padding: 0.7em 0.3em 0.38em 0.3em; }
    div.tabContent { border: 1px solid #c9c3ba; padding: 0.5em; background-color: #f1f0ee; }
    div.tabContent.hide { display: none; }
</style>
<!-- init() function to be loaded when the page ready, it will give the switch tabs function -->
<script type="text/javascript">
    //<![CDATA[

    var tabLinks = new Array();
    var contentDivs = new Array();

    
    function init() {
        // Grab the tab links and content divs from the page
        var tabListItems = document.getElementById('tabs').childNodes;
        for ( var i = 0; i < tabListItems.length; i++ ) {
            if ( tabListItems[i].nodeName == "LI" ) {
                var tabLink = getFirstChildWithTagName( tabListItems[i], 'A' );
                var id = getHash( tabLink.getAttribute('href') );
                tabLinks[id] = tabLink;
                contentDivs[id] = document.getElementById( id );
            }
        }

        // Assign onclick events to the tab links, and
        // highlight the first tab
        var i = 0;

        for ( var id in tabLinks ) {
            tabLinks[id].onclick = showTab;
            tabLinks[id].onfocus = function() { this.blur() };
            if ( i == 0 ) tabLinks[id].className = 'selected';
            i++;
        }

        // Hide all content divs except the first
        var i = 0;

        for ( var id in contentDivs ) {
            if ( i != 0 ) contentDivs[id].className = 'tabContent hide';
            i++;
        }
    }

    function showTab() {
        var selectedId = getHash( this.getAttribute('href') );

        // Highlight the selected tab, and dim all others.
        // Also show the selected content div, and hide all others.
        for ( var id in contentDivs ) {
            if ( id == selectedId ) {
                tabLinks[id].className = 'selected';
                contentDivs[id].className = 'tabContent';
            } else {
                tabLinks[id].className = '';
                contentDivs[id].className = 'tabContent hide';
            }
        }

        // Stop the browser following the link
        return false;
    }

    function getFirstChildWithTagName( element, tagName ) {
        for ( var i = 0; i < element.childNodes.length; i++ ) {
            if ( element.childNodes[i].nodeName == tagName ) return element.childNodes[i];
        }
    }

    function getHash( url ) {
        var hashPos = url.lastIndexOf ( '#' );
        return url.substring( hashPos + 1 );
    }

    //]]>
</script>

<ul id="tabs">
    <li><a href="#ncbi">NCBI</a></li>
    <li><a href="#swissprot">Swissprot</a></li>   
    <li><a href="#sequenceAnalysis">Sequence Analysis</a></li>
    <li><a href="#geneExpression">Gene Expression</a></li>
</ul>

<!--NCBI Tab Start-->

<div class="tabContent" id="ncbi">
    <dl class="dl-horizontal">        
        <div class="css3">General Information</div>
        <dt>Gene Symbol (NCBI)</dt>
        <dd>${mineGene.ncbiGeneSymbol}</dd>

        <dt>Gene Symbol (Mine)</dt>
        <dd>${mineGene.mineGeneSymbol}</dd>

        <dt>Official Full Name</dt>
        <dd>${mineGene.geneName}</dd>

        <dt>Alias</dt>
        <dd>${mineGene.alias}</dd>

        <dt>Map Location</dt>
        <dd>${mineGene.mapLocation}</dd>

        <dt>Summary</dt>
        <dd>${mineGene.summary}</dd>

        <dt>Organism</dt>
        <dd>${mineGene.organism}</dd>
    </dl>
    <!--Sequences Start-->   
    <!-- style for the sequence table -->
    <style type="text/css">
        #seqTable {

        }
        #seqTable th {

        }
        #seqTable th h4, #tmTable th h4 {
            text-align: center;
        }
        #seqTable .table-dna {
            /*background-color:#f5f5f5;*/
        }
        #seqTable .table-mrna  {
            background-color:#e6e6e6;
            color: black;
        }
        #seqTable .table-protein {
            /*background-color:#f5f5f5;*/
        }
        #seqTable .table-signal, #tmTable .table-signal  {
            background-color:#e6e6e6;
            color: black;
        }
        #seqTable .table-tm, #tmTable .table-tm  {

        }                          
    </style>
    <div class="css3">Sequence Information</div>
    <table id="seqTable" class="table table-bordered table-condensed">
        <c:choose>
            <c:when test="${geneSequences.size() == 0}">
                <div class="alert alert-info">
                    <h4>No results found.</h4>
                    No sequences were found for the selected gene.
                </div>
            </c:when>
            <c:otherwise>
                <thead>
                    <tr>
                        <th colspan="2" class="table-dna"><h4>DNA</h4></th>
                <th colspan="4" ><h4>mRNA</h4></th>
                <th colspan="4" class="table-protein"><h4>Protein</h4></th>
                </tr>
                <tr>
                    <th class="table-dna">RefSeq</th>
                    <th class="table-dna">Sequence</th>
                    <th>RefSeq</th>
                    <th>Primary ID</th>
                    <th>Version</th>
                    <th>Length</th>
                    <th class="table-protein">Refseq</th>
                    <th class="table-protein">Primary ID</th>
                    <th class="table-protein">Version</th>
                    <th class="table-protein">Length</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${geneSequences}" var="seq">
                        <tr>
                            <td class="table-dna">
                                <c:choose>
                                    <c:when test="${seq.geneRefseqId == 'not available'}">
                                        Not Available
                                    </c:when>
                                    <c:otherwise>
                                        <a href="http://www.ncbi.nlm.nih.gov/nuccore/${seq.geneRefseqId}" target="_blank">${seq.geneRefseqId}</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="table-dna">
                                <a href="${biorxRoot}/gene DNA sequence/BioPerl/${seq.geneId} .fasta" target="_blank">${seq.geneId}.fasta</a>
                            </td>
                            <td class="table-mrna">
                                <c:choose>
                                    <c:when test="${seq.mrnaRefseqId == 'not available'}">
                                        Not Available
                                    </c:when>
                                    <c:otherwise>
                                        <a href="http://www.ncbi.nlm.nih.gov/nuccore/${seq.mrnaRefseqId}" target="_blank">${seq.mrnaRefseqId}</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="table-mrna">${seq.mrnaPrimaryId}</td>
                            <td class="table-mrna">${seq.mrnaVersion}</td>
                            <td class="table-mrna">${seq.mrnaLength}</td>
                            <td class="table-protein">
                                <c:choose>
                                    <c:when test="${seq.proteinRefseqId == 'not available'}">
                                        Not Available
                                    </c:when>
                                    <c:otherwise>
                                        <a href="http://www.ncbi.nlm.nih.gov/protein/${seq.proteinRefseqId}" target="_blank">${seq.proteinRefseqId}</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="table-protein">${seq.proteinPrimaryId}</td>
                            <td class="table-protein">${seq.proteinVersion}</td>
                            <td class="table-protein">${seq.proteinLength}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
<!--NCBI End-->   
<!--Swissprot Start-->
<div class="tabContent" id="swissprot">
    <dl class="dl-horizontal">
        <!--<div class="css3">General Information</div>  
        </br>-->
        <div class="css3">Names</div>


        <dt>Protein Names</dt>
        <dd>${mineGene.proteinNames}</dd>

        <div class="css3">Protein Attributes</div>

        <dt>Sequence Length</dt>
        <dd>${mineGene.sequenceLength}</dd>

        <dt>Sequence Status</dt>
        <dd>${mineGene.sequenceStatus}</dd>

        <dt>Protein Existence</dt>
        <dd>
            <c:choose>
                <c:when test="${mineGene.proteinExistence == null}">
                    N/A
                </c:when>
                <c:otherwise>
                    ${mineGene.proteinExistence}
                </c:otherwise>
            </c:choose>
        </dd>

        <div class="css3">General Annotation (Comments)</div>

        <dt>Function</dt>
        <dd>
            <c:choose>
                <c:when test="${mineGene.function == null}">
                    N/A
                </c:when>
                <c:otherwise>
                    ${mineGene.function}
                </c:otherwise>
            </c:choose>
        </dd>

        <dt>Subcellular Location</dt>
        <dd>
            <c:choose>
                <c:when test="${mineGene.subcellularLocation == null}">
                    N/A
                </c:when>
                <c:otherwise>
                    ${mineGene.subcellularLocation}
                </c:otherwise>
            </c:choose>
        </dd>


        <dt>Tissue Specificity</dt>
        <dd>
            <c:choose>
                <c:when test="${mineGene.tissueSpecificity == null}">
                    N/A
                </c:when>
                <c:otherwise>
                    ${mineGene.tissueSpecificity}
                </c:otherwise>
            </c:choose>
        </dd>


        <dt>Domain</dt>
        <dd>
            <c:choose>
                <c:when test="${mineGene.domain == null}">
                    N/A
                </c:when>
                <c:otherwise>
                    ${mineGene.domain}
                </c:otherwise>
            </c:choose>
        </dd>


        <dt>Sequence Similarities</dt>
        <dd>
            <c:choose>
                <c:when test="${mineGene.sequenceSimilarities == null}">
                    N/A
                </c:when>
                <c:otherwise>
                    ${mineGene.sequenceSimilarities}
                </c:otherwise>
            </c:choose>
        </dd>

        <div class="css3">Sequence annotation (Features)</div>

        <dt>Signal Peptide</dt>
        <dd>
            <c:choose>
                <c:when test="${mineGene.signalPeptide == null}">
                    N/A
                </c:when>
                <c:otherwise>
                    ${mineGene.signalPeptide}
                </c:otherwise>
            </c:choose>
        </dd>

        <div class="css3">References</div>

        <c:forEach items="${spReferences}" var="ref" varStatus="i">                       

            <dd>${ref.reference}</dd>
            <dt>cited for: </dt>
            <dd>${ref.citations}</dd>

            <dt>
            <dd><a href="${ref.pubmedLink}" target="_blank">PubMed</a></dd>
            <dd><a href="${ref.europeLink}" target="_blank">Europe PMC</a></dd>
            <dd><a href="${ref.abstractLink}" target="_blank">Abstract</a></dd>
            </dt>
        </c:forEach>     
    </dl>
    <style type="text/css">

        #isoformTable {

        }
        #isoformTable th {

        }
        #isoformTable th h4, #tmTable th h4 {
            text-align: center;
        }
        #isoformTable .table-isoform {
            /*background-color:#f5f5f5;*/
        }

        #isoformTable .table-signal, #tmTable .table-signal  {
            background-color:#e6e6e6;
            color: black;
        }
        #isoformTable .table-tm, #tmTable .table-tm  {

        }
    </style>
    <div class="css3">Sequence Information</div>
    <table id="isoformTable" class="table table-bordered table-condensed">
        <thead>
            <tr>
                <th colspan="2" class="table-isoform"><h4>Isoform</h4></th>

        </tr>
        <tr>
            <th class="table-isoform">isoform</th>
            <th class="table-isoform">length</th>

        </tr>
        </thead>
        <tbody>
            <c:forEach items="${spIsoforms}" var="iso" varStatus="i">  
                <tr>
                    <td class="table-isoform">
                        <c:choose>
                            <c:when test="${iso.isoform == 'not available'}">
                                Not Available
                            </c:when>
                            <c:otherwise>
                                <a href="${biorxRoot}/swiss-prot data/prot_input/${iso.isoform}.fasta" target="_blank">${iso.isoform}</a>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td class="table-mrna">${iso.isoformLength}</td>

                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>                      
<!--Swissprot End-->  

<!--Sequence Analysis Start-->
<div class="tabContent" id="sequenceAnalysis">

    <c:choose>
        <c:when test="${tmPrediction.size() == 0}">
            <div class="alert alert-info">
                <h4>No results found.</h4>
                No sequences were found for the selected gene.
            </div>
        </c:when>
        <c:otherwise>
            <div class="css3">NCBI Signal Peptide and Transmembrane Prediction</div>
            <table id="tmTable" class="table table-bordered table-condensed">
                <thead>
                    <tr>
                        <th colspan="4"><h4>Protein</h4></th>
                <th colspan="2"><h4>Signal Peptide</h4></th>
                <th colspan="3"><h4>Transmembrane</h4></th>
                </tr>
                <tr>
                    <th>Refseq</th>
                    <th>Primary ID</th>
                    <th>Version</th>
                    <th>Length</th>
                    <th>SIGNALP</th>
                    <th>Phobius</th>
                    <th>MEMSAT</th>
                    <th>TMHMM</th>
                    <th>Phobius</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${tmPrediction}" var="tm">
                        <tr>
                            <td class="table-protein">
                                <c:choose>
                                    <c:when test="${tm.proteinRefseqId == 'not available'}">
                                        Not Available
                                    </c:when>
                                    <c:otherwise>
                                        <a href="http://www.ncbi.nlm.nih.gov/protein/${tm.proteinRefseqId}" target="_blank">${tm.proteinRefseqId}</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="table-protein">${tm.proteinPrimaryId}</td>
                            <td class="table-protein">${tm.proteinVersion}</td>
                            <td class="table-protein">${tm.proteinLength}</td>
                            <td class="table-signal">
                                <a href="${biorxRoot}/SignalP/Merged/${tm.geneId}/${tm.proteinRefseqId}.pdf" target="_blank">${tm.signalP}</a>
                            </td>
                            <td class="table-signal">
                                <a href="${biorxRoot}/Phobius/Phoboius%20html%20results/${tm.proteinRefseqId}.html" target="_blank">${tm.phobiusSignal}</a>
                                <%--
                                <c:choose>
                                    <c:when test="${tm.phobiusSignal != 'No'}">
                                        <a href="${biorxRoot}/Phobius/Phobius%20Image/${tm.proteinRefseqId}.png" target="_blank">${tm.phobiusSignal}</a>
                                    </c:when>
                                    <c:otherwise>
                                        ${tm.phobiusSignal}
                                    </c:otherwise>
                                </c:choose>
                                --%>
                            </td>
                            <td class="table-tm">
                                <a href="${biorxRoot}/Memsat/Pdf%20results/${tm.geneId}/${tm.proteinRefseqId}.pdf" target="_blank">${tm.memsat}</a>
                            </td>
                            <td class="table-tm">
                                <c:choose>
                                    <c:when test="${tm.tmhmmTopology == '' || tm.tmhmmTopology == null}">
                                        N/A
                                    </c:when>
                                    <c:when test="${tm.tmhmmTopology != 'o' && tm.tmhmmTopology != 'i'}">
                                        <a href="${biorxRoot}/TMHMM/tmhmm_results/${tm.proteinRefseqId}_result.txt" target="_blank">${tm.tmhmmTopology}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${biorxRoot}/TMHMM/tmhmm_results/${tm.proteinRefseqId}_result.txt" target="_blank">${tm.tmhmmTopology}</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="table-tm">
                                <a href="${biorxRoot}/Phobius/Phoboius%20html%20results/${tm.proteinRefseqId}.html" target="_blank">${tm.phobiusTm}</a>
                                <%--
                                <c:choose>
                                    <c:when test="${tm.phobiusTm != 'Not a transmembrane Protein'}">
                                        <a href="${biorxRoot}/Phobius/Phoboius%20html%20results/${tm.proteinRefseqId}.html" target="_blank">${tm.phobiusTm}</a>
                                    </c:when>
                                    <c:otherwise>
                                        ${tm.phobiusTm}
                                    </c:otherwise>
                                </c:choose>
                                --%>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </c:otherwise>
    </c:choose>
    <!-- start Swissprot Sequence Analysis -->

    <c:choose>
        <c:when test="${sptmPrediction.size() == 0}">
            <div class="alert alert-info">
                <h4>No results found.</h4>
                No sequences were found for the selected gene.
            </div>
        </c:when>
        <c:otherwise>
            <div class="css3">Swissprot Signal Peptide and Transmembrane Prediction</div>
            <table id="sptmTable" class="table table-bordered table-condensed">
                <thead>
                    <tr>
                        <th colspan="2"><h4>Protein</h4></th>
                <th colspan="2"><h4>Signal Peptide</h4></th>
                <th colspan="3"><h4>Transmembrane</h4></th>
                </tr>
                <tr>
                    <th>Isoform</th>
                    <th>Length</th>
                    <th>SIGNALP</th>
                    <th>Phobius</th>
                    <th>MEMSAT</th>
                    <th>TMHMM</th>
                    <th>Phobius</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${sptmPrediction}" var="sptm">
                        <tr>
                            <td class="table-protein">
                                <c:choose>
                                    <c:when test="${sptm.spIsoform == 'not available'}">
                                        Not Available
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${biorxRoot}/swiss-prot data/prot_input/${sptm.spIsoform}.fasta" target="_blank">${sptm.spIsoform}</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td class="table-protein">${sptm.isoformLength}</td>
                            <td class="table-signal">
                                <a href="${biorxRoot}/Swissprot protein predictions/Signal P/Pdf result files/${sptm.spId}/${sptm.spIsoform}.pdf" target="_blank">${sptm.spSignalP}</a>
                            </td>
                            <td class="table-signal">
                                <a href="${biorxRoot}/Swissprot protein predictions/Phobius/signalP/${sptm.spIsoform}_result.txt" target="_blank">${sptm.phobiusSignalP}</a>

                            </td>
                            <td class="table-tm">
                                <a href="${biorxRoot}/Swissprot protein predictions/MEMSAT/Pdf result files/${sptm.spId}/${sptm.spIsoform}.pdf" target="_blank">${sptm.spMemsat}</a>
                            </td>
                            <td class="table-tm">
                                <a href="${biorxRoot}/Swissprot protein predictions/TMHMM/tmhmm_results/${sptm.spIsoform}_result.txt" target="_blank">${sptm.tmhmmTransmem}</a>
                            </td>
                            <td class="table-tm">
                                <a href="${biorxRoot}/Swissprot protein predictions/Phobius/Phoboius html results/${sptm.spId}/${sptm.spIsoform}.html" target="_blank">${sptm.phobiusTransmem}</a>

                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </c:otherwise>
    </c:choose>
    <!-- End Swissprot Sequence Analysis --> 

    <!--Start Protein Orthologs-->
    <div class="row">
        <div class="span4">

            <h4>Protein Orthologs</h4>
            <a class="btn btn-large btn-block" href="${biorxRoot}/Homologs_Results_pdf/blast/${mineGene.geneId}.pdf" target="_blank"><i class="icon-file"></i> BLAST Report</a>
            <a class="btn btn-large btn-block" href="${biorxRoot}/Homologs_Results_pdf/Alignment/${mineGene.geneId}.pdf" target="_blank"><i class="icon-file"></i> Sequence Alignment</a>
            <a class="btn btn-large btn-block" href="${biorxRoot}/homologs/${mineGene.geneId}/merged/merged.fasta" target="_blank"><i class="icon-file"></i> Ortholog Sequences</a>

        </div>
        <!--End Protein Orthologs-->

        <!--Start Sequence Comparison-->
        <div class="span4">

            <h4>Sequence Comparison (Mine v. NCBI)</h4>
            <a class="btn btn-large btn-block" href="${biorxRoot}/Verification/protein blast/${mineGene.geneId}.pdf" target="_blank"><i class="icon-file"></i> BLAST Report</a>
            <a class="btn btn-large btn-block" href="${biorxRoot}/Verification/protein alignment/${mineGene.geneId}.pdf" target="_blank"><i class="icon-file"></i> Sequence Alignment</a>

        </div>

        <div class="span4">

            <h4>Sequence Alignment (Swissprot v. NCBI)</h4>
            <a class="btn btn-large btn-block" href="${biorxRoot}/alignment_ncbi_swissprot/text format/${mineGene.geneId}_alignment.txt" target="_blank"><i class="icon-file"></i> text version</a>
            <a class="btn btn-large btn-block" href="${biorxRoot}/alignment_ncbi_swissprot/pdf format/${mineGene.geneId}_alignment.pdf" target="_blank"><i class="icon-file"></i> pdf version</a>

        </div>
        <!--End Sequence Comparison-->

    </div>  


    <script type="text/javascript">
    
        function addTableStyles(){
            $("#tmTable tr:even").each(function(){
                $(this).removeClass("table-row-odd").addClass("table-row-even"); 
            });
            $("#tmTable tr:odd").each(function(){
                $(this).removeClass("table-row-even").addClass("table-row-odd"); 
            });
        }
        //addTableStyles();
    </script>


</div>
<!--Sequence Analysis End-->
<!--Start Gene Expression-->

<div class="tabContent" id="geneExpression">

    <div class="span6">

        <h4>RNA-SEQ</h4>

        <c:choose>
            <c:when test="${mineGene.ncbiGeneSymbol == ''}">
                <a class="btn btn-large btn-block" disabled><i class="icon-signal"></i> RNA-SEQ Expression (N/A)</a>
            </c:when>
            <c:otherwise>
                <a class="btn btn-large btn-block" href="<c:url value="/RNAseq/${mineGene.ncbiGeneSymbol}" />"><i class="icon-signal"></i> RNA-SEQ Expression</a>
            </c:otherwise>
        </c:choose>



    </div>



    <div class="span6">

        <h4>Taqman</h4>

        <c:choose>
            <c:when test="${mineGene.mineId == 0}">
                <a class="btn btn-large btn-block" disabled><i class="icon-remove"></i> Taqman Expression (N/A)</a>
            </c:when>
            <c:otherwise>
                <a class="btn btn-large btn-block" href="<c:url value="/Taqman/${mineGene.mineId}" />"><i class="icon-signal"></i> Taqman Expression</a>
            </c:otherwise>
        </c:choose>



        <c:choose>
            <c:when test="${ampliconFile == null}">
                <a class="btn btn-large btn-block" disabled><i class="icon-remove"></i> Taqman Amplicon Alignment (N/A)</a>
            </c:when>
            <c:otherwise>
                <a class="btn btn-large btn-block" href="${biorxRoot}/Amplicons Blast/${ampliconFile.name}" target="_blank"><i class="icon-file"></i> Taqman Amplicon Alignment</a>
            </c:otherwise>
        </c:choose>

    </div>


</div
<!--End Gene Expression-->
