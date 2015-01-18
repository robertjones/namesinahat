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
  '$interval' 
  ($scope, $cookieStore, $location, $interval) ->

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
    $scope.postTurn = false
    $scope.preTurn = true
    $scope.newRound = true
    maxTime = 60
    $scope.countDown = maxTime
    $scope.numPenalties = 0
    

    # Functions

    nextName = ->
      nextRound = $scope.unreadNames.length < 1
      if $scope.unreadNames.length < 1 and $scope.roundMessages.length < 1
        $scope.postTurn = true
        $scope.gameOver = true
        $scope.currentTeam = if $scope.currentTeam < numTeams then $scope.currentTeam+1 else 1
        $interval.cancel(counter)
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
        $scope.unreadNames.unshift($scope.currentName) unless $scope.unreadNames.length == 0
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
      $scope.postTurn = true
      nextName()

    nextTurn = ->
      $scope.preTurn = false
      $scope.newRound = false
      $scope.countDown = maxTime

    timer = ->
      if !$scope.preTurn and !$scope.postTurn and !$scope.newRound
        $scope.countDown -= 1
        if $scope.countDown <= 0
          nextPlayer()
    
    nextRound = ->
      $scope.newRound = false

    goPreTurn = ->
      oldTeam = if $scope.currentTeam == 1 then numTeams else $scope.currentTeam-1
      $scope.scores[oldTeam-1]["score"] -= parseInt($scope.numPenalties)
      $scope.numPenalties = 0
      if $scope.gameOver
        $scope.postTurn = false
      else
        $scope.postTurn = false
        $scope.preTurn = true     

    # Add functions to scope
    $scope.skip = skip
    $scope.next = next
    $scope.nextPlayer = nextPlayer
    $scope.nextTurn = nextTurn
    $scope.nextRound = nextRound
    $scope.goPreTurn = goPreTurn

    # Other

    counter = $interval(timer, 1000)

  ])