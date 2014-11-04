var app = angular.module('Pro-Date');

app.controller('createDateController', function($scope, createDateService){

	$scope.getDates = function() {
		createDateService.getDates().then(function(dates){
			$scope.dates = dates;
			console.log($scope.dates);
		})
	}

	$scope.addDate = function() {
		createDateService.addDate($scope.date);
		console.log($scope.dates);
		$scope.date = '';
	}

})