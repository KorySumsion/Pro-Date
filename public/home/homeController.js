var app = angular.module('Pro-Date');

app.controller('homeController', function($scope, $log, $timeout, createDateService){
	$scope.defDate = true
	$scope.spefDate = false;
	$scope.showIndoorActive = false;
	$scope.showIndoorWalk = false;
	$scope.showOutdoorActive = false;
	$scope.showOutdoorWalk = false;
	$scope.indoorFilter = true;
	$scope.outdoorFilter = true;


	$scope.map = {center: {latitude: 40.24688018092244, longitude: -111.65841056632996 }, zoom: 13, bounds: {}};
	
	// $scope.showAddress = function(address) {
	//   geocoder.getLatLng(
	//     address,
	//     function(point) {
	//       if (!point) {
	//         alert(address + " not found");
	//       } else {
	//       	console.log(point);
	//         map.setCenter(point, 13);
	//         var marker = new GMarker(point);
	//         map.addOverlay(marker);

	//         // As this is user-generated content, we display it as
	//         // text rather than HTML to reduce XSS vulnerabilities.
	//         marker.openInfoWindow(document.createTextNode(address));
	//       }
	//     }
	//   );
	// }


	$scope.options = {scrollwheel: false};

    $scope.windowOptions = {
        visible: false
    };
  

    $scope.onClick = function(date) {
        $scope.windowOptions.date = !$scope.windowOptions.date;
        $scope.defDate = false;
        $scope.spefDate = true;
        $scope.description = date.description;
        $scope.price = date.price;
        $scope.id = date.id
        console.log($scope.description, $scope.price);
    };

    $scope.closeClick = function() {
        $scope.windowOptions.date = false;
    }; 		

	$scope.getAll = function() {
		$scope.showIndoorActive = false;
		$scope.showIndoorWalk = false;
		$scope.showOutdoorActive = false;
		$scope.showOutdoorWalk = false;
		$scope.indoorFilter = true;
		$scope.outdoorFilter = true;
		createDateService.getDates().then(function(dates){
			$scope.dates = [];
			for (var i = 0; i < dates.length; i++) {
				if(dates[i]) {
					$scope.dates.push(dates[i])
				}
			};
			console.log($scope.dates);
		});				
	};
	$scope.outdoor = function() {
		$scope.showOutdoorActive =!$scope.showOutdoorActive;
		$scope.showOutdoorWalk = !$scope.showOutdoorWalk;
		// $scope.indoorFilter = !$scope.indoorFilter;
		createDateService.getDates().then(function(dates){
			$scope.dates = [];
			for (var i = 0; i < dates.length; i++) {
				if(dates[i].outdoor) {
					$scope.dates.push(dates[i])
				}
			};
			console.log($scope.dates);
		});				
	};		

	$scope.indoor = function() {
		$scope.showIndoorActive = !$scope.showIndoorActive;
		$scope.showIndoorWalk = !$scope.showIndoorWalk;
		// $scope.outdoorFilter = !$scope.outdoorFilter;
		createDateService.getDates().then(function(dates){
			$scope.dates = [];
			for (var i = 0; i < dates.length; i++) {
				if(dates[i].indoor) {
					$scope.dates.push(dates[i])
				}
			};
			console.log($scope.dates);
		});				
	};		
		
		$scope.filter = function() {
			$scope.indoor = [];
			$scope.outdoor = [];
			for (var i = 0; i < $scope.dates.length; i++) {
				if($scope.dates[i].indoor) {
					$scope.indoor.push($scope.dates[i])
					console.log($scope.indoor)
				} else {
					$scope.outdoor.push($scope.dates[i])
					console.log($scope.outdoor)					
				}
			};
		}

});
