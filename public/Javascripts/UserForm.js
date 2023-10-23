$(document).ready(function () {
    // les constantes
    const userForm = $("#userForm");
    const lastName = $("#user_last_name");
    const firstName = $("#user_first_name");
    const phonenumber = $("#user_phone");
    const email = $("#user_email");
    const password = $("#user_password");
    const confirmPassword = $("#user_confirmPassword");
    const submitBtn = $("#btnUserForm");

    //les variables
    let lastNameError = true;
    let firstNameError = true;
    let phoneError = true;
    let emailError = true;
    let passwordError = true;
    let confirmPasswordError = true;

    //vérifie si la route est en création ou update pour modifier les variables de verifications des champs
    const url = new URL(window.location.href);
    const route = url.pathname.replace(/\/$/, '');
    if (route !== "/account/new") {
        emailError = false;
        passwordError = false;
        confirmPasswordError = false;
    }

    // Désactiver le bouton de soumission du formulaire au chargement de la page
    submitBtn.prop("disabled", true);

    // userForm.unbind('keyup blur ');
    // userForm.bind('keyup blur ',
    function checkFormValidity() {
        if (lastNameError === false && firstNameError === false && phoneError === false && emailError === false && passwordError === false && confirmPasswordError === false) {
            submitBtn.prop("disabled", false);
        } else {
            submitBtn.prop("disabled", true);
        }
    }

    // );

    // Vérification du lastName
    lastName.unbind('keyup blur');
    lastName.bind('keyup blur', function () {
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
        checkFormValidity();
    });

    // Vérification du firstName
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
        checkFormValidity();
    });

    // Vérification de user_phone
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
        checkFormValidity();
    });

    //Vérification de l'email
    email.unbind('keyup blur');
    email.bind('keyup blur', function () {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        let emailValue = email.val();
        //Vérifie la value avec la regex
        if (route === "/account/new") {
            if (emailRegex.test(emailValue)) {
                $("#emailFormatError").attr("hidden", true);
                //Vérifie si l'email existe en db avec Ajax
                $.ajax({
                    type: 'POST',
                    url: 'checkMail',
                    data: {email: emailValue},
                    async: true,
                    dataType: 'json'
                }).done(function (data) {
                    $("#error-message").remove();
                    if (data && data.length) {
                        let user = JSON.parse(data);
                        if (user === null) {
                            validInvalidCss(email, true);
                            $("#emailUsedError").attr("hidden", true);
                            emailError = false;
                        } else {
                            validInvalidCss(email, false);
                            $("#emailUsedError").attr("hidden", false);
                            emailError = true;

                        }
                    }

                }).fail(function () {
                    // Créer une nouvelle div avec le message d'erreur
                    var errorMessage = $("<div>").text("Une erreur est survenue, veuillez réessayer.");
                    errorMessage.attr('id', 'error-message');

                    // Ajouter la classe "error" à la nouvelle div
                    errorMessage.addClass("error");

                    // Insérer la nouvelle div après l'élément avec l'ID "user_email"
                    $("#user_email").after(errorMessage);
                });
            } else {
                validInvalidCss(email, false);
                $("#emailUsedError").attr("hidden", true);
                $("#emailFormatError").attr("hidden", false);
                emailError = true;

            }
            checkFormValidity();
        }
    });


    // Vérification de user_password avec une regex
    password.unbind('keyup blur');
    password.bind('keyup blur', function () {
        checkPassword();
        checkFormValidity();
    });

    // Vérification de user_confirmPassword par rapport à user_password
    confirmPassword.unbind('keyup blur');
    confirmPassword.bind('keyup blur', function () {
        checkConfirmPassword();
        checkFormValidity();
    });


    //Vérifie le password
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

    //Vérifie le confirmPassword
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

    //Change la classe de l'input
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
