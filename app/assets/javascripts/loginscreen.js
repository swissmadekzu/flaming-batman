// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery_ujs
//= require minoral/bootstrap.min
//= require minoral/plugins/jquery.nicescroll.min.js
//= require minoral/plugins/blockui/jquery.blockUI.js
//= require minoral/plugins/datatables/jquery.dataTables.min.js
//= require minoral/plugins/datatables/dataTables.bootstrap.js
//= require minoral/plugins/chosen/chosen.jquery.min.js
//= require minoral/minoral.min
//= require_self

$(document)
  .on('change', '.btn-file :file', function() {
    var input = $(this),
    numFiles = input.get(0).files ? input.get(0).files.length : 1,
    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
    input.trigger('fileselect', [numFiles, label]);
  }); 

$(function(){
      
  $('.welcome').addClass('animated bounceIn');
  $(".chosen-select").chosen({disable_search_threshold: 10});
  //initialize file upload button
$('.btn-file :file').on('fileselect', function(event, numFiles, label) {
var input = $(this).parents('.input-group').find(':text'),
log = numFiles > 1 ? numFiles + ' files selected' : label;
if( input.length ) {
input.val(log);
} else {
if( log ) alert(log);
}
});
  
})