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

    $scope.gameOver = false
    names = $cookieStore.get('names') ? []
    $scope.unreadNames = _.shuffle(names)
    numTeams = parseInt($cookieStore.get('numTeams'))
    $scope.correct = []
    maxSkips = 2
    $scope.skipsRemaining = maxSkips
    $scope.roundMessages = [
      "Round 1: No limit",
      "Round 2: Three words",
      "Round 3: One word",
      "Round 4: No words"]
    $scope.roundMessage = $scope.roundMessages.shift()
    $scope.currentTeam = 1
    $scope.currentName = $scope.unreadNames.pop()
    $scope.scores = ({"team": t, "score": 0} for t in [1..parseInt(numTeams)])
    $scope.betweenTurns = true
    $scope.newRound = true

    # Functions

    nextName = ->
      $scope.gameOver = $scope.unreadNames.length < 1 and 
                        $scope.roundMessages.length < 1
      nextRound = $scope.unreadNames.length < 1
      if $scope.gameOver
      else if nextRound
        $scope.roundMessage = $scope.roundMessages.shift()
        $scope.unreadNames = _.shuffle(names)
        $scope.currentName = $scope.unreadNames.pop()
        $scope.newRound = true
      else
        $scope.currentName = $scope.unreadNames.pop()

    skip = ->
      if $scope.skipsRemaining >= 1 
        $scope.skipsRemaining--
        $scope.unreadNames.unshift($scope.currentName)
        nextName()
    
    next = ->
      $scope.correct.push($scope.currentName)
      $scope.scores[$scope.currentTeam-1]["score"] += 1
      nextName()
    
    nextPlayer = ->
      $scope.unreadNames = _.shuffle($scope.unreadNames.concat($scope.currentName))
      $scope.correct = []
      $scope.currentTeam = if $scope.currentTeam < numTeams then $scope.currentTeam+1 else 1
      $scope.skipsRemaining = maxSkips
      $scope.betweenTurns = true
      nextName()

    nextTurn = ->
      $scope.betweenTurns = false
      $scope.newRound = false

    nextRound = ->
      $scope.newRound = false

    # Add functions to scope
    $scope.skip = skip
    $scope.next = next
    $scope.nextPlayer = nextPlayer
    $scope.nextTurn = nextTurn
    $scope.nextRound = nextRound

  ])