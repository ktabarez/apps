/*global angular:true, browser:true */

/**
 * @license HTTP Auth Interceptor Module for AngularJS
 * (c) 2012 Witold Szczerba
 * License: MIT
 */

(function () {
    'use strict';

    /*modules*/
    var authModule = angular.module('http-auth-interceptor', ['http-auth-interceptor-buffer', 'ngCookies']);
    var authInterceptorBufferModule = angular.module('http-auth-interceptor-buffer', []);

    /*services*/
    var authService = function ($rootScope, $cookies, httBufferService) {
        var self = this;

        /**
         * Call this function to indicate that authentication was successfull and trigger a
         * retry of all deferred requests.
         * @param data an optional argument to pass on to $broadcast which may be useful for
         * example if you need to pass through details of the user that was logged in
         * @param configUpdater an optional transformation function that can modify the
         * requests that are retried after having logged in.  This can be used for example
         * to add an authentication token.  It must return the request.
         */
        self.loginConfirmed = function (data, configUpdater) {
            var updater = configUpdater || function (config) { return config; };
            $rootScope.$broadcast('event:auth-loginConfirmed', data);
            httBufferService.retryAll(updater);
        },

        /**
         * Call this function to indicate that authentication should not proceed.
         * All deferred requests will be abandoned or rejected (if reason is provided).
         * @param data an optional argument to pass on to $broadcast.
         * @param reason if provided, the requests are rejected; abandoned otherwise.
         */
        self.loginCancelled = function (data, reason) {
            httBufferService.rejectAll(reason);
            $rootScope.$broadcast('event:auth-loginCancelled', data);
        }

        self.getAccessToken = function () {
            var userSecurityinfo = $cookies.getObject('userSecurityInfo');

            if(userSecurityinfo)
                return 'Bearer ' + userSecurityinfo['access_token'];

            return null;
        }


    };
    var httBufferService = function ($injector) {
        var self = this;

        /** Holds all the requests, so they can be re-requested in future. */
        var _buffer = [];

        /** Service initialized later because of circular dependency problem. */
        var _$http;

        var _retryHttpRequest = function (config, deferred) {
            function successCallback(response) {
                deferred.resolve(response);
            }
            function errorCallback(response) {
                deferred.reject(response);
            }
            _$http = _$http || $injector.get('$http');
            _$http(config).then(successCallback, errorCallback);
        };

        /**
         * Appends HTTP request configuration object with deferred response attached to buffer.
         * @return {Number} The new length of the buffer.
         */
        self.append = function (config, deferred) {
            return _buffer.push({
                config: config,
                deferred: deferred
            });
        },

        /**
         * Abandon or reject (if reason provided) all the buffered requests.
         */
        self.rejectAll = function (reason) {
            if (reason) {
                for (var i = 0; i < _buffer.length; ++i) {
                    _buffer[i].deferred.reject(reason);
                }
            }
            _buffer = [];
        },

        /**
         * Retries all the buffered requests clears the buffer.
         */
        self.retryAll = function (updater) {
            for (var i = 0; i < _buffer.length; ++i) {
                var _cfg = updater(_buffer[i].config);
                if (_cfg !== false)
                    _retryHttpRequest(_cfg, _buffer[i].deferred);
            }
            _buffer = [];
        }
    };

    /*injections*/
    authModule.service('authService', ['$rootScope', '$cookies', 'httBufferService', authService]);
    authInterceptorBufferModule.service('httBufferService', ['$injector', httBufferService]);

    /*configs*/
    authModule.config(['$httpProvider', function ($httpProvider) {
        /**
         * $http interceptor.
         * On 401 response (without 'ignoreAuthModule' option) stores the request
         * and broadcasts 'event:auth-loginRequired'.
         * On 403 response (without 'ignoreAuthModule' option) discards the request
         * and broadcasts 'event:auth-forbidden'.
         */
        $httpProvider.interceptors.push(['$rootScope', '$q', 'httBufferService', 'authService', function ($rootScope, $q, httBufferService, authService) {
            return {
                responseError: function (rejection) {
                    console.log({
                        msg: 'responseError',
                        data: rejection
                    });

                    var config = rejection.config || {};
                    if (!config.ignoreAuthModule) {
                        switch (rejection.status) {
                            case 401:
                                var deferred = $q.defer();
                                var bufferLength = httBufferService.append(config, deferred);
                                if (bufferLength === 1)
                                    $rootScope.$broadcast('event:auth-loginRequired', rejection);
                                return deferred.promise;
                            case 403:
                                $rootScope.$broadcast('event:auth-forbidden', rejection);
                                break;
                        }
                    }
                    // otherwise, default behaviour
                    return $q.reject(rejection);
                },
                response: function (response) {
                    console.log({
                        msg: 'response',
                        data: response
                    });

                    return response;
                },
                request: function (config) {
                    console.log({
                        msg: 'request',
                        data: config
                    });

                    if (config.ignoreAuthModule)
                        return config;

                    if (config.ignoreAccessToken)
                        return;

                    var accessToken = authService.getAccessToken();

                    if (accessToken != null)
                        config.headers["Authorization"] = accessToken;

                    return config;
                },
                requestError: function (rejection) {
                    console.log({
                        msg: 'responseError',
                        data: rejection
                    });
                }
            };
        }]);
    }]);
})();

/* commonjs package manager support (eg componentjs) */
if (typeof module !== "undefined" && typeof exports !== "undefined" && module.exports === exports) {
    module.exports = 'http-auth-interceptor';
}