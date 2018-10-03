
$(document).ready(function() {
/**********************************************************************
 * Resources: Update resource usage panel when selected_date changes
 **********************************************************************/
$('#record_selected_date').bind('change', function() {
  var category = $('#category').val();
  window.location.href = '/resources?selected_date=' + this.value + '&category=' + category;
});

/**********************************************************************
 * Resources: Update resource usage panel when categorychanges
 **********************************************************************/
$('#category').bind('change', function() {
  window.location.href = '/resources?category=' + this.value;
});

  /*******************************************************************
  * Popup CMS edit menu option clicked
  *******************************************************************/
  $('.resources-table .usage div').on('click',function(e) {
    var url = e.target.getAttribute("data-url");
    $('#iframe_edit').attr('src', url);    
  });
});
