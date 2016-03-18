// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
// require_tree .

var app = angular.module('growth_tracker', ['ui.router']);

app.filter('getById', function() {
  return function(input, id) {
    var i=0, len=input.length;
    for (; i<len; i++) {
      if (+input[i].id == +id) {
        return input[i];
      }
    }
    return null;
  }
});

app.factory('main', function($http, $stateParams) {
  var GS;
  var gStories;
  return {
    setGS: function($stateParams) {
      GS={title: $stateParams.title, text: $stateParams.desc, archived: false}
      $http.post('/stories', GS).then(
        function (success) {
          console.log(success);
          gStories.push(success.data);
        },
        function (error) {
          console.log(error);
        }
      );
    },
    initStories: function() {
      var query = "/stories.json";

      $http.get(query).then(
        function (success) {
          console.log(success);
          gStories=success.data;
        },
        function (error) {
          console.log(error);
        }
      );
    },
    setStories: function($stateParams) {
      gStories=$stateParams;
      console.log(gStories);
    },
    getStories: function() {
      return gStories;
    }
  }
});

app.config(function($stateProvider, $urlRouterProvider) {
  //
  // For any unmatched url, redirect to /
  $urlRouterProvider.otherwise("/");
  //
  // Now set up the states
  $stateProvider
    .state('main', {
      url: "",
      views: {
        'featured': {
          templateUrl: "templates/featured.html",
          controller: 'FeaturedCtrl'
        },
        'stories-index': {
          templateUrl: "templates/stories-index.html",
          controller: 'StoriesIndexCtrl'
        },
        'goals-index': {
          templateUrl: "templates/goals-index.html",
          controller: 'GoalsIndexCtrl'
        }
      }
    })
    
    .state('stories', {
      url: "/stories/{story_id: [0-9]{1,8}}",
      templateUrl: "templates/story-show.html",
      controller: 'StoryShowCtrl'
    })

    .state('goals', {
      url: "/goals/{goal_id: [0-9]{1,8}}",
      templateUrl: "templates/goal-show.html",
      controller: 'GoalShowCtrl'
    })

});

app.controller('MainCtrl', function ($scope, $http, main) {
   main.initStories();
});

app.controller('FeaturedCtrl', function ($scope, $http) {
  var query = "/featured";
  $scope.tag = "";

  $http.get(query).then(
    function (success) {
      console.log(success);
      $scope.stories = success.data;
    },
    function (error) {
      console.log(error);
    }
  );
});

app.controller('StoriesIndexCtrl', function ($scope, $http, main, $filter, $stateParams) {
  $scope.stories = main.getStories();
  
  if ($scope.stories == null) {
      var query = "/stories.json";

      $http.get(query).then(
        function (success) {
          console.log(success);
          $scope.stories = success.data;
        },
        function (error) {
          console.log(error);
        }
      );
  }

  $scope.feature = function($stateParams) {
    var query = "/stories/" + $stateParams.id;
    $scope.tag = "";

    $stateParams.featured = true;
    
    $http.put(query, $stateParams).then(
      function (success) {
        console.log(success);
      },
       function (error) {
        console.log(error);
      }
    );
  }

  $scope.publish = function($stateParams) {
    var query = "/stories/" + $stateParams.id;
    $scope.tag = "";

    $stateParams.published = true;
    
    $http.put(query, $stateParams).then(
      function (success) {
        console.log(success);
      },
       function (error) {
        console.log(error);
      }
    );
  }

  $scope.archive = function($stateParams) {
    var query = "/stories/" + $stateParams.story_id;
    $scope.tag = "";

    $http.delete(query).then(
      function (success) {
        console.log(success);
        $scope.stories = main.getStories();
        if ($scope.stories) {
          var story = $filter('getById')($scope.stories, $stateParams.story_id);
          $scope.stories.splice($scope.stories.indexOf(story),1);
          main.setStories($scope.stories)
        }
      },
      function (error) {
        console.log(error);
      }
    );
  }
  
  $scope.updateStory = function($stateParams) {
    var query = "/stories/" + $stateParams.id;

    $http.put(query, $stateParams).then(
      function (success) {
        console.log(success);
      },
      function (error) {
        console.log(error);
      }
    );
  }

});

app.controller('StoryShowCtrl', function ($scope, $http, $stateParams) {
  var query = "/stories/" + $stateParams.story_id;
  $scope.tag = "";

  $http.get(query).then(
    function (success) {
      console.log(success);
      $scope.story = success.data;
    },
    function (error) {
      console.log(error);
    }
  );
});

app.controller('GoalsIndexCtrl', function ($scope, $http, $stateParams, $filter, main) {

  var query = "/goals.json";
  $scope.tag = "";

  $scope.addGoal = function() {
    $http.post('/goals', $scope.goal).then(
        function (success) {
          $scope.goals.push(success.data);
          console.log("saved goal " + $scope.goal.title);
          $scope.goal = {};
        },
        function (error) {
          console.log("error");
        }
    )};

    $http.get(query).then(
      function (success) {
        console.log(success);
        $scope.goals = success.data;
      },
      function (error) {
        console.log(error);
    });

    $scope.deleteGoal = function($stateParams) {
      var query = "/goals/" + $stateParams.id;
      $scope.tag = "";

      $http.delete(query).then(
        function (success) {
          console.log(success);
          if ($scope.goals) {
            var goal = $filter('getById')($scope.goals, $stateParams.id);
            $scope.goals.splice($scope.goals.indexOf(goal),1);
          }
        },
        function (error) {
          console.log(error);
        }
      );
    }
    
    $scope.complete = function($stateParams) {
      main.setGS($stateParams);
      $scope.deleteGoal($stateParams);
    }
});

app.controller('GoalShowCtrl', function ($scope, $http, $stateParams) {
  var query = "/goals/" + $stateParams.goal_id;
  $scope.tag = "";

  $http.get(query).then(
    function (success) {
      console.log(success);
      $scope.goal = success.data;
    },
    function (error) {
      console.log(error);
    }
  );
});