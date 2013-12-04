$(document).ready(function () {
	var angle=0;
  
  $("#right").click(function(e) {
  	angle += 90;
  	$('#picture').rotate(angle);
    $('#photo_rotation').val(angle);
  });
  $("#left").click(function(e) {
  	if (angle >= 90){
  		angle -= 90;
  	}else{
	  	angle += 270;
	  }
  	$('#picture').rotate(angle);
    $('#photo_rotation').val(angle);
  });
});
