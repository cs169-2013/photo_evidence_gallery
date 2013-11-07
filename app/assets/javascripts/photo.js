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




