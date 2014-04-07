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
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require bootstrap
//= require_tree .

// JqueryFileUpload
jQuery(function(){
	$('#new_post').fileupload({
		dataType: "script",
		masNumberOfFiles: 1, 
		add: function(e, data) {
			data.context = $(tmpl("template-upload", data.files[0]));
			$('#user-feedback').append(data.context);
			data.submit();
		},
		progress: function(e, data) {
			if(data.context) {
				var progress = parseInt(data.loaded/ data.total * 100, 10);
				data.context.find('.progress-bar').css('width', progress + '%');
			}
		},
		done: function(e,data) {
			$(".upload").fadeOut(300, function(){$(this).remove();});
		}
	});
})

// Post form client validation
var titleInputLimit = 60;
$(function() {

	$('#post_title').on('focus', function(e){
		$('#post-title-validation').show();
		if (this.value.length == 0) {
			$('#post-title-validation').text(titleInputLimit);
		} else {
			validateTitle(this);
		}

	});

	$('#post_title').on('focusout', function(e){
		$('#post-title-validation').hide();
	});

	$('#post_title').on('keyup input paste', function(){
		validateTitle(this);
	})
});

function validateTitle(title) {
	var chrRemaining = titleInputLimit - (title.value.length);
	if (chrRemaining < 0) {
		$('#post-title-validation').text(0);
		title.value = title.value.substring(0, titleInputLimit);
	} else {
		$('#post-title-validation').text(chrRemaining);
	}
};

// Post form toggle button
$(function(){
	$('#photo-btn').addClass('active');
	$('#link-form').hide();
	$('#submit-post').hide();

	$('#link-btn').on('click', function(){
		$('#photo-btn').removeClass('active');
		$('#link-btn').addClass('active');

		$('#photo-form').hide();
		$('#link-form').show();
		$('#submit-post').show();
	})

	$('#photo-btn').on('click', function(){
		$('#photo-btn').addClass('active');
		$('#link-btn').removeClass('active');

		$('#photo-form').show();
		$('#link-form').hide();
		$('#submit-post').hide();
	})
})

//Endless feed  + Footer
$(function() {
	var winHeight = $(window).height(), 
		htmlHeight = $('html').height();
	if ( htmlHeight < winHeight ) {
		$('footer').css('top', winHeight - htmlHeight)	
	}
	
	if ($('.pagination').length) {
		$(window).scroll(function(){
			var url = $('.pagination .next_page').attr('href')
			if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
				$('.pagination').text("Fetching more posts ...")	
				$.getScript(url)
			}

			if ( htmlHeight < winHeight ) {
				$('footer').css('top', winHeight - htmlHeight)
			} else {
				$('footer').css('top', 0);
			}
	  	});

		$(window).scroll();	
	}
})