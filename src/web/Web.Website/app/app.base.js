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