// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap-datepicker

$(document).ready( function() {
  $('[data-behavior~=quickdatepicker]').datepicker({autoclose: true, format: "yyyy/mm/dd"});
  $('*[data-insert-on-click]').insert_content();
  $('*[data-dismiss]').on('click', function() { $(this).closest(".alert").remove();});
});

function add_flash(message, klass) {
  var wrap = $("<div class='alert alert-"+klass+"'></div>");
  var close = $("<a class='close'>x</a>");
  close.on('click', function() { wrap.remove(); });
  wrap.append(close);
  wrap.append("<div>"+message+"</div>");
  $("#messages_container").append(wrap);
  setTimeout(function() { wrap.remove(); }, 5000);
}
