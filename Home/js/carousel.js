$(document).ready(function(){
	$('.phone').on('click', '.control button', function(){
		//Set variables
		var count = parseInt($(this).parents('.phone').find('.carousel').attr('data-count'));
		var current = parseInt($(this).parents('.phone').find('.carousel').attr('data-current'));

		if( current + 1 > count ) { var marker = 1; }
		else{ var marker = current + 1; }
		
		// Move to right
			$(this).parents('.phone').find('.carousel .items .item[data-marker="'+current+'"]').removeClass('center').removeClass('center-left').removeClass('center-right').removeClass('right-center').removeClass('left-center').addClass('center-left');
			$(this).parents('.phone').find('.carousel .items .item[data-marker="'+marker+'"]').removeClass('center').removeClass('center-left').removeClass('center-right').removeClass('right-center').removeClass('left-center').addClass('right-center');
		//-----------------------------------------------
		
		//Set data
		$(this).parents('.phone').find('.carousel').attr('data-current', marker);


		//Set markers
		$(this).parents('.phone').find('.carousel .markers > li').removeClass('active');
		$(this).parents('.phone').find('.carousel .markers > li[data-marker="'+marker+'"]').addClass('active');
	});

	//Swipe
		//Swipe function
			$(function() {
					//Click
						$(".carousel").swipe( { fingers:'all', swipeStatus:swipePartners, allowPageScroll:"vertical"} );
						
						function swipePartners(event, phase, direction, distance) {
							if( phase == 'start' || phase == 'move' ){
								//console.log( phase +" you have swiped " + distance + "px in direction:" + direction );

								//Set offset-------------------------------------
								if( phase == 'move' ){
										$('.phone').find('.control button').trigger('click');
										return false;
								}
							}
						}
					//Click
			});
		//Swipe function
//Swipe
});
