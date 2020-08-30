//Global variables
var scroll=false;

$(document).ready(function(){

	//Init
		//Svg
			//App store buttons
			$('.app-store-btns a.app-store i').load('img/svg/app-store.svg');
			$('.app-store-btns a.google-play i').load('img/svg/google-play.svg');

			//1st Screen
			$('body').find('i.icon-app').load('img/svg/app.svg');
			$('body').find('.screen i.icon-scroll').load('img/svg/mouse.svg');
			
			//3st Screen
			$('body').find('.screen i.icon-subscribe').load('img/svg/subscribe.svg');
			$('body').find('.screen i.icon-rent').load('img/svg/rent.svg');
			$('body').find('.screen i.icon-drive').load('img/svg/drive.svg');
			$('body').find('.screen i.icon-share').load('img/svg/share.svg');
	//Init

	//Scroll
		$('html,body').mousewheel(function(event) {
			if( window.scroll == false ){

				window.scroll = true;

			    var countScreens = parseInt($('.screens').find('.screen').length);
			    var currentScreen = parseInt($('.screens').find('.screen.active').attr('data-marker'));

			    if( event.deltaY==-1 ){
			    	if( currentScreen + 1 <= countScreens ){
			    		$('nav').find('li[data-marker="'+(currentScreen + 1)+'"]').trigger('click');
			    	}
			    }
			    else{
			    	if( currentScreen - 1 >= 1 ){
			    		$('nav').find('li[data-marker="'+(currentScreen - 1)+'"]').trigger('click');
			    	}
			    }

			    setTimeout(function(){
			    	window.scroll = false;
			    },1000);
			}
		});
	//Scroll

	//Navigation
		$('nav').on('click', 'ul > li', function(){
			var marker = parseInt($(this).attr('data-marker'))-1;

			//Change nav
				$(this).parent().find('li').removeClass('active');
				$(this).addClass('active');
			//Change nav

			//Change screen
				$('.screens .screen').removeClass('active');
				$('.screens .screen[data-marker="'+(marker+1)+'"]').addClass('active');

				$('.screens').css({
					'-webkit-transform' : 'translate(0, -'+(100*marker)+'%)',
					'-moz-transform' : 'translate(0, -'+(100*marker)+'%)',
					'-ms-transform' : 'translate(0, -'+(100*marker)+'%)',
					'-o-transform' : 'translate(0, -'+(100*marker)+'%)',
					'transform' : 'translate(0, -'+(100*marker)+'%)'
				});
			//Change screen


			//Change app store button
				// if( marker==4 ){
				// 	$('.brand').addClass('down');
				// 	$('.app-store-btns').addClass('up'); }
				// else{
				// 	$('.brand').removeClass('down');
				// 	$('.app-store-btns').removeClass('up'); }
			//Change app store button
		});
	//Navigation

	//Detect mobile
		if( (device.iphone() == true) || (device.ipod() == true) || (device.ipad() == true) ){
			$('.app-store-btns').find('.google-play').fadeOut('fast');
			$('body').find('canvas').remove();
		}
		else if( (device.android() == true) || (device.androidPhone() == true) || (device.androidTablet() == true) ){
			$('.app-store-btns').find('.app-store').fadeOut('fast');
			$('body').find('canvas').remove();
		}
	//Detect mobile

	//Swipe
		//Swipe function-----------------------------------------------------------------------------------------
		$(function() {

			$("body").swipe( { fingers:'all', swipeStatus:swipeFunc, allowPageScroll:"vertical"} );

			function swipeFunc(event, phase, direction, distance) {
				// console.log(window.scroll);
				
				// if( window.scroll == false ){

				// 	window.scroll = true;

					var countScreens = parseInt($('.screens').find('.screen').length);
				    var currentScreen = parseInt($('.screens').find('.screen.active').attr('data-marker'));

					if( phase == 'start' || phase == 'move' ){
						//console.log( phase +" you have swiped " + distance + "px in direction:" + direction );
						//Set offset-------------------------------------
						if( phase == 'move' ){
							if( direction == 'up' && distance>=100 ) {

								if( currentScreen + 1 <= countScreens ){
						    		$('nav').find('li[data-marker="'+(currentScreen + 1)+'"]').trigger('click');
						    	}
								return false;
							}
							else if( direction == 'down' && distance>=100 ) {
								if( currentScreen - 1 >= 1 ){
						    		$('nav').find('li[data-marker="'+(currentScreen - 1)+'"]').trigger('click');
						    	}

								return false;
							}
						}
					}// phase start/move


				// 	setTimeout(function(){
				//     	window.scroll = false;
				//     },1000);
				// }
			}//swipeFunc function

		});
		//Swipe function-----------------------------------------------------------------------------------------
	//Swipe
});