$.ajaxSetup({
  dataType: 'json'
});

var locationMap;

var addLocations = function() {
  $('.location').each(addLocation);
}

var addLocation = function () {
  var el = $(this);

  locationMap.addMarker({
    lat: el.data('lat'),
    lng: el.data('lng'),
    infoWindow: {
      content: $(el.data('template'))[0]
    }
  });
}

var buildMap = function () {
  $('#map').removeClass('hidden');

  locationMap = new GMaps({
    div: '#map',
    lat: 42.360331,
    lng: -71.057996,
    mapType: 'roadmap',
    zoom: 13,
    scrollwheel: false,
    disableDefaultUI: true
  });

  if ($('#location').length === 1) {
    var el = $('#location');

    locationMap.addMarker({
      lat: el.data('lat'),
      lng: el.data('lng')
    });

    locationMap.setCenter(el.data('lat'), el.data('lng'));
  } else {
    GMaps.geolocate({
      success: function(position) {
        locationMap.setCenter(position.coords.latitude, position.coords.longitude);
      },
      error: function(position) {
        locationMap.setCenter(42.360331, -71.057996);
      }
    });
  }

  $('#tableComponent').css({position: 'absolute', left: '-9999px'});
}

var enableMap = function(e) {
  e.preventDefault();
  $('.map-modal').fadeOut();
  addLocations();
  locationMap.map.set("disableDefaultUI", false);
}

var handleResponse = function() {
  $("#map").on("ajax:success", "form.button_to", function (e, data, status, xhr) {
    var el = $(this);
    var parent = el.parents('.gm-style-iw');

    // Let's remove unnecessary elements
    $('form.button_to').remove();
    $('.location-template h3').text('Thank-you for voting');
    parent.find('h3').html('Thank-you for voting for ' + parent.find('h4').text());

    // Lets track if they've voted
    localStorage.setItem('hasVoted', true);
  }).on("ajax:error", function (e, data, status, xhr) {
    alert('!uh oh!');
  });
}

var hasVoted = function () {
  var voted = localStorage.getItem('hasVoted');

  // If they've voted, hide everything
  if (voted == 'true') {
    $('.gm-style-iw .btn').remove();
  }
}

var ready = function () {
  hasVoted();
  buildMap();
  handleResponse();
  $('#mapEnable').click(enableMap);
}

$(document).ready(ready);
$(document).on('page:load', ready);
