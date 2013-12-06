var map;

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
          //infowindow.setContent(pins[i][2] + '<br> <a href="localhost:3000'+marker.url+'">'+'Show image</a>');
          infowindow.open(map, marker);
        }
      })(marker, i));
      var hi = new google.maps.LatLng(pins[i][0], pins[i][1]);
      bounds.extend(hi);
    }
    map.fitBounds(bounds);
  }
}