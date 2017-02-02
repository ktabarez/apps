/// <reference path="requests/new-request-form.html" />
/// <reference path="requests/new-request-form.html" />
/// <reference path="C:\projects\Applications\ITGov\Dev-ProjectManagement\ITGov.Project.Web\Scripts/angular.js" />
/// <reference path="C:\projects\Applications\ITGov\Dev-ProjectManagement\ITGov.Project.Web\Scripts/angular-route.js" />

var Select2Control = function (options) {
	var self = this;

	var _onProcessResults = function (data, params) {
		$.each(data.results, function (index, result) {
			result.disabled = self.disableSearchResults;
		});

		var items = {
			results: data.results,
			pagination: {
				more: data.more,
			}
		};

		return items;
	}

	var _onItemAdded = function (e) {
		console.log({ msg: self.select2Target + ' _onItemAdded', data: { items: self.items, event: e, }, });
	}

	var _onItemRemoved = function (e) {
		console.log({ msg: self.select2Target + ' _onItemRemoved', data: { items: self.items, event: e, }, });
	}

	self.onItemAdded = null;
	self.onItemRemoved = null;
	self.select2 = null;
	self.select2Target = options.select2Target || null;
	self.placeholder = options.placeholder || null;
	self.ajaxSettings = options.ajaxSettings || null;
	self.select2Settings = options.select2Settings || null;
	self.disableSearchResults = options.disableSearchResults === 'undefined' ? true : options.disableSearchResults;
	self.items = options.items || {};

	self.init = function () {

		if (self.ajaxSettings) {
			if (!self.ajaxSettings.data) {
				self.ajaxSettings.data = function (params) {
					var queryParameters = {
						searchterm: params.term, // search term
						page: params.page,
						limit: 15,
					};

					return queryParameters;
				}
			}
		}
			self.ajaxSettings.processResults = _onProcessResults;

		if (self.select2Settings) {
			self.select2Settings.ajax = self.ajaxSettings;
			self.select2Settings.placeholder = self.placeholder;

			self.select2 = $(self.select2Target).select2(self.select2Settings);
		}
		else {
			self.select2 = $(self.select2Target).select2({
				placeholder: self.placeholder,
				allowClear: false,
				tags: true,
				multiple: true,
				tokenSeparators: [',', ' '],
				minimumInputLength: 2,
				minimumResultsForSearch: 1,
				delay: 500,
				ajax: self.ajaxSettings,
			});
		}

		$(self.select2Target).on('select2:select', self.onItemAdded);
		$(self.select2Target).on('select2:select', _onItemAdded);
		$(self.select2Target).on('select2:unselect', self.onItemRemoved);
		$(self.select2Target).on('select2:unselect', _onItemRemoved);
	}

	self.clearItems = function () {

		for (var key in self.items) {
			if (self.items.hasOwnProperty(key)) {
				delete self.items[key];
			}
		}

		self.select2.val(null).trigger('change');
	}

	self.onItemAdded = function (e) {
		var key = e.params.data.text;

		if (!self.items.hasOwnProperty(key))
			self.items[key] = e.params.data;
	}

	self.onItemRemoved = function (e) {
		var key = e.params.data.text;

		delete self.items[key];
	}
}

var app = angular.module('dashboardApp', ['ngRoute', 'ngAnimate', 'ui.bootstrap', 'ngSanitize']);


/*
	provide the ability to use ng-model in div element that has the contenteditable set to true
	http://stackoverflow.com/questions/28583651/contenteditable-with-ng-model-doesnt-work
 */
app.directive('contenteditable', ['$sce', function($sce) {
  return {
    restrict: 'A', // only activate on element attribute
    require: '?ngModel', // get a hold of NgModelController
    link: function(scope, element, attrs, ngModel) {
      if (!ngModel) return; // do nothing if no ng-model

      // Specify how UI should be updated
      ngModel.$render = function() {
        element.html($sce.getTrustedHtml(ngModel.$viewValue || ''));
      };

      // Listen for change events to enable binding
      element.on('blur keyup change', function() {
        scope.$evalAsync(read);
      });
      read(); // initialize

      // Write data to the model
      function read() {
        var html = element.html();
        // When we clear the content editable the browser leaves a <br> behind
        // If strip-br attribute is provided then we strip this out
        if ( attrs.stripBr && html == '<br>' ) {
          html = '';
        }
        ngModel.$setViewValue(html);
      }
    }
  };
}]);

app.directive('newRequestForm', function () {
	return {
		restrict: 'E',
		templateUrl: 'app/projectRequests/requests/new-request-form.html'
	}
});

app.service('logService', function () {
	var self = this;

	self.logMessage = function (message) {
		console.log(message);
	}
});

/*http://stackoverflow.com/questions/18529777/best-way-to-invoke-rest-apis-from-angularjs*/
app.service('projectRequestService', ['$http', '$q', '$rootScope', 'authenticationService', 'logService',
											function ($http, $q, $rootScope, authenticationService, logService) {
	//Unknown = 0,
	//Draft = 1,
	//NextLevelApproval = 2,
	//SmtApproval = 3,
	//SubmittedToEit = 4,
	//Cancelled = 5,

	var self = this;

	self.cache = [];

	self.isUpdatingCache = false;

	self.settings = {};

	self.statuses = {
		draft: 1,
		nextLevelApproval: 2,
		smtApproval: 3,
		submittedToEit: 4,
		cancelled: 5,
		denied: 6,
	}

	self.urls = {
		base: null,
		token: null,
		requests: null,
		datatables: {
			projectrequests: null,
		},
		fileUpload: null
	}

	self.init = function (options) {
		options = options || {};
		options.urls = options.urls || {};
		options.urls.base = 'http://localhost:12859/';

		self.urls = {
			base: options.urls.base,
			requests: 'api/requests',
			datatables: {
				projectrequests: 'api/datatables/projectrequests',
			},
			fileUpload: 'http://localhost:50967/api/documents'
		}
	}

	self.getAllProjectRequests = function () {
		var promise = $http({
			method: 'GET',
			url: self.baseUrl + self.urls.requests,
			//withCredentials: true,
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
				'Authorization': 'Bearer ' + authenticationService.user['access_token'],
			},
			data: 'grant_type=password&username=kaint&password=',
		});

		promise.success(function (response, status, config, headers) {
			self.logSuccessCall('authenticate.succeeded', response, status, config, headers);

			self.user = response.data;

			$rootScope.$broadcast('projectRequestService:authenticateSucceeded');
		});
		
		promise.error(function (msg, statusCode, anonymousFunc) {
			self.logFailedCall('getAllProjectRequests.failed', msg, status, anonymousFunc);

			$rootScope.$broadcast('projectRequestService:authenticateFailed');
		});

		promise.finally(function (one, two, three, four) {
			$rootScope.$broadcast('projectRequestService:authenticateCommandExecuted');
		});

		return promise;
	}

	self.getProjectRequest = function (userRequestId) {
		return $http({
			method: 'GET',
			url: self.urls.base + self.urls.requests + '/' + userRequestId,
			//withCredentials: true,
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
				'Authorization': 'Bearer ' + authenticationService.user['access_token'],
			},
			data: 'grant_type=password&username=kaint&password=',
		});
	}

	self.createNewRequest = function (projectRequest) {
		var promise = $http({
			method: 'POST',
			url: self.urls.base + self.urls.requests,
			headers: {
				'Content-Type': 'application/json; charset=UTF-8',
				'Authorization': 'Bearer ' + authenticationService.user['access_token'],
			},
			data: JSON.stringify(projectRequest),
		});

		promise.error(function (response, status, config, headers) {
			self.logSuccessCall('saverequest.succeeded', response, status, config, headers);
		});
		
		promise.success(function (msg, statusCode, anonymousFunc) {
			self.logFailedCall('saverequest.succeeded', msg, status, anonymousFunc);
		});
			
		return promise;
	}

	self.updateRequest = function (projectRequest) {
		var promise = $http({
			method: 'PUT',
			url: self.urls.base + self.urls.requests,
			headers: {
				'Content-Type': 'application/json; charset=UTF-8',
				'Authorization': 'Bearer ' + authenticationService.user['access_token'],
			},
			data: JSON.stringify(projectRequest),
		});

		promise.error(function (response, status, config, headers) {
			self.logSuccessCall('saverequest.succeeded', response, status, config, headers);
		});

		promise.success(function (msg, statusCode, anonymousFunc) {
			self.logFailedCall('saverequest.succeeded', msg, status, anonymousFunc);
		});

		return promise;
	}

	self.logSuccessCall = function (logMsg, data, status, config, headers) {
		console.log({
				msg: logMsg,
				data: {
					result: data,
					status: status,
					config: config,
					headers: headers,
				}
			});
	}

	self.logFailedCall = function (logMsg, msg, statusCode, anonymousFunc) {
		console.log({
				msg: 'authenticate.failed',
				data: {
					msg: logMsg, 
					statusCode: statusCode, 
					anonymousFunc: anonymousFunc,
				}
			});
	}
											}]);
app.service('authenticationService', ['$http', '$q', '$rootScope', 'logService', function ($http, $q, $rootScope, logService) {
	var self = this;

	self.appRoles = {
		smt: 'smt',
		nlm: 'nlm',
		bsmt: 'bsmt',
		bnla: 'bnla',
		user: 'user',
	};

	self.urls = {
		base: null,
		token: null,
	};

	self.user = {};

	self.authenticate = function () {
		var promise = $http({
			method: 'POST',
			url: self.urls.token,
			//withCredentials: true,
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
			},
			data: 'grant_type=password&username=kaint&password=',
		});
		
		promise.then(function (response, status, config, headers) {
			logService.logMessage({
				msg: 'authenticate.succeeded',
				data: {
					response: response,
					status: status,
					config: config,
					headers: headers,
				}
			});

			self.user = response.data;

			$rootScope.$broadcast('projectRequestService:authenticateSucceeded');
		}, function (logMsg, statusCode, anonymousFunc) {
			logService.logMessage({
				msg: 'authenticate.failed',
				data: {
					msg: logMsg,
					statusCode: statusCode,
					anonymousFunc: anonymousFunc,
				}
			});

			$rootScope.$broadcast('projectRequestService:authenticateFailed');
		});

		promise.finally(function (one, two, three, four) {
			logService.logMessage({
				msg: 'authenticate.finally',
				data: {
					one: one,
					two: two,
					three: three,
					four: four
				}
			});
		});

		return promise;
	}

	self.init = function (options) {
		options = options || {};
		options.urls = options.urls || {};

		options.urls.base = options.urls.base || 'http://localhost:12859/';
		options.urls.token = options.urls.token || 'http://localhost:12859/token';

		self.urls = {
			base: options.urls.base,
			token: options.urls.token,
		}
	}
}]);

/*http://stackoverflow.com/questions/21004760/injecting-a-service-into-another-service-in-angularjs*/
app.service('documentService', ['$http', '$q', '$rootScope', 'logService', function ($http, $q, $rootScope, logService) {
	var self = this;

	self.urls = {
		base: null,
		documents: null,
	}

	self.deleteDocument = function (file) {
		var promise = $http({
			method: 'DELETE',
			url: file.url,
		});

		promise.error(function (response, status, config, headers) {
			logService.logMessage({
				msg: 'deleteAttachment.failed',
				data: {
					response: response, 
					status: status, 
					config: config, 
					headers: headers
				}
			});
		});

		promise.success(function (msg, statusCode, anonymousFunc) {
			logService.logMessage({
				msg: 'deleteAttachment.succeeded',
				data: {
					msg: msg,
					status: status,
					configanonymousFunc: anonymousFunc
				}
			});
		});

		return promise;
	}

	self.init = function (options) {
		options = options || {};
		options.urls = options.urls || {};
		options.urls.documents = options.urls.documents || 'http://localhost:50967/api/documents';

	}
}]);

app.config(function ($routeProvider, $locationProvider, $httpProvider) {

	/****disable http caching****/

	//initialize get if not there
	if (!$httpProvider.defaults.headers.get) {
		$httpProvider.defaults.headers.get = {};
	}

	// Answer edited to include suggestions from comments
	// because previous version of code introduced browser-related errors

	//disable IE ajax request caching
	$httpProvider.defaults.headers.get['If-Modified-Since'] = 'Mon, 26 Jul 1997 05:00:00 GMT';
	// extra
	$httpProvider.defaults.headers.get['Cache-Control'] = 'no-cache';
	$httpProvider.defaults.headers.get['Pragma'] = 'no-cache';

	/****routes****/

	$routeProvider.when('/', {
		templateUrl: '/app/projectRequests/requests/requests.html',
		cache: false,
	});

	$routeProvider.when('/new', {
		templateUrl: '/app/projectRequests/requests/newrequest.html',
		cache: false,
	});

	$routeProvider.when('/:projectRequestId', {
		templateUrl: '/app/projectRequests/requests/request.html',
		cache: false,
	});

	$routeProvider.otherwise({ redirectTo: '/' });

	$locationProvider.html5Mode({
		enabled: true,
		requireBase: false
	});
});

app.run(function ($templateCache, $http, $rootScope, authenticationService, projectRequestService) {
	authenticationService.init({
		urls: {
			base: 'http://localhost:12859/',
			token: 'http://localhost:12859/token',
		}
	});

	projectRequestService.init({
		urls: {
			base: 'http://localhost:12859/',
			token: 'http://localhost:12859/token',
		}
	});

    //$http.get('/app/projectRequests/requests/requests.html', { cache: $templateCache });
    //$http.get('/apps/godviewapp/appsecurity.html', { scache: $templateCache });

    $rootScope.$on("$includeContentLoaded", function (event) {
        console.log({
        	msg: '$includeContentLoaded',
        	data: {
        		event: event,
				templateName: templateName,
        	}
        });
    });
});