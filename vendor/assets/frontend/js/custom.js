$=jQuery;
$(document).ready(function(){
  $(window).scroll(function(){
    if ($(window).scrollTop() >= 2) {
      $('header').addClass('sticky-header');
    }
    else {
      $('header').removeClass('sticky-header');
    }
   });
});