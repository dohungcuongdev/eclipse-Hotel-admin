<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="common/sub-content.jspf"%>

<!-- Main row -->
<div class="row">

    <div class="col-md-8">
            
        <section class="panel">
            <header class="panel-heading">
                Country Visitor Graph
            </header>
            <div class="panel-body">
                <div id="chartdiv"></div>
                <%@ include file="common/chart.jspf"%>
            </div>
        </section>

    </div>
    <div class="col-md-4">
        <div class="panel">
            <header class="panel-heading">
                Statistical Data

            </header>
            <div class="panel-body">
                <table id="statistical-data-table">
                    <tr>
                        <th class="tr-p" style="width: 10px" onclick="sortNum(0, 'statistical-data-table')">No.</th>
                        <th class="tr-p" onclick="sortAlpha(0, 'statistical-data-table')">Data</th>
                        <th class="tr-p" onclick="sortNum(0, 'statistical-data-table')">Quantity</th>
                        <th class="tr-p" style="width: 40px" onclick="sortNum(0, 'statistical-data-table')">Percent</th>
                    </tr>
                    <c:forEach var="chartData" items="${listchartData}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${chartData.data}</td>
                            <td>
                                ${chartData.quantity}
                                <div class="progress xs">
                                    <div class="progress-bar progress-bar-danger" style="width: ${chartData.percent}%"></div>
                                </div>
                            </td>
                            <td><span class="badge bg-red">${chartData.percent}%</span></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
</div>



<%@ include file="common/all-mes.jspf"%>

<%@ include file="common/footer.jspf"%>