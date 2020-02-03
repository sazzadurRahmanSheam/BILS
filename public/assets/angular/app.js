var app = angular.module('surveyApp', ['angular-growl','ngAnimate']);
app.config(['growlProvider', function (growlProvider) {
    growlProvider.globalTimeToLive(5000);
    growlProvider.globalPosition('bottom-right');
}]);
app.controller('pageController',['$scope','$http','$location','growl', function($scope, $http, $location,growl) {
    $scope.addPage = function (campaign_id, page) {
        var config = {};
        $http({
            method: 'GET',
            url: 'http://localhost/survey/campaign/page/setting/'+campaign_id+'/'+page
        }).then(function successCallback(data) {
            console.log(data);
            window.location.reload();
        }, function errorCallback(error) {
            growl.error("This page already exist", config);
            window.location.reload();

        });
    }
    $scope.deletePage = function (campaign_id,page) {
        var config = {};
        if(confirm("Are you sure to delete this page?")){
            $http({
                method: 'GET',
                url: 'http://localhost/survey/campaign/page/setting/'+campaign_id+'/'+page
            }).then(function successCallback(data) {
                console.log(data);
                window.location.reload();
            }, function errorCallback(error) {
                growl.error("Something is wrong", config);
                window.location.reload();
            });
        }
    }
}]);
