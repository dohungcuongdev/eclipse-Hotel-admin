<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/sub-content.jspf"%>

<div class="row">
    <div class="col-xs-12">
        <div class="panel">
            <header class="panel-heading">
                IP Address Statistics

            </header>
            <div id="chartdiv"></div>
            <%@ include file="common/chart.jspf"%>
        </div>
    </div>            
</div>
<%@ include file="common/footer.jspf"%>