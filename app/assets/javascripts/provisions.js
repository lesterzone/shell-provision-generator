var ProvisionsNew = new function() {
    var packageCollection = {};
    var platformsCollection = {};
    var addedCollection = {};
    var platformId = null;

    this.init = function() {
        var inputPackage = $('#search_package');
        var inputPlatform = $('#search_platform');

        $('#packages').on('click', '.package', packageClickHandler);
        $('#platforms').on('click', '.platform', platformClickHandler);

        inputPackage.on('keydown', getPackages);
        inputPlatform.on('keydown', getPlatforms);
    };

    var getPlatforms = function(event) {
        var text = event.currentTarget.value;
        if (text.length <= MIN_SEARCH) {
            return;
        }

        var query = {
            search: text
        };

        ajax('platforms', query, receivePlatforms);
    };

    var receivePlatforms = function(error, data) {
        if (error) {
            return console.log(error);
        }

        var results = $('#platforms');
        results.empty();
        var fragment = document.createDocumentFragment();
        var map = function(item) {
            platformsCollection[item.id] = item;
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

    var receivePackages = function(error, data) {
        if (error) {
            return console.log(error);
        }

        var results = $('#packages');
        results.empty();

        var fragment = document.createDocumentFragment();
        var map = function(item) {
            packageCollection[item.id] = item;
            var li = document.createElement('li');
            var anchor = document.createElement('a');
            anchor.id = item.id;
            anchor.className = 'package';
            anchor.textContent = item.name + ' version: ' + item.version;
            anchor.setAttribute('data-name', item.name);
            li.appendChild(anchor);

            fragment.appendChild(li);
        };
        data.map(map);
        results.append(fragment);
    };

    var packageClickHandler = function(event) {
        var id = event.currentTarget.id;
        addedCollection[id] = packageCollection[id];
        $(event.currentTarget).remove();
        $('#search_package').val('');
        $('#search_package').focus();
        setScript();
    };

    var platformClickHandler = function(event) {
        platformId = event.currentTarget.id;
        var item = platformsCollection[platformId];
        var value = [item.name, item.codename, item.version].join(' ');
        $('#search_platform').val(value);
        $('#platforms').empty();
        setScript(true);
    };

    var setScript = function(shouldEmpty) {
        var provision = $('#provision_script');
        if(shouldEmpty){
            return provision.val('');
        }
        var height = provision.height();

        var map = function(pkg) {
            return addedCollection[pkg].install;
        };
        var script = Object.keys(addedCollection).map(map).join(" && \n");
        provision.height(height + 4);
        provision.val(script.trim());
    };

    var getPackages = function(event) {
        var text = event.currentTarget.value;

        if (text.length <= MIN_SEARCH) {
            return;
        }
        var query = {
            search: text,
            platformId: platformId
        };

        ajax('packages', query, receivePackages);
    };
};