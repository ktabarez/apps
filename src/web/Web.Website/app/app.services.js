/// <reference path="app.base.js" />
/// <reference path="app.module.js" />

var AuthenticationService = function ($http, $q, $rootScope, $cookies, authService, moment, ConfigurationService) {
    var self = this;

    var _type = arguments.callee.name;

    var _endpoints = {
        'token': ConfigurationService.urls.api.baseUrl + '/token',
    }

    var _isAccessTokenCookieValid = function() {
        if (self.userSecurityInfo && moment(self.userSecurityInfo['.expires'], 'ddd, D MMM YYYY HH:mm:ss GMT').isAfter(moment(new Date())))
            return true;

        return false;
    }

    self.userSecurityInfo = null;

    var _login = function () {
        var promise = $http({
            method: 'POST',
            url: _endpoints.token,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            },
            data: $.param({
                grant_type: 'password',
                username: ConfigurationService.username,
                client_id: ConfigurationService.clientId,
                org_id: ConfigurationService.orgId
            })
        });

        promise.then(function (response, status, config, headers) {
            self.userSecurityInfo = response.data;
            $cookies.putObject('userSecurityInfo', self.userSecurityInfo);

            authService.loginConfirmed('success');
        });
    };

    var _refreshAccessToken = function () {

    };

    self.authenticate = function (rejection) {
        self.userSecurityInfo = $cookies.getObject('userSecurityInfo');

        //no security cookie then get new access token
        if (!self.userSecurityInfo)
            _login();
        //security cookie valid
        else if (_isAccessTokenCookieValid()){
            authService.loginConfirmed('success', function (config) {
                config.headers["Authorization"] = 'Bearer ' + self.userSecurityInfo['access_token'];
                return config;
            });
        }
        //use refresh token
        else {
            //refresh token
        }
    };

    self.init = function () {
        $rootScope.$on('event:auth-loginRequired', self.authenticate);
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
    'authService',
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