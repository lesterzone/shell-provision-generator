// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require turbolinks
//= require_tree .

var MIN_SEARCH = 2;

var ajax = function(path, query, callback) {
    $.ajax({
        url: '/' + path,
        data: query,
        success: function(data) {
            callback(null, data);
        },
        error: function(error) {
            callback(error);
        }
    });
};

$(document).on('ready page:load', function() {
    var page = $('body').data('page');
    if ('object' === typeof window[page]) {
        window[page] && window[page].init && window[page].init();
    }
});