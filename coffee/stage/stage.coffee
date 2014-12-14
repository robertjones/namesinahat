'use strict'

angular.module('myApp.stage', ['ngRoute'])

.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/stage'
    templateUrl: 'stage/stage.html'
    controller: 'StageCtrl'
  )
])

.controller('StageCtrl', [
  '$scope' 
  '$cookieStore' 
  '$location' 
  ($scope, $cookieStore, $location) ->
    $scope.go =
      final: false
      previous: $cookieStore.get('go').previous

    $scope.go.previous++
    $cookieStore.put('go', $scope.go)
    
    incrementTeam = ->
      previousTeam = $cookieStore.get('currentTeam')
      numTeams = parseInt($cookieStore.get('numTeams'))
      if previousTeam <= numTeams - 1
        $scope.currentTeam = previousTeam + 1
      else
        $scope.currentTeam = 1
      $scope.previousTeam = previousTeam
      $cookieStore.put('currentTeam', $scope.currentTeam)

    incrementTeam()
    $scope.correct = correct = $cookieStore.get('correct') ? 0
    $scope.roundMessages = $cookieStore.get('roundMessages')
    $scope.roundMessage = $cookieStore.get('roundMessage')
    $cookieStore.put('roundMessages', $scope.roundMessages)
    $cookieStore.put('roundMessage', $scope.roundMessage)
    $scope.scores = $cookieStore.get('scores')
])