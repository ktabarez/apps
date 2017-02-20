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

    var _endpoints = {
        'feedbacks': ConfigurationService.urls.api.baseUrl + '/api/mfcu/apps/memberfeedback/feedbacks',
        'users': ConfigurationService.urls.api.baseUrl + '/api/mfcu/apps/memberfeedback/users'
    };

    var _cacheRefreshTimeout = null;

    self.cache = {
        isBeingRefreshed: false,
        feedbackDfds: {},
        users: {},
        feedbackStatus : {
            actionRequired: 1,
            informationOnly: 2,
            noActionRequired: 3,
            notReviewed: 4,
            resolved: 5
        }
    };

    self.refreshCache = function () {
        self.isCacheBeingRefreshed = true;

        $q.all(self.getUsers(), self.getFeedbacks()).then(function(){
            self.isCacheBeingRefreshed = false;
        });
    };

    self.searchUsers = function (username) {
        if (self.cache.users[username])
            return self.cache.users[username];

        self.cache.users[username] = $http({
            type: 'GET',
            url: _endpoints.users + '/' + username
        });
    }

    self.searchFeedbacks = function (feedbackCode) {
        //if (self.cache.feedbackDfds[feedbackCode])
        //    return self.cache.feedbackDfds[feedbackCode];

        //self.cache.feedbackDfds[feedbackCode] = $http({
        //    url: _endpoints + '/' + feedbackCode,
        //    method: 'GET'
        //});

        //return self.cache.feedbackDfds[feedbackCode];

        self.cache.feedbackDfds[feedbackCode] = $http({
            method: 'GET',
            url: _endpoints.feedbacks + '/' + feedbackCode,
            source: 'services.' + _type
        });

        return self.cache.feedbackDfds[feedbackCode];
    }

    self.getFeedbacks = function (options) {
        if (self.cache.feedbackDfds.all && !self.isCacheBeingRefreshed)
            return self.cache.feedbackDfds.all;

        options = options || {};
        options.notInStatus = options.notInStatus || {};

        self.cache.feedbackDfds.all = $http({
            method: 'GET',
            url: _endpoints.feedbacks,
            source: 'services.' + _type,
            params: options.notInStatus
        });

        return self.cache.feedbackDfds.all;
    };

    self.getUsers = function () {
        if (self.cache.users.all && !self.isCacheBeingRefreshed)
            return self.cache.feedbackDfds.all;

        self.cache.users.all = $http({
            method: 'GET',
            url: _endpoints.users,
            source: 'services.' + _type
        }).then(function (response) {
            self.cache.users = jQuery.map(response.data, function (item, idx) {
                var newItem = {};

                return newItem[item.username] = item;
            });
        });

        return self.cache.users.all;
    }

    self.init = function () {
        self.refreshCache();

        _cacheRefreshTimeout = $interval(self.refreshCache, ConfigurationService.apiRefreshIntervalInSeconds  * 1000);
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