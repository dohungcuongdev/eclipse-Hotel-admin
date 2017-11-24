/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
    Created on : Nov 11, 2017, 9:38:05 AM
    Author     : HUNGCUONG
*/
const API_URL = "http://localhost:8080/Hotel-booking-and-reservations-system-admin/api/follow-users.html";

var app = angular.module('follow-users', []);

app.directive('followUserDirective', function() {
  return {
    restrict: 'A',
    link: function(scope, element, attrs) {
      if (scope.$last) {

        // ng-repeat is completed
        $(document).ready(function(){
		  $('#followUserTableBody').pageMe({pagerSelector:'#myPager',showPrevNext:true,hidePageNumbers:false,perPage:200});
			
		});
      }
    }
  };
});

app.filter('secondsToTime',function(){
	function padTime(t) {
        return t < 10 ? "0"+t : t;
    }
	
	function padMilli(s) {
		if(s < 10)
			return "00"+s;
		else if(s < 100)
			return "0"+s;
		return s;
    }

    return function (s) {
		if (typeof s !== "number" || s < 0)
            return "00:00:00:000";
        var ms = s % 1000;
        s = (s - ms) / 1000;
        var secs = s % 60;
        s = (s - secs) / 60;
        var mins = s % 60;
        var hrs = (s - mins) / 60;

        return padTime(hrs) + ':' + padTime(mins) + ':' + padTime(secs) + ':' + padMilli(ms);        
    };
});

app.controller('folowUserCtrl', function($scope, $http) {
  $http.get(API_URL).then(function (response) {
      $scope.followUserData = response.data;
	  for(var i = 0; i < $scope.followUserData.length;i++) {
		if($scope.followUserData[i].username == null || $scope.followUserData[i].username == "")
			$scope.followUserData[i].username = "guest";
		}
	});

	
	$scope.isSortAsc1, $scope.isSortAsc2, $scope.isSortAsc3, $scope.isSortAsc4, $scope.isSortAsc5, $scope.isSortAsc6, $scope.isSortAsc7 = false;
	
	function oneIsSorted() {
		$scope.isSortAsc1, $scope.isSortAsc2, $scope.isSortAsc3, $scope.isSortAsc4, $scope.isSortAsc5, $scope.isSortAsc6, $scope.isSortAsc7 = false;
	}
	
	$scope.sortIP = function(followUserData, dir) {
		if($scope.isSortAsc1) {
			timsort.sort(followUserData, (x, y) => x.user_ip_address.localeCompare(y.user_ip_address));
			$scope.isSortAsc1 = false;
		}
		else {
			timsort.sort(followUserData, (x, y) => y.user_ip_address.localeCompare(x.user_ip_address));
			$scope.isSortAsc1 = true;;
		}
	};
	$scope.sortExIP = function(followUserData, dir) {
		if($scope.isSortAsc2) {
			timsort.sort(followUserData, (x, y) => x.external_ip_address.localeCompare(y.external_ip_address));
			$scope.isSortAsc2 = false;
		}
		else {
			timsort.sort(followUserData, (x, y) => y.external_ip_address.localeCompare(x.external_ip_address));
			$scope.isSortAsc2 = true;;
		}
	};
	$scope.sortCountry = function(followUserData, dir) {
		if($scope.isSortAsc3) {
			timsort.sort(followUserData, (x, y) => x.country.localeCompare(y.country));
			$scope.isSortAsc3 = false;
		}
		else {
			timsort.sort(followUserData, (x, y) => y.country.localeCompare(x.country));
			$scope.isSortAsc3 = true;;
		}
	};
	$scope.sortUser = function(followUserData, dir) {
		if($scope.isSortAsc4) {
			timsort.sort(followUserData, (x, y) => x.username.localeCompare(y.username));
			$scope.isSortAsc4 = false;
		}
		else {
			timsort.sort(followUserData, (x, y) => y.username.localeCompare(x.username));
			$scope.isSortAsc4 = true;;
		}
	};
	$scope.sortDateAccess = function(followUserData, dir) {
		if($scope.isSortAsc6) {
			timsort.sort(followUserData, (x, y) => x.created_at.localeCompare(y.created_at));
			$scope.isSortAsc6 = false;
		}
		else {
			timsort.sort(followUserData, (x, y) => y.created_at.localeCompare(x.created_at));
			$scope.isSortAsc6 = true;;
		}
	};
	$scope.sortPageAccess = function(followUserData, dir) {
		if($scope.isSortAsc5) {
			timsort.sort(followUserData, (x, y) => x.page_access.localeCompare(y.page_access));
			$scope.isSortAsc5 = false;
		}
		else {
			timsort.sort(followUserData, (x, y) => y.page_access.localeCompare(x.page_access));
			$scope.isSortAsc5 = true;;
		}
	};
	$scope.sortDuration = function(followUserData, dir) {
		if($scope.isSortAsc7) {
			timsort.sort(followUserData, (x, y) => x.duration - y.duration);
			$scope.isSortAsc7 = false;
		}
		else {
			timsort.sort(followUserData, (x, y) => y.duration - x.duration);
			$scope.isSortAsc7 = true;;
		}
	};
});



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
