<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/sub-content.jspf"%>


<div class="row">
    <div class="col-xs-12">
        <div class="panel">
            <header class="panel-heading"> Follow Users</header>
            <div class="box-tools m-b-15">
                <div class="input-group">
                    <input type="text" name="table_search" class="form-control input-sm pull-right" 
                           style="width: 150px;" id="input-follow-user" onkeyup="searchInputTable('input-follow-user', 'follow-user-table')" 
                           placeholder="Search for ip address.." title="Type in a ip address"/>
                    <div class="input-group-btn">
                        <button class="btn btn-sm btn-default"><i class="fa fa-search"></i></button>
                    </div>
                </div>
            </div>
            <div class="panel-body table-responsive" id="follow-user-box">
                <table id="follow-user-table">
                    <tr>
                        <th class="tr-p" onclick="sortNum(0, 'follow-user-table')">No.</th>
                        <th class="tr-p" onclick="sortAlpha(1, 'follow-user-table')">User IP Address</th>
                        <th class="tr-p" onclick="sortAlpha(2, 'follow-user-table')">External IP Address</th>
                        <th class="tr-p" onclick="sortAlpha(3, 'follow-user-table')">Country</th>
                        <th class="tr-p" onclick="sortAlpha(4, 'follow-user-table')">User</th>
                        <th class="tr-p" onclick="sortDate(5, 'follow-user-table')">Date Access</th>
                        <th class="tr-p" onclick="sortAlpha(6, 'follow-user-table')">Page Access</th>
                        <th class="tr-p" onclick="sortAlpha(7, 'follow-user-table')">Duration</th>
                    </tr>
                    <tbody id="myTable">
	                    <c:forEach var="user" items="${listFollowUsers}" varStatus="loop">
	                        <tr>
	                            <td>${loop.index + 1}</td>
	                            <td class="tr-p" onclick="location.href = '${pageContext.request.contextPath}/follow-user-ip/${user.user_ip_address}.html'">${user.user_ip_address}</td>
	                            <td class="tr-p" onclick="location.href = 'http://whatismyipaddress.com/ip/${user.external_ip_address}'">${user.external_ip_address}</td>
	                            <td>${user.country}</td>
	                        <c:if test="${user.username == null}"> 
	                            <td>guest</td>
	                        </c:if>
	                        <c:if test="${user.username != null}"> 
	                            <td class="tr-p" onclick="location.href = '${pageContext.request.contextPath}/user/${user.username}.html'">${user.username}</td>
	                        </c:if>
	                        <td>${user.date_access}</td>
	                        <td>${user.page_access}</td>
	                        <td>${user.durationTime}</td>
	                        </tr>
	                    </c:forEach>
                	</tbody>
                </table>
            </div>
             <div class="col-md-12 text-center">
      				<ul class="pagination pagination-lg pager" id="myPager"></ul>
      		</div>
            <br><center><button class="btn btn-danger" onclick="location.href = '${pageContext.request.contextPath}/downloadCSV.html'">
                    <b>Download CSV</b> <i class="fa fa-download"></i></button></center>
            <!-- /.box-body -->
        </div>
        <!-- /.box -->
    </div>
</div>

<%@ include file="common/footer.jspf"%>
