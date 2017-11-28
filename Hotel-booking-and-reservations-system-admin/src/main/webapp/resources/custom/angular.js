/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
    Created on : Nov 11, 2017, 9:38:05 AM
    Author     : HUNGCUONG
*/

const CHART_API_URL = "http://localhost:8080/Hotel-booking-and-reservations-system-admin/api/chart-data.html";

var app = angular.module('chart', []);

app.controller('ChartController', function($scope, $http) {
  $http.get(CHART_API_URL).then(function (response) {
      $scope.data = response.data;

	var chart = AmCharts.makeChart("chartdiv", {
		"type" : "serial",
		"theme" : "light",
		"marginRight" : 70,
		"dataProvider" : $scope.data,
		"valueAxes" : [ {
			"axisAlpha" : 0,
			"position" : "left",
			"title" : "Visitors from country"
		} ],
		"startDuration" : 1,
		"graphs" : [ {
			"balloonText" : "<b>[[category]]: [[value]]</b>",
			"fillColorsField" : "color",
			"fillAlphas" : 0.9,
			"lineAlpha" : 0.2,
			"type" : "column",
			"valueField" : "quantity"
		} ],
		"chartCursor" : {
			"categoryBalloonEnabled" : false,
			"cursorAlpha" : 0,
			"zoomable" : false
		},
		"categoryField" : "data",
		"categoryAxis" : {
			"gridPosition" : "start",
			"labelRotation" : 45
		},
		"export" : {
			"enabled" : true
		}

	});
  });
});