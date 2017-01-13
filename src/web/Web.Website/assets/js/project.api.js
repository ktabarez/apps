var ProjecRequestApi = {
        self: this,
		cache: [],
		isUpdatingCache: false,
		urls: {
		    requests: 'api/requests',
		},
	    options:{
	        cacheRefreshintervalInSeconds: 1,
            baseUrl: 'http://localhost:12859/',
	    },
		init: function (options) {
		    this.options = options;
		},
		getAll: function () {
		    ProjecRequestApi.isUpdatingCache = true;

		    var dfd = $.ajax({
		        url: options.baseUrl +  self.urls.requests,
		        method: 'GET',
		        dataType: 'json'
		    });

		    dfd.done(function (data) {
		        ProjecRequestApi.cache = data;
		    });

		    dfd.always(function () {
		        ProjecRequestApi.isUpdatingCache = false;
		    })

		    return dfd.promise();
		},
		get: function (projectRequestId) {
		    var dfd = new $.Deferred();

		    ProjecRequestApi.isUpdatingCache = true;

		    if (ProjecRequestApi.cache[projectRequestId]){
		        dfd.resolve([cache[projectRequestId]]);
                dfd.always(function () { ProjecRequestApi.isUpdatingCache = false }, [ProjecRequestApi.cache[projectRequestId], 'project request pulled from cache', null]);
		    }
            else{
		        var ajaxDfd = $.ajax({
		            url: options.baseUrl +  self.urls.requests,
		            method: 'GET',
				    contentType: 'application/json',
                    dataType: 'json',
		        });

		        ajaxDfd.done(function (data, textStatus, jqXhr) {
		            dfd.resolve([data, textStatus, jqXhr]);
                    dfd.always(function () { ProjecRequestApi.isUpdatingCache = false }, [data, textStatus, jqXhr]);
		        });

		        ajaxDfd.fail(function (jqXhr, textStatus, errorThrown) {
		            dfd.reject([jqXhr, textStatus, errorThrown]);
		            dfd.always(function () { ProjecRequestApi.isUpdatingCache = false }, [jqXhr, textStatus, errorThrown]);
		        });
            }

			return dfd.promise();
		},
		put: function (projectRequest) {
		    ProjecRequestApi.isUpdatingCache = true;

		    var dfd = $.ajax({
		        url: options.baseUrl +  self.urls.requests + '/' + projectRequest.id,
		        method: 'PUT',
                contentType: 'application/json',
                dataType: 'json',
                data: projectRequest,
		    });

		    dfd.done(function (data) {
		        ProjecRequestApi.cache[projectRequest.id] = projectRequest;
		    });

		    dfd.always(function (data, textStatus, jqXhr) {
		        ProjecRequestApi.isUpdatingCache = false
		    });

		    return dfd.promise();
		},
		post: function(projectRequest){
			ProjecRequestApi.isUpdatingCache = false;

			var dfd = $.ajax({
			    url: ProjecRequestApi.options.baseUrl + ProjecRequestApi.urls.requests,
			    method: 'POST',
			    contentType: 'application/json',
			    dataType: 'json',
			    data: JSON.stringify(projectRequest),
			});

			dfd.done(function (data, textStatus, jqXhr) {
			    ProjecRequestApi.cache[data.id] = data;
			});

			dfd.always(function () {
			    ProjecRequestApi.isUpdatingCache = false;
                console.log(data, textStatus, jqXhr);
			})

			return dfd.promise();
		},
		startBackgroundCacheRefreshThread: function () {
			setTimeout(function () {
				if (ProjecRequestApi.isUpdatingCache)
				    return;

			}, ProjecRequestApi.options.cacheRefreshintervalInSeconds * 1000);
		},
	}