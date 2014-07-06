// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(document).ready(function () {

    // dyno blinking eyes
    function blink() {
        var eyes = $('#cute_dyno span.eyes');

        function normal_eyes() {
            eyes.removeClass('eyes_blink');
        }

        function closed_eyes() {
            eyes.addClass('eyes_blink');
        }

        setTimeout(closed_eyes, 0);
        setTimeout(normal_eyes, 100);
        setTimeout(closed_eyes, 500);
        setTimeout(normal_eyes, 600);
        setTimeout(blink, Math.random() * 10000 + 1000);
    }

    blink();

    // dyno confusion
    var talks_ready = 1;
    function talk(text) {
        if (!talks_ready) return;
        talks_ready = 0;

        var talks = $('#talks');
        talks[0].innerHTML = text;
        talks.css('margin-top', -70);
        talks.css('opacity', 1);
        talks.animate({
            'margin-top':'-120px',
            opacity:0,
        }, 1000, 'linear', function () {
            talks_ready = 1
        });
    }

    $('#cute_dyno a').click(function (event) {
        event.preventDefault();
        var answers = $('#talks').attr('data-answers').split('|');
        var sentence = answers[Math.floor(Math.random() * answers.length)];
        talk( sentence );
    });

    // on success creating dyno should say 'yupi!'
    if( $('#registration ul li.ok').length !== 0 ) {
        setTimeout(function() {talk('yupi!');}, 500);
    }


    //dynosaur pointer
    function show_dynozaur_pointer() {
        $('#cute_dyno span.arrow').animate({
            opacity:1
        }, 3000);
    }

    setTimeout(show_dynozaur_pointer, 1000);
})