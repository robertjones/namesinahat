'use strict'

# Declare app level module which depends on views, and components
angular.module('myApp', [
  'ngRoute'
  'ngCookies'
  'myApp.add'
  'myApp.about'
  'myApp.play'
  'myApp.version'
]).
config(['$routeProvider', ($routeProvider) -> 
  $routeProvider.otherwise({redirectTo: '/about'})
])