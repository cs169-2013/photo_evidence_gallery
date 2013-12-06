var map;
var zoom;

function make_map(pins) //pins is a list of pins, a pin is the list [lat, lng, name]
{
  var mapOptions = {
    disableDefaultUI: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
  var infowindow = new google.maps.InfoWindow();
  var bounds = new google.maps.LatLngBounds();
  if (pins != null) {
    for (var i = 0; i < pins.length; i++){
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(pins[i][0], pins[i][1]),
        url: '/photos/' + pins[i][3],
        map: map
      });

      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
          infowindow.setContent('<a href="http://photoevidence.herokuapp.com'+marker.url+'">'+'Show image</a><br>' + pins[i][2]);
          infowindow.open(map, marker);
        }
      })(marker, i));
      bounds.extend(marker.position);
    }
    map.fitBounds(bounds);
    zoom = getBoundsZoomLevel(bounds);
  }
}

function getBoundsZoomLevel(bounds) {
    var WORLD_DIM = { height: 256, width: 256 };
    var ZOOM_MAX = 21;

    function latRad(lat) {
        var sin = Math.sin(lat * Math.PI / 180);
        var radX2 = Math.log((1 + sin) / (1 - sin)) / 2;
        return Math.max(Math.min(radX2, Math.PI), -Math.PI) / 2;
    }

    function zoom(mapPx, worldPx, fraction) {
        return Math.floor(Math.log(mapPx / worldPx / fraction) / Math.LN2);
    }

    var ne = bounds.getNorthEast();
    var sw = bounds.getSouthWest();

    var latFraction = (latRad(ne.lat()) - latRad(sw.lat())) / Math.PI;

    var lngDiff = ne.lng() - sw.lng();
    var lngFraction = ((lngDiff < 0) ? (lngDiff + 360) : lngDiff) / 360;

    var latZoom = zoom(100, WORLD_DIM.height, latFraction);
    var lngZoom = zoom(200, WORLD_DIM.width, lngFraction);

    return Math.min(latZoom, lngZoom, ZOOM_MAX);
}
