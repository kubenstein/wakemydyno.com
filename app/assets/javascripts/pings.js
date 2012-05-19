// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(document).ready(function () {

    function blink() {
        function normal_eyes() {
            $('#cute_dyno span.eyes').removeClass('eyes_blink');
        }

        function closed_eyes() {
            $('#cute_dyno span.eyes').addClass('eyes_blink');
        }

        setTimeout(closed_eyes, 0);
        setTimeout(normal_eyes, 100);
        setTimeout(closed_eyes, 500)
        setTimeout(normal_eyes, 600);
    }

    setInterval(blink, 9000);
})