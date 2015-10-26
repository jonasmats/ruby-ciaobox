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

    $(".question-answer").click(function(e) {
      e.preventDefault();
      $(this).find(".question").toggleClass("selected");
      $(this).find(".answer").slideToggle();

    });

     /*var link = $(".question-answer a"); 

    link.click(function(e) {
    	 e.preventDefault();
    	var a = $(this).attr("href");

        $(a).slideDown('slow');
        $(".question-type-inner div").next(".answer").not(a).slideUp('slow');

          $(".question-type-inner").first(".answer").css('display', 'block');
    
       //$(this).next(".answer").slideToggle();
       $(".question-type-inner").next(".question-answer").find(".question").toggleClass("selected");
    });
*/
   
  



});/*--End---*/



