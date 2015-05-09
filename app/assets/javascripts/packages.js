var PackagesNew = new function() {

    /**
     * Init bindins,
     * called from page load event fired from application.js
     */
    var init = function() {
        var platform = $('#platform_search');
        var platformResults = $('#results');

        platform.on('keyup', searchPlatform);
        platformResults.on('click', '.platform', platformClickHandler);
    };

    var platformClickHandler = function(event) {
        var target = event.currentTarget;
        $('#package_platform_id').val(target.id);
        $('#platform_search').val(target.getAttribute('data-name'));
    };

    var searchPlatform = function(event) {
        var text = event.currentTarget.value;
        if (text.length <= MIN_SEARCH) {
            return;
        }

        var query = {
            text: text
        };

        ajax('platforms', query, receivePlatform);
    };

    var receivePlatform = function(error, data) {
        if (error) {
            return console.log(error);
        }

        var results = $('#results');
        results.empty();
        var fragment = document.createDocumentFragment();
        var map = function(item) {
            var li = document.createElement('li');
            li.id = item.id;
            li.textContent = [item.name, item.codename, item.version].join(' ');
            li.className = 'platform';
            li.setAttribute('data-name', item.name);
            fragment.appendChild(li);
        };
        data.map(map);
        results.append(fragment);
    };
};

var PackagesEdit = PackagesNew;
var PackagesUpdate = PackagesNew;