'use strict'

angular.module('myApp.add', ['ngRoute'])

.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/add'
    templateUrl: 'add/add.html'
    controller: 'AddCtrl'
  )
])

.controller('AddCtrl', [
  '$scope' 
  '$cookieStore' 
  '$location' 
  ($scope, $cookieStore, $location) ->
    $scope.names = $cookieStore.get('names') ? []
    $scope.numTeams = $cookieStore.get('numTeams') ? 2
    $scope.addName = ->
      $scope.name.replace(/^\s+|\s+$/g,'')
      if $scope.name != ''
        $scope.names.push($scope.name)
        $cookieStore.put('names', $scope.names)
        $scope.name = ''
    $scope.empty = ->
      if confirm("Remove all names from the hat?")
        $scope.names = []
        $cookieStore.remove('names')
    $scope.play = ->
      $cookieStore.put('numTeams', parseInt($scope.numTeams))
      # roundMessages = [
      #   "Round 1: No limit"
      #   "Round 2: One word"
      #   "Round 3: No words"
      # ]
      # roundMessage = roundMessages.shift()
      # $cookieStore.put('roundMessages', roundMessages)
      # $cookieStore.put('roundMessage', roundMessage)
      # $cookieStore.put('currentTeam', 0)
      # $cookieStore.put('go', {previous: 0})
      # scores = 
      #   ({"team": t, "score": 0} for t in [1..parseInt($scope.numTeams)])
      # $cookieStore.put('scores', scores)
      $location.path("play")
])