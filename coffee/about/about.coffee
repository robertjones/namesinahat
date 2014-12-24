'use strict'

angular.module('myApp.about', ['ngRoute'])

.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/about'
    templateUrl: 'about/about.html'
    controller: 'AboutCtrl'
  )
])

.controller('AboutCtrl', [
  '$scope' 
  '$cookieStore' 
  '$location' 
  ($scope, $cookieStore, $location) ->
    
])