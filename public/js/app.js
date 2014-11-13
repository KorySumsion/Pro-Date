var app = angular.module('Pro-Date', ['ngRoute', 'google-maps'.ns()]);

app.config(function($routeProvider){

	$routeProvider
	.when('/', {
		templateUrl: '/home/home.html',
		controller: 'homeController'
	})
	.when('/create', {
		templateUrl: '/createDate/createDate.html',
		controller: 'createDateController'
	})
	.otherwise({
		redirectTo: '/'
	});

})

