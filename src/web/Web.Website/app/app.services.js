/// <reference path="app.base.js" />
/// <reference path="app.module.js" />

var AuthenticationService = function ($http, $q, $rootScope, $cookies, moment, ConfigurationService) {
    var self = this;

    var _type = arguments.callee.name;

    var _endpoints = {
        'token': ConfigurationService.urls.api.baseUrl + '/token',
    }

    self.init = function () {

    }
};

var MemberFeedbackService = function ($http, $q, $rootScope, $interval, jQuery, ConfigurationService) {
    var self = this;

    var _type = arguments.callee.name;

    self.endpoints = {
        feedbacks: ConfigurationService.urls.api.baseUrl + '/api/mfcu/apps/memberfeedback/feedbacks',
        users: ConfigurationService.urls.api.baseUrl + '/api/mfcu/apps/memberfeedback/users'
    };

    self.refreshCache = function () {
       return $q.all(self.getUsers(), self.getFeedbacks());
    };

    self.searchUsers = function (username) {
        return $http({
            type: 'GET',
            url: self.endpoints.users + '/' + username
        });
    }

    self.searchFeedbacks = function (feedbackCode) {
        return $http({
            method: 'GET',
            url: self.endpoints.feedbacks + '/' + feedbackCode,
            source: 'services.' + _type
        });
    }

    self.saveFeedbacks = function (feedbacks) {
        return $http({
            method: 'PUT',
            data: feedbacks,
            url: self.endpoints.feedbacks,
            source: 'services.' + _type
        });
    }

    self.getFeedbacks = function (options) {
        options = options || {};
        options.notInStatus = options.notInStatus || {};

        return $http({
            method: 'GET',
            url: self.endpoints.feedbacks,
            source: 'services.' + _type,
            params: options.notInStatus
        });
    };

    self.getUsers = function () {
        return $http({
            method: 'GET',
            url: self.endpoints.users,
            source: 'services.' + _type
        });
    }

    self.init = function () {
        //self.refreshCache();
    };
};

/*http://stackoverflow.com/questions/18529777/best-way-to-invoke-rest-apis-from-angularjs*/
app.service('AuthenticationService', [
    '$http',
    '$q',
    '$rootScope',
    '$cookies',
    'moment',
    'ConfigurationService',
    AuthenticationService]);

app.service('MemberFeedbackService', [
    '$http',
    '$q',
    '$rootScope',
    '$interval',
    'jQuery',
    'ConfigurationService',
    MemberFeedbackService]);