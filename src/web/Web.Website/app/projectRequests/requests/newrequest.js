/// <reference path="C:\projects\Applications\ITGov\Dev-ProjectManagement\ITGov.Project.Web\Scripts/angular.js" />
/// <reference path="C:\projects\Applications\ITGov\Dev-ProjectManagement\ITGov.Project.Web\Scripts/angular-route.js" />

var NewRequestViewModel = function ($timeout, $scope, $http, $window, projectRequestService, authenticationService, documentService) {
	var self = this;

	self.title = 'New Project Request';

	self.projectRequest = {
		title: null,
		description: null,
		status: null,
		requestedBy: null,
		contacts: [],
		workInProgressContacts: [],
		attachments: [],
		benefit: null,
		description: null,
		workInProgressInfo: null,
		additionalComments: null,
		isCriticalDeadline: null
	}

	self.nonEditableEmployee = angular.copy(self.projectRequest);

	self.attachmentVm = new AttachmentsViewModel($scope, projectRequestService, documentService);
	self.detailsVm = new DetailsViewModel($scope);

	var _onProjectSaved = function (data, status, config, headers) {
		console.log({
			msg: '_onProjectSaved',
			data: data,
		});

		$window.location.href = '/' + data.UserRequestId;
	}

	var _onProjectSavedFailed = function (args) {
		console.log({
			msg: '_onProjectSavedFailed',
			args: args,
		})
	}

	var _onProjectApproved = function (data, status, config, headers) {
		console.log({
			msg: '_onProjectApproved',
			data: data,
		});
	}

	var _onProjectApprovedFailed = function (args) {
		console.log({
			msg: '_onProjectApprovedFailed',
			args: args,
		});
	}

	var _getProjectRequestData = function () {
		self.detailsVm.setProjectRequestData();
		
		self.projectRequest.contacts = self.detailsVm.contacts;
		self.projectRequest.workInProgressContacts = self.detailsVm.workInProgressContacts;
		self.projectRequest.requestedBy = self.detailsVm.requestedBy;

		self.projectRequest.attachments = [];
		
		for (var fileName in self.attachmentVm.attachments) {
			self.projectRequest.attachments.push(self.attachmentVm.attachments[fileName].documentId);
		}
	}

	self.save = function () {
		_getProjectRequestData();

		self.projectRequest.status = "Draft";

		self.nonEditableEmployee = angular.copy(self.projectRequest);

		projectRequestService.createNewRequest(self.projectRequest).then(_onProjectSaved, _onProjectSavedFailed);
	}

	self.approve = function () {
		_getProjectRequestData();

		self.projectRequest.status = "UserApproved";

		projectRequestService.createNewRequest(self.projectRequest).then(_onProjectApproved, _onProjectApprovedFailed);
	}

	self.cancel = function () {
		console.log(self);

		$window.history.back();
	}

	self.init = function () {
		$timeout(function () {
			$.support.cors = true;

			$.ajaxSetup({
				cache: false,
				//xhrFields: {
				//	withCredentials: true
				//}
			});

			self.detailsVm.init();
			self.attachmentVm.init();

		}, 0);
	}

	self.onViewSown = function () {
		$scope.$parent.$parent.mvm.header.myProjectRequestStyle = '';

		authenticationService.authenticate();
	}

	self.init();
};

var DetailsViewModel = function ($scope) {
	var self = this;

	self.$scope = $scope;

	self.title = 'Details';

	self.requestedBySelect2 = new Select2Control({
		select2Target: '#requested-by',
		select2Settings: {
			placeholder: 'user name',
			allowClear: false,
			tags: false,
			multiple: false,
			tokenSeparators: [',', ' '],
			minimumInputLength: 2,
			minimumResultsForSearch: 1,
			delay: 500,
			ajax: self.ajaxSettings,
		},
		ajaxSettings: {
			url: 'http://localhost:12859/api/search/users',
			type: 'GET',
			dataType: 'json',
			cache: false,
		},
		disableSearchResults: false,
	});

	self.contactsSelect2 = new Select2Control({
		select2Target: '#contact-person',
		select2Settings: {
			placeholder: 'contacts',
			allowClear: true,
			tags: false,
			multiple: true,
			tokenSeparators: [',', ' '],
			minimumInputLength: 2,
			minimumResultsForSearch: 1,
			delay: 500,
			ajax: self.ajaxSettings,
		},
		ajaxSettings: {
			url: 'http://localhost:12859/api/search/users',
			type: 'GET',
			dataType: 'json',
			cache: false,
		},
		disableSearchResults: false,
	});

	self.workInProgresscontactsSelect2 = new Select2Control({
		select2Target: '#work-in-progress-contact-person',
		select2Settings: {
			placeholder: 'click me end start entering a name',
			allowClear: true,
			tags: false,
			multiple: true,
			tokenSeparators: [',', ' '],
			minimumInputLength: 2,
			minimumResultsForSearch: 1,
			delay: 500,
			ajax: self.ajaxSettings,
		},
		ajaxSettings: {
			url: 'http://localhost:12859/api/search/users',
			type: 'GET',
			dataType: 'json',
			cache: false,
		},
		disableSearchResults: false,
	});

	self.setProjectRequestData = function () {
		self.requestedBy = null;

		for (var contact in self.requestedBySelect2.items) {
			self.requestedBy = self.requestedBySelect2.items[contact].id;
		}

		self.contacts = [];

		for (var contact in self.contactsSelect2.items) {
			self.contacts.push(self.contactsSelect2.items[contact].id);
		}

		self.workInProgressContacts = [];

		for (var contact in self.workInProgresscontactsSelect2.items) {
			self.workInProgressContacts.push(self.workInProgresscontactsSelect2.items[contact].id);
		}
	}

	self.init = function () {
		self.contactsSelect2.init();
		self.workInProgresscontactsSelect2.init();
		self.requestedBySelect2.init();

		/*eiditor*/
		$('.description').summernote({ height: 150 });

		$('.date-picker').datepicker();
	}
}

var AttachmentsViewModel = function ($scope, projectRequestService, documentService) {
	var self = this;

	self.title = 'Attachments';

	self.$scope = $scope;

	self.attachments = {};

	self.fileUpload = null;

	self.fileuploadDragOverStyle = '';

	self.rowDragHereStyle = '';
	self.rowListStyle = 'hide';
	self.uploadProgress = '';

	var _onFileUploadDrop = function (e, data) {
		if (self.rowDragHereStyle === '') {
			self.rowDragHereStyle = 'hide';
			self.rowListStyle = '';
		}

		data.files.forEach(function (file, index) {
			file.progressBarClassStyle = 'progress-bar-darkorange';
			self.attachments[file.relativePath + file.name] = file;
		});

		console.log({ msg: 'fileuploaddrop', data: { event: e, data: data } });

		self.$scope.$apply();
	}

	var _onFileDragOver = function (e) {
		console.log({
			msg: 'fileuploaddragover',
			e: e
		});
	}

	var _onFileUploadProgressAll = function (e, data) {
		var progress = data.loaded / data.total;
		var timeSpent = new Date().getTime() - data.submitted;
		var secondsRemaining = Math.round(((timeSpent / progress) - timeSpent) / 1000);

		console.log({ msg: 'fileuploadprogressall', data: { event: e, data: data, progress: progress , timeSpent: timeSpent, secondsRem: secondsRemaining} });
		//self.uploadProgress = { event: e, data: data, progress: progress, timeSpent: timeSpent, secondsRem: secondsRemaining };
		//self.$scope.$apply();
	}

	var _onFileUploadProgress = function (e, data) {
		var file = data.files[0];

		console.log({ msg: 'fileuploadprogress', data: { event: e, data: data } });

		var progress = data.loaded / data.total;
		var timeSpent = new Date().getTime() - data._time;
		var secondsRemaining = Math.round(((timeSpent / progress) - timeSpent) / 1000);

		self.attachments[file.relativePath + file.name].progress = progress * 100
		self.attachments[file.relativePath + file.name].progressRounded = (progress * 100).toFixed(2);
		self.attachments[file.relativePath + file.name].timeSpent = timeSpent;
		self.attachments[file.relativePath + file.name].secondsRemaining = secondsRemaining;
		self.$scope.$apply();
	}

	var _onFileUploadDone = function (e, data) {
		var file = data.files[0];
		var result = JSON.parse(data.result);
		//self.attachments.push(data.result);
		//$('#fileupload').hide();

		self.attachments[file.relativePath + file.name].progressBarClassStyle = 'progress-bar-success';
		self.attachments[file.relativePath + file.name].documentId = result[0].documentId;
		self.attachments[file.relativePath + file.name].url = result[0].url;

		console.log({ msg: 'fileuploaddone', data: { event: e, data: data } });

		self.$scope.$apply();
	}

	self.chooseFile = function () {
		console.log('choose clicked');
	}

	self.deleteAttachment = function (attachment) {
		//if document doesn't exist
		//save

		//else show popup message saying you can't upload
		documentService.deleteDocument(attachment).success(function () {
			delete self.attachments[attachment.relativePath + attachment.name];

			if (Object.keys(self.attachments).length == 0) {
				self.rowDragHereStyle = '';
				self.rowListStyle = 'hide'
			}
		});

		console.log({
			msg: 'attachment deleted',
			attacment: attachment
		});
	}

	self.editAttachment = function (attachment) {
		console.log({
			msg: 'attachment edited',
			attacment: attachment
		});
	}

	self.init = function () {
		$(document).bind('dragover', function (e) {
			var dropZone = $('#fileupload'),
				timeout = window.dropZoneTimeout;
			if (!timeout) {
				dropZone.addClass('in');
			} else {
				clearTimeout(timeout);
			}
			var found = false,
				node = e.target;
			do {
				if (node === dropZone[0]) {
					found = true;
					break;
				}
				node = node.parentNode;
			} while (node != null);
			if (found) {
				dropZone.addClass('hover');
			} else {
				dropZone.removeClass('hover');
			}
			window.dropZoneTimeout = setTimeout(function () {
				window.dropZoneTimeout = null;
				dropZone.removeClass('in hover');
			}, 100);
		});

		//$('#fileupload').hover(_onFileDragOver);

		/*file upload*/
		self.fileUpload = $('#fileupload').fileupload({
			url: projectRequestService.urls.fileUpload,
			// In order for chunked uploads to work in Mozilla Firefox, 
			// the multipart option has to be set to false. This is due to 
			// the Gecko 2.0 browser engine - used by Firefox 4+ - adding blobs 
			// with an empty filename when building a multipart upload request 
			// using the FormData interface
			//multipart: false,
			autoUpload: false,
			maxChunkSize: 10000000, // Defaults to 10 MB 
			beforeSend: function (jqXHR, settings) {
				console.log({
					msg: 'fileupload.beforesend',
					jqXhr: jqXHR,
					settings: settings
				});

				intErrorType = 0;
				intDocumentID = 0;
				intUploadFileSize = 0;
				strUploadFileName = _getFileName(settings.files[0]);
				strUploadFilePath = '';
				$('#lblAttachmentMessage').removeClass('redText').html('');

				//console.log({
				//    evt: 'beforesent',
				//    jqXHR: jqXHR,
				//    settings: settings
				//});

				if (intErrorType == 0) {
					// display loading
					jqXHR.setRequestHeader('X-File-Size', settings.files[0].size);
					jqXHR.setRequestHeader('X-Created-By', $('#hfDomainLogin').val());

					//after first chunk is sent the rest of the chunks will have a documentid
					if (settings.files[0].documentId)
						jqXHR.setRequestHeader('X-Document-Id', settings.files[0].documentId);

					//if settings.chunkSize contains a value this means we are sending a chunk to the server
					if (settings.chunkSize) {
						jqXHR.setRequestHeader('X-Chunked-File-Name', _getChunkedFileName(settings));
						jqXHR.setRequestHeader('X-Current-Chunk-Index', _getCurrentChunkIndex(settings));//settings.chunkIndex);
						jqXHR.setRequestHeader('X-Total-Chunks', _getTotalChunks(settings));//settings.chunksNumber);
						jqXHR.setRequestHeader('X-Is-Final-Part', _isFinalPart(settings));
					}
					else {
						jqXHR.setRequestHeader('X-Total-Chunks', 1);
					}
				}
			},
			fail: function (e, data) {
				console.log({
					msg: 'fileupload.fail',
					data: data
				});
			},
			add: function (e, data) {
				console.log({
					msg: 'fileupload.add',
					data: data
				});
				data.submit();
			}
		})
		// Callback for successful chunk uploads:
		// chunkdone: function (e, data) {}, // .bind('fileuploadchunkdone', func);
		.bind('fileuploadchunkdone', function (e, data) {
			//server will return the documentid once it finished uploading the chunk
			//data.files[0].documentId = data.result[0].documentId;
			var arrData = JSON.parse(data.result)
			data.files[0].documentId = arrData[0].documentId;
		})
		// Callback for successful uploads:
		// done: function (e, data) {}, // .bind('fileuploaddone', func);
		.bind('fileuploaddone', _onFileUploadDone)
		// Callback for drop events of the dropZone(s):
		// Callback for drop events of the dropZone(s):
		.bind('fileuploaddrop', _onFileUploadDrop)
		.bind('fileuploadprogress', _onFileUploadProgress)
		.bind('fileuploadprogressall', _onFileUploadProgressAll)
		.bind('fileuploadstart', function (e, data) {
			console.log({ msg: 'fileuploadstart', data: { event: e, data: data } });
		});



		// Callback for upload progress events:
		// progress: function (e, data) {}, // .bind('fileuploadprogress', func);

		// Callback for global upload progress events:
		// progressall: function (e, data) {}, // .bind('fileuploadprogressall', func);

		// Callback for uploads start, equivalent to the global ajaxStart event:
		// start: function (e) {}, // .bind('fileuploadstart', func);

		// Enable iframe cross-domain access via redirect option:
		$('#fileupload').fileupload(
			'option',
			'redirect',
			window.location.href.replace(
				/\/[^\/]*$/,
				'/cors/result.html?%s'
			));

		var _getCurrentChunkIndex = function (settings) {
			var startBytes = parseInt(settings.contentRange.substring(settings.contentRange.indexOf(' ') + 1, settings.contentRange.indexOf('-')));
			var endBytes = parseInt(settings.contentRange.substring(settings.contentRange.indexOf('-') + 1, settings.contentRange.indexOf('/')));
			if (endBytes + 1 == settings.total)
				return startBytes / settings.maxChunkSize;
			return startBytes / settings.chunkSize;
		}

		var _isFinalPart = function (settings) {
			var startBytes = parseInt(settings.contentRange.substring(settings.contentRange.indexOf(' ') + 1, settings.contentRange.indexOf('-')));
			var endBytes = parseInt(settings.contentRange.substring(settings.contentRange.indexOf('-') + 1, settings.contentRange.indexOf('/')));
			if (endBytes + 1 == settings.total)
				return true
			return false;
		}

		var _getTotalChunks = function (data) {
			var file = data.files[0];
			return Math.ceil(file.size / data.chunkSize);
		}

		var _generateUniqueFileName = function (data) {
			var file = data.files[0];
			var fileName = file.relativePath || file.webkitRelativePath || file.fileName || file.name;
			//result.replace(/[^0-9a-zA-Z_-]/img, "") + "-" + file.size + "_" + _getCurrentChunkIndex(data);
			var uniqueFileName = fileName + '.' + new Guid().newGuid();
			return uniqueFileName;
		}

		var _getChunkedFileName = function (data) {
			var file = data.files[0];
			var fileName = file.relativePath || file.webkitRelativePath || file.fileName || file.name;
			var uniqueFileName = fileName + "." + _getCurrentChunkIndex(data).toString();
			return uniqueFileName;
		}

		var _getFileName = function (file) {
			return file.relativePath || file.webkitRelativePath || file.fileName || file.name;
		}
	}
}

app.controller('NewRequestViewModel', [
	'$timeout',
	'$scope',
	'$http',
	'$window',
	'projectRequestService',
	'authenticationService',
	'documentService',
	NewRequestViewModel
]);