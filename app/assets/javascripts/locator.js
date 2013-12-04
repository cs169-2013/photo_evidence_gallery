$(document).ready(function () {
  $("#coorbutton").click(function(e) {
    var x=$("#coorbutton");
    function getLocation()
      {
      x.prop('value', "Locating....");
      if (navigator.geolocation)
        {
        navigator.geolocation.getCurrentPosition(showPosition);
        }
      else{x.prop('value', "Geolocation is not supported by this browser.");}
      }
    function showPosition(position)
    {
      x.prop('value', "Success");
      $("#photo_lat").val(position.coords.latitude);
      $("#photo_lng").val(position.coords.longitude);
      $("#photos_lat").val(position.coords.latitude);
      $("#photos_lng").val(position.coords.longitude);
    }
    getLocation();
      
      
  });
});



