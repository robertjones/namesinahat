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
      var maxSkips, names, next, nextName, nextPlayer, numTeams, roundMessages, skip, t, _ref;
      $scope.gameover = false;
      names = (_ref = $cookieStore.get('names')) != null ? _ref : [];
      $scope.unreadNames = _.shuffle(names);
      numTeams = parseInt($cookieStore.get('numTeams'));
      $scope.correct = [];
      maxSkips = 2;
      $scope.skipsRemaining = maxSkips;
      roundMessages = ["Round 1: No limit", "Round 2: One word", "Round 3: No words"];
      $scope.roundMessage = roundMessages.shift();
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
      nextName = function() {
        var nextRound;
        $scope.gameover = $scope.unreadNames.length < 1 && roundMessages.length < 1;
        nextRound = $scope.unreadNames.length < 1;
        if ($scope.gameover) {

        } else if (nextRound) {
          $scope.roundMessage = roundMessages.shift();
          $scope.unreadNames = _.shuffle(names);
          $scope.currentName = $scope.unreadNames.pop();
          return alert("Next round! " + $scope.roundMessage);
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
        return nextName();
      };
      $scope.skip = skip;
      $scope.next = next;
      return $scope.nextPlayer = nextPlayer;
    }
  ]);

}).call(this);
