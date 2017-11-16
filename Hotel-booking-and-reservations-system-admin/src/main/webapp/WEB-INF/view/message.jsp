<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/sub-content.jspf"%>

<!-- Main row -->
<div class="row">

    <div class="col-md-8" id="all-notifications">
        <section class="panel">
            <header class="panel-heading">
                Notifications
            </header>
            <div class="panel-body" id="noti-box">
                <c:choose>
                    <c:when test="${newNotifications.size() <= 0}"> 
                        <div class="alert alert-block alert-danger" style="text-align: center">
                            <strong>No notification available!</strong> 
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="activity" items="${newNotifications}">
                            <c:if test="${activity.click.equals('feedback')}"> 
                                <div class="alert alert-block alert-info">
                                    <button data-dismiss="alert" class="close close-sm" type="button">
                                        <i class="fa fa-times"></i>
                                    </button> 
                                    <strong class="tr-p" 
                                            onclick="location.href = '${pageContext.request.contextPath}/notification/${activity.id}.htm'"> ${activity.time}! 
                                    </strong>
                                    <br>UserName: ${activity.username}
                                    <br>Sent content: ${activity.content}
                                </div>
                            </c:if>
                            <c:if test="${activity.click.equals('register')}"> 
                                <div class="alert alert-block alert-success">
                                    <button data-dismiss="alert" class="close close-sm" type="button">
                                        <i class="fa fa-times"></i>
                                    </button> 
                                    <strong class="tr-p" 
                                            onclick="location.href = '${pageContext.request.contextPath}/notification/${activity.id}.htm'"> ${activity.time}! 
                                    </strong>
                                    <br>UserName: ${activity.username}
                                    <br>Received content: ${activity.content}
                                </div>
                            </c:if>
                            <c:if test="${activity.name.equals('Book Room') || activity.name.equals('Cancel Room')}"> 
                                <div class="alert alert-block alert-danger">
                                    <button data-dismiss="alert" class="close close-sm" type="button">
                                        <i class="fa fa-times"></i>
                                    </button> 
                                    <strong class="tr-p" 
                                            onclick="location.href = '${pageContext.request.contextPath}/reply ${activity.name}/${activity.id}.htm'"> ${activity.time}! 
                                    </strong>
                                    <br>UserName: ${activity.username}
                                    <br>Received content: ${activity.content}
                                </div>
                            </c:if>
                            <c:if test="${activity.click.equals('contact') || activity.click.equals('reservation')}"> 
                                <div class="alert alert-block alert-warning">
                                    <button data-dismiss="alert" class="close close-sm" type="button">
                                        <i class="fa fa-times"></i>
                                    </button> 
                                    <strong class="tr-p" 
                                            onclick="location.href = '${pageContext.request.contextPath}/notification/${activity.id}.htm'"> ${activity.time}! 
                                    </strong>
                                    <br>${activity.username}
                                    <br>Sent content: ${activity.content}
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>



            </div>
        </section>

    </div>
    <%@ include file="common/mes-note.jspf"%>


</div>


<!-- Main row -->
<%@ include file="common/all-mes.jspf"%>
<!-- row end -->
<%@ include file="common/footer.jspf"%>