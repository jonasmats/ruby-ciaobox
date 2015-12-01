$=jQuery;

/*function to calculate tatal cost*/
function cost($quatity, $price) {
    $TotalCost += $price * $quatity;
}
function total_cost() {
    $TotalCost = 0;
    $(".store-box-text input").each(function(){
        if ($(this).parents(".like-to-store").hasClass("section-review") && $(this).parents(".store-box-text").prev().css("display") == "block" ) {
            $quantity = $(this).parents(".store-box-text").prev().find(".re-quantity").text();
        } else $quantity = $(this).val();
        
        if ( $.isNumeric($quantity) ) {
            $store_cost = parseFloat( $(this).parent().parent().parent().find("span .store-cost").text() );
            cost($quantity, $store_cost);
        };
    });
    /*for orther item*/
    $TotalCost += 6.25 * ($("#other-item-tags .other-item:last-child()").index() + 1);

    $(".month-total-cost").text($TotalCost);
}
/*--End function--*/

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
   
    /************* Edit shedule.html 24/11/2015 *****************/

    /*--caculate total cost--*/
    $(".store-box-text input").bind("change", function(){
        total_cost();
    });

    /*for checkbox */
    $(".detail-radio-div").click(function(){
        $(this).parent().find(".detail-radio-div").removeClass("checked");
        $(this).addClass("checked");
    });

    /*when hover store-box*/
    $(".store-box-text").hover(function(){
        $(this).addClass("overlay");
    }, function(){
        $(this).removeClass("overlay");
    });

    /*when click store-box*/
    $(".section-schedule .store-box-normal").click(function(){

        if ( $(this).hasClass("store-box-orther") ) {
            $(this).addClass("overlay-forever");
            $("#form-overbottom").slideDown();
        };
        $(this).next().addClass("store-box-normal");
        $(this).next().find("input").val("1");

        if ( $(this).hasClass("store-make-space")) {
            $(this).next().find("input").val("4");
            $("#form-overhead").slideDown();
        };

        $(this).removeClass("store-box-normal");
        /*--caculate total cost--*/
        total_cost();

    });

    /*when click plus*/
    $(".js-nav-plus").click(function(){
        $(this).parent().find("input").val( function(i, oldval) {
            return ++oldval;
        });
        /*--caculate total cost--*/
        total_cost();

    });
    /*when click min*/
    $(".js-nav-min").click(function(){
        $(this).parent().find("input").val( function(i, oldval) {
            if( oldval == 1 ) {
                $(this).parent().parent().parent().find(".store-box-normal").removeClass("store-box-normal");
                $(this).parent().parent().parent().find(".store-box-first").addClass("store-box-normal");
                if ( $(this).parent().parent().prev().hasClass("store-make-space") ) 
                    $("#form-overhead").slideUp();
            } else return --oldval;
        });
        /*--caculate total cost--*/
        total_cost();
    });

    /*change value of input*/
    $(".input-copy-wrapper input").keyup(function(){
        if ( $(this).val() <= 0 || !$.isNumeric($(this).val()) ) {
            $(this).parent().parent().parent().find(".store-box-normal").removeClass("store-box-normal");
            $(this).parent().parent().parent().find(".store-box-first").addClass("store-box-normal");
            if ( $(this).parent().parent().prev().hasClass("store-make-space") ) 
                $("#form-overhead").slideUp();
        };
    });

    /*for add other item*/
    $("#input-other-item button").click(function(e){
        e.preventDefault();
        $nameItem = $("#input-other-item input").val();
        if ( !$nameItem.match(/^\s*$/) ) {
            $("#other-item-tags").append("<div class='other-item'><a class='remove-item'>×</a><span>"+$nameItem+"</span></div>");
            $("#input-other-item input").val('');
            /*--caculate total cost--*/
            total_cost();
        };
    }); 

    /************* Edit review.html 30/11/2015 *****************/

    $(".section-review .re-remove").click(function(e){
        $(this).parent().parent().parent().parent().remove();
        /*--caculate total cost--*/
        total_cost();
    }); 

    $(".section-review .re-edit").click(function(e){
        
        $(this).parent().parent().parent().next().addClass("store-box-normal");
        $re_quantity = $(this).parent().parent().parent().find(".re-quantity").text();
        if ($.isNumeric($re_quantity)) {
            $(this).parent().parent().parent().next().find("input").val($re_quantity);
        }

        $(this).parent().parent().parent().removeClass("store-box-normal");

    }); 

});/*--End---*/

/*remove orther item dynamically*/
$(document).on('click', 'a.remove-item', function(){
    $(this).parent().remove();
    /*--caculate total cost--*/
    total_cost();
});
