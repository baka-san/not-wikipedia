// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
// add jquery and boostrap
//= require jquery
//= require jquery_ujs
//= require markdown
//= require turbolinks
//= require bootstrap
//= require_tree .

var ready = function() {
  // Toggle sidebar on button click
  $("#menuToggle").click(function(e) {
      e.preventDefault();
      $("#wrapper").toggleClass("toggled");
  });

  // Toggle sidebar on window load for larger screens
  if ($(window).width() > 768) {
    $("#wrapper").addClass("toggled");
  }

  
  // Allow transition effects after page loads
  // $(window).load(function() {
  //   $("body").removeClass("preload");
  // });

  // $(".navbar-link").click(function() {
  //   $("body").addClass("preload");
  //   // $("body").removeClass("preload");
  // });



  // $("#wrapper").addClass("transitions");
  // $(".menu-toggle-button").addClass("transitions");
  // $("#sidebar-wrapper").addClass("transitions");
  // $("#page-content-wrapper").addClass("transitions");
    
  $(document).ready(function() {
    $("body").removeClass("preload");
  })

};

// Stack: rails-javascript-not-loading-after-clicking-through-link-to-helper
$(document).on('turbolinks:load', ready); 


