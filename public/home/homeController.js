var app = angular.module('Pro-Date');

app.controller('homeController', function($scope, $log, $timeout, createDateService){

	$scope.map = {center: {latitude: 40.24688018092244, longitude: -111.65841056632996 }, zoom: 13, bounds: {}};
		$scope.options = {scrollwheel: false};
	    $scope.drawingManagerOptions = {
		    drawingMode: google.maps.drawing.OverlayType.MARKER,
		    drawingControl: true,
		    drawingControlOptions: {
	    		position: google.maps.ControlPosition.TOP_CENTER,
	        	drawingModes: [
	          		google.maps.drawing.OverlayType.MARKER
	        	]
	    	}
	    };
	    console.log($scope.drawingManagerControl);
	$scope.drawingManagerControl = {};	 
	    createDateService.getDates().then(function(dates){
	  		$scope.dates = dates;	
	})

	$scope.windowOptions = {
	  	visible: false
	};

	$scope.onClick = function() {
	  	$scope.windowOptions.visible = !$scope.windowOptions.visible;
	  	};

	$scope.closeClick = function() {
	  	$scope.windowOptions.visible = false;
	};

	console.log($scope.dates)

	$scope.showIndoorActive = false;
	$scope.showIndoorWalk = false;
	$scope.showOutdoorActive = false;
	$scope.showOutdoorWalk = false;
	$scope.indoorFilter = true;
	$scope.outdoorFilter = true;
	$scope.indoor = function(){
		$scope.showIndoorActive =!$scope.showIndoorActive;
		$scope.showIndoorWalk = !$scope.showIndoorWalk;
		$scope.outdoorFilter = !$scope.outdoorFilter;
	}	
	$scope.outdoor = function(){
		$scope.showOutdoorActive =!$scope.showOutdoorActive;
		$scope.showOutdoorWalk = !$scope.showOutdoorWalk;
		$scope.indoorFilter = !$scope.indoorFilter;
	}



});


