// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks

var sort_li = function (a, b) {
  return ($(b).data('votes')) > ($(a).data('votes')) ? 1 : -1;
}

var handleSort = function () {
  var els = Array.prototype.slice.call(document.querySelectorAll('.dashboard-item'),0);
  console.log(els.sort(sort_li));


  var els = $('.dashboard').find('.dashboard-item').sort(sort_li);
  $('.dashboard').html('').append(els);
}

$(function () {
  $('body').on('sort_list', handleSort);
})
