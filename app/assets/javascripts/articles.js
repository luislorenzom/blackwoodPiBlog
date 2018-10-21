/**
 * Deletes Tag AJAX Controller
 * 
 * @param {String} text_value Tag name what you want to delete from the views (hidden input and span inside categories)
 */
function deleteTag(text_value) {
    // Delete the span from DOM
    tag = $("span.tag").filter(function() { return ($(this).text() === text_value) });
    tag = tag[0];
    tag.remove();

    // Delete tag from input
    $('input[name=tags]').val($('input[name=tags]').val().replace(text_value+' ',''));
}

/**
 * Show suggestions into view
 * 
 * @param {String} k String chunk to look up for existing tags
 */
function getsSuggestions(k) {
    // Gets the suggestions
    $.get( document.location.origin + '/tags?q=' + k, function( data ) {
        if (data.length > 0) {
            // Creates suggestion div
            $('#input_autocomplete').append('<div id="suggestions"></div>');

            $.each(data, function(k,v) {
                // Puts the suggestions in DOM
                $('#suggestions').append('<a class="suggestion" onclick="addTag(\''+v+'\')" href="javascript:void(0);">'+ v +'</a>');
            });
        }
    });
}

/**
 * Adds tag in the master div and in the hidden input
 * 
 * @param {String} tag Tag name what you want to delete from the views (hidden input and span inside categories)
 */
function addTag(tag) {
    // Creates new tag
    $('#categories').append("<span class='tag'>"+tag+'<a onclick="deleteTag(\''+tag+'\')" href="javascript:void(0);"><span class="glyphicon glyphicon-remove delete-tag"></span></a></span>');

    // Adds tag to hidden textfield
    $('input[name=tags]').val($('input[name=tags]').val() + tag + ' ');
    
    $('#tag-input').val('');
    $('#suggestions').remove();
}

$( document ).ready(function() {

    // ----------------------------------
    // Update page tags controller
    // ----------------------------------
    if ($('input[name=tags]').val().length > 0) {
        $.each($('input[name=tags]').val().split(' '), function(i,v) {  
            $('#categories').append("<span class='tag'>"+v+'<a onclick="deleteTag(\''+v+'\')" href="javascript:void(0);"><span class="glyphicon glyphicon-remove delete-tag"></span></a></span>');
        });

        $('input[name=tags]').val($('input[name=tags]').val() + ' ');
    }

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

    // ----------------------------------
    // Tags entry AJAX controller
    // ----------------------------------
    $('#tag-input').keyup(function(e) {
        var code = e.keyCode || e.which;

        if (code == 32) { // Space
            // Gets the input's value
            if (typeof $($('#tag-input').val()).html() === "undefined") {
                value = $('#tag-input').val();
            } else {
                value = $($('#tag-input').val()).html();
            }
            value = value.replace(' ','');

            // Checks if the tag has been added previously
            if (! $('input[name=tags]').val().substring(0, $('input[name=tags]').val().length - 1).split(',').includes(value)) {
                addTag(value);
            }
                
            // Cleans input
            $('#tag-input').val('');

        } else if (code >= 48 && code <= 90) { // 0-1 and a-z
            // Look up for a recommendation
            $('#suggestions').remove();
            getsSuggestions($('#tag-input').val());

        } else if (code == 8 || code == 46) { // Delete button
            $('#suggestions').remove();

            if ($('#tag-input').val().length > 0) {
                getsSuggestions($('#tag-input').val());
            }
        }
    });

    // ----------------------------------
    // Focus-Out event in suggestion tag 
    // system
    // ----------------------------------
    /*$('#tag-input').focusout(function() {
        $('#suggestions').remove();
    });*/
});