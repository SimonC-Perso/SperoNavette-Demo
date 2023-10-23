$(document).ready(function () {

    const userForm = $("#AdminUserForm");
    const lastName = $("#admin_user_last_name");
    const firstName = $("#admin_user_first_name");
    const phonenumber = $("#admin_user_phone");
    const email = $("#admin_user_email");
    const password = $("#admin_user_password");
    const confirmPassword = $("#admin_user_confirmPassword");
    const submitBtn = $("#AdminBtnUserForm");

    let lastNameError = true;
    let firstNameError = true;
    let phoneError = true;
    let emailError = true;
    let passwordError = true;
    let confirmPasswordError = true;

    const url = new URL(window.location.href);
    const route = url.pathname.replace(/\/$/, '');
    if (route !== "/admin/dashboard") {
        emailError = false;
        passwordError = false;
        confirmPasswordError = false;
    }

    submitBtn.prop("disabled", true);

    userForm.unbind('keyup blur change');
    userForm.bind('keyup blur change', function checkFormValidity() {
        console.log(lastNameError, firstNameError, phoneError, passwordError, confirmPasswordError, emailError);
        if (lastNameError === false && firstNameError === false && phoneError === false && emailError === false && passwordError === false && confirmPasswordError === false) {
            submitBtn.prop("disabled", false);
        } else {
            submitBtn.prop("disabled", true);
        }
    });

    lastName.unbind('keyup blur');
    lastName.bind('keyup blur ', function () {
        let lastNameValue = lastName.val().trim();
        if (lastNameValue.length > 0 && lastNameValue.length < 255) {
            validInvalidCss(lastName, true);
            $("#lastNameError").attr("hidden", true);
            lastNameError = false;
        } else {
            validInvalidCss(lastName, false);
            $("#lastNameError").attr("hidden", false);
            lastNameError = true;
        }
    });

    firstName.unbind('keyup blur');
    firstName.bind('keyup blur', function () {
        let firstNameValue = firstName.val().trim();
        if (firstNameValue.length > 0 && firstNameValue.length < 255) {
            validInvalidCss(firstName, true);
            $("#firstNameError").attr("hidden", true);
            firstNameError = false;

        } else {
            validInvalidCss(firstName, false);
            $("#firstNameError").attr("hidden", false);
            firstNameError = true;
        }
    });

    phonenumber.unbind('keyup blur');
    phonenumber.bind('keyup blur', function () {
        let phoneNumberValue = phonenumber.val();
        const regexphone = /^[+]?([0-9])+[-.\s]?[0-9]+[-.\s]?[0-9\s]+$/;
        if (phoneNumberValue.length > 9 && phoneNumberValue.length < 20 && regexphone.test(phoneNumberValue)) {
            validInvalidCss(phonenumber, true);
            $("#phoneError").attr("hidden", true);
            phoneError = false;
        } else {
            validInvalidCss(phonenumber, false);
            $("#phoneError").attr("hidden", false);
            phoneError = true;
        }
    });

    password.unbind('keyup blur');
    password.bind('keyup blur', function () {
        checkPassword();
    });

    confirmPassword.unbind('keyup blur');
    confirmPassword.bind('keyup blur', function () {
        checkConfirmPassword();
    });
    email.unbind('keyup blur');
    email.bind('keyup blur', function () {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        let emailValue = email.val();
        if (emailRegex.test(emailValue)) {
            $("#emailFormatError").attr("hidden", true);
            $.ajax({
                type: 'POST',
                url: 'checkUserEmail',
                data: {email: emailValue},
                dataType: 'json'
            }).done(function (data) {
                $("#error-message").remove();
                if (data && data.length) {
                    let user = JSON.parse(data);
                    if (user !== null) {
                        validInvalidCss(email, false);
                        $("#emailUsedError").attr("hidden", false);
                        emailError = true;
                    } else {
                        validInvalidCss(email, true);
                        $("#emailUsedError").attr("hidden", true);
                        emailError = false;
                    }
                }

            }).fail(function () {
                console.log('Boom');
                let errorMessage = $("<div>").text("Une erreur est survenue.");
                errorMessage.attr('id', 'error-message');
                errorMessage.addClass("error");
                $("#user_email").after(errorMessage);
            })
        } else {
            validInvalidCss(email, false);
            $("#emailUsedError").attr("hidden", true);
            $("#emailFormatError").attr("hidden", false);
            emailError = true;
        }
    });


    function checkPassword() {
        const regexpsw = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
        let passwordValue = password.val();
        if (regexpsw.test(passwordValue)) {
            validInvalidCss(password, true);
            $("#passwordError").attr("hidden", true);
            passwordError = false;
            if (confirmPassword.val() !== '') {
                checkConfirmPassword();
            }

        } else {
            passwordError = true;
            validInvalidCss(password, false);
            $("#passwordError").attr("hidden", false);
            if (confirmPassword.val() !== '') {
                checkConfirmPassword();
            }
        }
    }

    function checkConfirmPassword() {
        let confirmPasswordValue = confirmPassword.val();
        let passwordValue = password.val();
        if (confirmPasswordValue === passwordValue) {
            //Check si password à une erreur
            if (passwordError) {
                validInvalidCss(confirmPassword, false);
                confirmPasswordError = true;
            } else {
                validInvalidCss(confirmPassword, true);
                confirmPasswordError = false;
            }
            $("#confirmPasswordError").attr("hidden", true);

        } else {
            validInvalidCss(confirmPassword, false);
            $("#confirmPasswordError").attr("hidden", false);
            confirmPasswordError = true;
        }
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

});