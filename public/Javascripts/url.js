$(document).ready(function () {
    $('a[href="'+location.hash+'"]').tab('show');
})
$(document).ready( function() {
    let hash;

    $('a[data-bs-toggle="tab"]').click(function(e) {
        hash = $(this).attr('href');
        location.hash = hash;
    });
});