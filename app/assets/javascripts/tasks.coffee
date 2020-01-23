# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  myApp = angular.module('myApp', [])

  myApp.controller 'TodoListCtrl', ['$scope', '$http', ($scope, $http) ->
    $scope.todos = [
      # パラメーターエンコード関数
      transform = (data) ->
        $.param({data})
      $http({
        method : 'POST',
        url : "/load_data",
        transformRequest: transform,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
          'Accept': 'application/vnd.api+json',
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
        data: {}
      }).then (response) =>
        $scope.todos = response.data;
      , (response) =>
        alert '通信失敗'
    ];

    $scope.addTodo = ->
      if $scope.inputTodo?.trim()
        # サーバーにデータを保存
        $http({
          method : 'POST',
          url : "/add_data",
          transformRequest: transform,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
            'Accept': 'application/vnd.api+json',
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
          },
          data: {title:$scope.inputTodo, done:false}
        }).then (response) =>
          $scope.todos.unshift({title:$scope.inputTodo, done:false})
          $scope.inputTodo = ""
        , (response) =>
          alert '通信失敗'
      return

    $scope.updateTodo = (targetId) ->
      targetTask = $scope.todos.find ( (todo) => todo.id == targetId )
      $http({
        method : 'PUT',
        url : "/update_data/#{targetId}",
        transformRequest: transform,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
          'Accept': 'application/vnd.api+json',
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
        data: targetTask
      }).then (response) =>
        console.log 'success'
      , (response) =>
        alert '通信失敗'
      return

    $scope.deleteTodo = (targetId) ->
      $http({
        method : 'POST',
        url : "/delete_data/#{targetId}",
        transformRequest: transform,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
          'Accept': 'application/vnd.api+json',
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
      }).then (response) =>
        $scope.todos.some ( (todo,i) ->
          if todo.id == targetId
            $scope.todos.splice(i,1)
          return )
      , (response) =>
        alert '通信失敗'
      return
  ]

  angular.bootstrap($("#app"), ["myApp"])
