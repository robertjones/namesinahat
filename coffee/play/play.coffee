# Put stuff on the scope properly

'use strict'

angular.module('myApp.play', ['ngRoute'])

.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/play',
    templateUrl: 'play/play.html'
    controller: 'PlayCtrl'
  )
])

.controller('PlayCtrl', [
  '$scope' 
  '$cookieStore' 
  '$location' 
  ($scope, $cookieStore, $location) ->

    # Initialise state

    $scope.gameover = false
    names = $cookieStore.get('names') ? []
    $scope.unreadNames = _.shuffle(names)
    numTeams = parseInt($cookieStore.get('numTeams'))
    $scope.correct = []
    $scope.skipped = 0
    roundMessages = [
      "Round 1: No limit",
      "Round 2: One word",
      "Round 3: No words"]
    $scope.roundMessage = roundMessages.shift()
    $scope.currentTeam = 1
    $scope.currentName = $scope.unreadNames.pop()
    $scope.scores = ({"team": t, "score": 0} for t in [1..parseInt(numTeams)])

    # Functions

    nextName = ->
      $scope.gameover = $scope.unreadNames.length < 1 and roundMessages.length < 1
      nextRound = $scope.unreadNames.length < 1
      if $scope.gameover
      else if nextRound
        $scope.roundMessage = roundMessages.shift()
        $scope.unreadNames = _.shuffle(names)
        $scope.currentName = $scope.unreadNames.pop()
        alert("Next round! #{$scope.roundMessage}")
      else
        $scope.currentName = $scope.unreadNames.pop()

    skip = ->
      $scope.skipped++
      $scope.unreadNames.unshift($scope.currentName)
      nextName()
    
    next = ->
      $scope.correct.push($scope.currentName)
      nextName()
    
    nextPlayer = ->
      $scope.scores[$scope.currentTeam-1]["score"] += $scope.correct.length
      $scope.unreadNames = _.shuffle($scope.unreadNames.concat($scope.currentName))
      $scope.correct = []
      $scope.currentTeam = if $scope.currentTeam < numTeams then $scope.currentTeam+1 else 1
      $scope.skipped = 0
      nextName()

    # Add functions to scope
    $scope.skip = skip
    $scope.next = next
    $scope.nextPlayer = nextPlayer

  ])