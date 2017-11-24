<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/sub-content.jspf"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script>
$.fn.pageMe = function(opts){
    var $this = this,
        defaults = {
            perPage: 7,
            showPrevNext: false,
            hidePageNumbers: false
        },
        settings = $.extend(defaults, opts);
    
    var listElement = $this;
    var perPage = settings.perPage; 
    var children = listElement.children();
    var pager = $('.pager');
    
    if (typeof settings.childSelector!="undefined") {
        children = listElement.find(settings.childSelector);
    }
    
    if (typeof settings.pagerSelector!="undefined") {
        pager = $(settings.pagerSelector);
    }
    
    var numItems = children.size();
    var numPages = Math.ceil(numItems/perPage);

    pager.data("curr",0);
    
    if (settings.showPrevNext){
        $('<li><a href="#" class="prev_link">«</a></li>').appendTo(pager);
    }
    
    var curr = 0;
    while(numPages > curr && (settings.hidePageNumbers==false)){
        $('<li><a href="#" class="page_link">'+(curr+1)+'</a></li>').appendTo(pager);
        curr++;
    }
    
    if (settings.showPrevNext){
        $('<li><a href="#" class="next_link">»</a></li>').appendTo(pager);
    }
    
    pager.find('.page_link:first').addClass('active');
    pager.find('.prev_link').hide();
    if (numPages<=1) {
        pager.find('.next_link').hide();
    }
  	pager.children().eq(1).addClass("active");
    
    children.hide();
    children.slice(0, perPage).show();
    
    pager.find('li .page_link').click(function(){
        var clickedPage = $(this).html().valueOf()-1;
        goTo(clickedPage,perPage);
        return false;
    });
    pager.find('li .prev_link').click(function(){
        previous();
        return false;
    });
    pager.find('li .next_link').click(function(){
        next();
        return false;
    });
    
    function previous(){
        var goToPage = parseInt(pager.data("curr")) - 1;
        goTo(goToPage);
    }
     
    function next(){
        goToPage = parseInt(pager.data("curr")) + 1;
        goTo(goToPage);
    }
    
    function goTo(page){
        var startAt = page * perPage,
            endOn = startAt + perPage;
        
        children.css('display','none').slice(startAt, endOn).show();
        
        if (page>=1) {
            pager.find('.prev_link').show();
        }
        else {
            pager.find('.prev_link').hide();
        }
        
        if (page<(numPages-1)) {
            pager.find('.next_link').show();
        }
        else {
            pager.find('.next_link').hide();
        }
        
        pager.data("curr",page);
      	pager.children().removeClass("active");
        pager.children().eq(page+1).addClass("active");
    
    }
};

$(document).ready(function(){
    
  $('#myTable').pageMe({pagerSelector:'#myPager',showPrevNext:true,hidePageNumbers:false,perPage:4});
    
});
</script>
<div class="row">
    <div class="col-xs-12">
        <div class="panel">
            <header class="panel-heading">
                Manage Rooms

            </header>
            <div class="box-tools m-b-15">
                <div class="input-group">
                    <input type="text" name="table_search" class="form-control input-sm pull-right" 
                           style="width: 150px;" id="input-management" onkeyup="search()" 
                           placeholder="Search for names.." title="Type in a name"/>
                    <div class="input-group-btn">
                        <button class="btn btn-sm btn-default"><i class="fa fa-search"></i></button>
                    </div>
                </div>
            </div>
            <div class="panel-body table-responsive" id="manage-rooms-box">    
                <table id="table-management">
                    <tr>
                        <th class="tr-p" onclick="sortNum(0,'table-management')">No.</th>
                        <th class="tr-p" onclick="sortAlpha(1,'table-management')">Room</th>
                        <th class="tr-p" onclick="sortAlpha(2,'table-management')">Type</th>
                        <th class="tr-p" onclick="sortNum(3,'table-management')">Size(sq)</th>
                        <th class="tr-p" onclick="sortNum(4,'table-management')">Price($/day)</th>
                        <th class="tr-p" onclick="sortAlpha(5,'table-management')">Status</th>
                        <th class="tr-p" onclick="sortNum(6,'table-management')">No. of Adults</th>
                        <th class="tr-p" onclick="sortNum(7,'table-management')">Amenities</th>
                        <th>View</th>
                        <th>Edit</th>
                        <th>Del</th>
                    </tr>
          <tbody id="myTable">
             <c:forEach var="room" items="${listrooms}" varStatus="loop">

                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${room.name}</td>
                            <c:if test="${room.type.equalsIgnoreCase('deluxe')}">  
                                <td><span style="font-size: 14px" class="label label-danger">${room.type}</span></td>
                                </c:if>   
                                <c:if test="${room.type.equalsIgnoreCase('family')}">  
                                <td><span style="font-size: 14px" class="label label-success">${room.type}</span></td>
                                </c:if> 
                                <c:if test="${room.type.equalsIgnoreCase('couple')}">  
                                <td><span style="font-size: 14px" class="label label-primary">${room.type}</span></td>
                                </c:if>
                                <c:if test="${room.type.equalsIgnoreCase('single')}">  
                                <td><span style="font-size: 14px" class="label label-warning">${room.type}</span></td>
                                </c:if>  
                            <td>${room.size}</td>
                            <td>${room.price}</td>
                            <td>${room.status}</td>
                            <td align="center">${room.numpeople}</td>
                            <td>${room.avgAminities}</td>
                            <td><button onclick="location.href = '${pageContext.request.contextPath}/room/${room.name}.html'" class="btn btn-default btn-xs"><i class="fa fa-check"></i></button></td>
                            <td><button onclick="location.href = '${pageContext.request.contextPath}/edit-room/${room.name}.html'" class="btn btn-default btn-xs"><i class="fa fa-pencil"></i></button></td>
                            <td><button onclick="deleteRoom('${room.name}')" class="btn btn-default btn-xs"><i class="fa fa-times"></i></button></td>
                        </tr>
                    </c:forEach>
          </tbody>
        </table>   
      </div>
      <div class="col-md-12 text-center">
      		<ul class="pagination pagination-lg pager" id="myPager"></ul>
      </div>
	</div>
</div>
