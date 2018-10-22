$( document ).ready(function() {
    // ----------------------------------
    // Like button AJAX controller
    // ----------------------------------
    $('a.like').bind('ajax:success', function(status,data,xhr) {

        if ($('a.like').attr('data-method') == 'post') {
            // Dislike
            $('a.like').attr('data-method', 'delete');
            $('a.like').attr('href', $('a.like').attr('href').replace('like','dislike'));
            $('a.like').children('span').attr('class','glyphicon glyphicon-heart heart');
        } else {
            // Like
            $('a.like').attr('data-method', 'post');
            $('a.like').attr('href', $('a.like').attr('href').replace('dislike','like'));
            $('a.like').children('span').attr('class','glyphicon glyphicon-heart-empty heart');
        }
    });
});