$(document).ready( function () {

    const selectCountry = document.querySelector('#user_country_code');
    const phoneInput = document.querySelector('#user_phone');

    $(selectCountry).addClass('flag-icon-circle flag-icon-circle-' + selectCountry.getAttribute('data-selected'));
    phoneInput.value = selectCountry.value;


    // Update phone number input when country is changed
    $('#user_country_code').on('change', function () {
        let countryCode = $(this).find('option:selected').html().toLowerCase();
        $('#user_country_code').removeClass().addClass('form-control col-pd-auto form-select flag-icon-circle flag-icon-circle-' + countryCode);


        // Update the phone field with the selected country code
        let selected = $(this).children(':selected');
        let countryCodeSelected = selected.val();
        let phoneField = $('#user_phone');
        if (phoneField.val() === '') {
            phoneField.val('+' + countryCodeSelected + ' ');
        } else {
            phoneField.val('+' + countryCodeSelected.replace(/\D/g, '') + ' ');
        }
    });
})