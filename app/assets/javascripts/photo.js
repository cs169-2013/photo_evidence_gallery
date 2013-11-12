$(document).ready(function () {

  jQuery(function($){

    var jcrop_api;
    var golden = 1.618
    $('#cropbox').Jcrop({
      aspectRatio: 1,
      setSelect: [0, 0, 600, 600],
      onChange: update,
      onSelect: update
    },function(){
      jcrop_api = this;
    });

  $("#rotate90").rotate(90);
  $("#rotate180").rotate(180);
  $("#rotate270").rotate(270);
  
  
  $("#rotate0").click(function(e) {
    $('#photo_rotation').val(0);
  });
  $("#rotate90").click(function(e) {
    $('#photo_rotation').val(90);
  });
  $("#rotate180").click(function(e) {
    $('#photo_rotation').val(180);
  });
  $("#rotate270").click(function(e) {
    $('#photo_rotation').val(270);
  });
  $("#coorbutton").click(function(e) {
    var x=document.getElementById("Locator");
    function getLocation()
    {
      x.innerHTML="Locating....";
    if (navigator.geolocation)
      {
      navigator.geolocation.getCurrentPosition(showPosition);
      }
    else{x.innerHTML="Geolocation is not supported by this browser.";}
    }
    function showPosition(position)
    {
      x.innerHTML="Success";
      $('#photo_lat').val(position.coords.latitude);
      $('#photo_lng').val(position.coords.longitude);
    }
    getLocation();
      
      
  });

  $('#square').change(function(e) {
    jcrop_api.setOptions(this.checked? { aspectRatio: 1 }: { aspectRatio: 0 });
    jcrop_api.focus();
  });  
  $('#portrait').change(function(e) {
    jcrop_api.setOptions(this.checked? { aspectRatio: 1 / golden }: { aspectRatio: 0 });
    jcrop_api.focus();
  });  
  $('#landscape').change(function(e) {
    jcrop_api.setOptions(this.checked? { aspectRatio: golden }: { aspectRatio: 0 });
    jcrop_api.focus();
  });   
  $('#freecrop').change(function(e) {
    jcrop_api.setOptions(this.checked? { aspectRatio: 0 }: { aspectRatio: 0 });
    jcrop_api.focus();
  });
  });

  function update(c){
    $('#photo_crop_x').val(c.x)
    $('#photo_crop_y').val(c.y)
    $('#photo_crop_w').val(c.w)
    $('#photo_crop_h').val(c.h) 
  }
});



