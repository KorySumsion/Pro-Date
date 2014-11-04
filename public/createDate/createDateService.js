var app = angular.module('Pro-Date');

app.service('createDateService', function($http){

	this.getDates = function() {
		return $http({
			method: 'GET',
			url: 'http://localhost:1111/server'
		}).then(function(res){
			return res.data;
		});
	}

	this.addDate = function(date){
		return $http({
			method: 'POST',
			url: 'http://localhost:1111/server',
			data: date
		})
	}


})