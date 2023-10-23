let eForm;
let eName;
let eEmail;
let ePhone;
let eTva;
let eBtn;
window.addEventListener('DOMContentLoaded', event => {
    let isLoading = false
    eForm = $('#enterpriseForm');
    eName = $('#enterprise_form_name');
    eEmail = $('#enterprise_form_email');
    ePhone = $('#enterprise_form_phone');
    eTva = $('#enterprise_form_vat');
    eBtn = $('#btnenterpriseForm');

    eForm.on('keyup blur', function () {
        if (!(nameError && emailError && phoneError && tvaError)) eBtn.prop('disabled', false);
        else eBtn.prop('disabled', true);
    });

    eName.on('keyup blur', function () {
        let nameValue = eName.val().trim();
        if (nameValue.length > 0 && nameValue.length < 255) {
            validInvalidCss(eName, true);
            nameError = false;
        } else {
            validInvalidCss(eName, false);
            nameError = true;
        }
    });

    eEmail.on('keyup blur', function () {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        let emailValue = eEmail.val();
        if (emailRegex.test(emailValue)) {
            validInvalidCss(eEmail, true);
        } else {
            validInvalidCss(eEmail, false);
        }
    });

    ePhone.on('keyup blur', function () {
        let phoneNumberValue = ePhone.val();
        const regexphone = /^[+]?([0-9])+[-.\s]?[0-9]+[-.\s]?[0-9\s]+$/;
        if (phoneNumberValue.length > 9 && phoneNumberValue.length < 20 && regexphone.test(phoneNumberValue)) {
            validInvalidCss(ePhone, true);
            phoneError = false;
        } else {
            validInvalidCss(ePhone, false);
            phoneError = true;
        }
    });
    $('#adminEnterpriseEdit').click(function (e) {
        e.preventDefault();
        checkEnterpriseInformation();
    })
})

function checkEnterpriseInformation() {
    let nameError = false;
    let emailError = false;
    let phoneError = false;
    let tvaError = false;
    $.ajax({
        type: 'POST',
        url: 'fillEForm',
        async: true,
        dataType: 'json'
    }).done(function (data) {
        let e = JSON.parse(data);
        console.log(e);
        eName.val(e.name);
        eEmail.val(e.email);
        ePhone.val(e.phone);
        eTva.val(e.tva);
    }).fail(function () {
        console.log('Boom');
        let errorMessage = $("<div>").text("Une erreur est survenue.");
        errorMessage.attr('id', 'error-message');
        errorMessage.addClass("error");
        $(eForm).before(errorMessage);
    })


}

function validInvalidCss(input, isValid, removeAll = false) {
    if (removeAll) {
        input.removeClass("is-valid");
        input.removeClass("is-invalid");
    } else if (isValid) {
        input.addClass("is-valid");
        input.removeClass("is-invalid");
    } else {
        input.addClass("is-invalid");
        input.removeClass("is-valid");
    }
}