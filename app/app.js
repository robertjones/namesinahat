// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  angular.module('myApp', ['ngRoute', 'ngCookies', 'myApp.add', 'myApp.stage', 'myApp.play', 'myApp.version']).config([
    '$routeProvider', function($routeProvider) {
      return $routeProvider.otherwise({
        redirectTo: '/add'
      });
    }
  ]);

}).call(this);
