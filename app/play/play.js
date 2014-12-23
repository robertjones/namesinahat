// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  angular.module('myApp.play', ['ngRoute']).config([
    '$routeProvider', function($routeProvider) {
      return $routeProvider.when('/play', {
        templateUrl: 'play/play.html',
        controller: 'PlayCtrl'
      });
    }
  ]).controller('PlayCtrl', [
    '$scope', '$cookieStore', '$location', function($scope, $cookieStore, $location) {
      var maxSkips, names, next, nextName, nextPlayer, nextRound, nextTurn, numTeams, skip, t, _ref;
      $scope.gameOver = false;
      names = (_ref = $cookieStore.get('names')) != null ? _ref : [];
      $scope.unreadNames = _.shuffle(names);
      numTeams = parseInt($cookieStore.get('numTeams'));
      $scope.correct = [];
      maxSkips = 2;
      $scope.skipsRemaining = maxSkips;
      $scope.roundMessages = ["Round 1: No limit", "Round 2: Three words", "Round 3: One word", "Round 4: No words"];
      $scope.roundMessage = $scope.roundMessages.shift();
      $scope.currentTeam = 1;
      $scope.currentName = $scope.unreadNames.pop();
      $scope.scores = (function() {
        var _i, _ref1, _results;
        _results = [];
        for (t = _i = 1, _ref1 = parseInt(numTeams); 1 <= _ref1 ? _i <= _ref1 : _i >= _ref1; t = 1 <= _ref1 ? ++_i : --_i) {
          _results.push({
            "team": t,
            "score": 0
          });
        }
        return _results;
      })();
      $scope.betweenTurns = true;
      $scope.newRound = true;
      nextName = function() {
        var nextRound;
        $scope.gameOver = $scope.unreadNames.length < 1 && $scope.roundMessages.length < 1;
        nextRound = $scope.unreadNames.length < 1;
        if ($scope.gameOver) {

        } else if (nextRound) {
          $scope.roundMessage = $scope.roundMessages.shift();
          $scope.unreadNames = _.shuffle(names);
          $scope.currentName = $scope.unreadNames.pop();
          return $scope.newRound = true;
        } else {
          return $scope.currentName = $scope.unreadNames.pop();
        }
      };
      skip = function() {
        if ($scope.skipsRemaining >= 1) {
          $scope.skipsRemaining--;
          $scope.unreadNames.unshift($scope.currentName);
          return nextName();
        }
      };
      next = function() {
        $scope.correct.push($scope.currentName);
        $scope.scores[$scope.currentTeam - 1]["score"] += 1;
        return nextName();
      };
      nextPlayer = function() {
        $scope.unreadNames = _.shuffle($scope.unreadNames.concat($scope.currentName));
        $scope.correct = [];
        $scope.currentTeam = $scope.currentTeam < numTeams ? $scope.currentTeam + 1 : 1;
        $scope.skipsRemaining = maxSkips;
        $scope.betweenTurns = true;
        return nextName();
      };
      nextTurn = function() {
        $scope.betweenTurns = false;
        return $scope.newRound = false;
      };
      nextRound = function() {
        return $scope.newRound = false;
      };
      $scope.skip = skip;
      $scope.next = next;
      $scope.nextPlayer = nextPlayer;
      $scope.nextTurn = nextTurn;
      return $scope.nextRound = nextRound;
    }
  ]);

}).call(this);
