(function($) {
    $(document).ready(function() {
	
	$('#gganimate_plot').scianimator({
	    'images': ['images/gganimate_plot1.png'],
	    'width': 480,
	    'delay': 1000,
	    'loopMode': 'loop'
	});
	$('#gganimate_plot').scianimator('play');
    });
})(jQuery);
