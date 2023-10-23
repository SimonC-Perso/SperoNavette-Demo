$(document).ready(function () {

    const lastname = document.getElementById("modal-lastname");
    const firstname = document.getElementById("modal-firstname");
    const email = document.getElementById("modal-email");
    const phone = document.getElementById("modal-phone");
    const role = document.getElementById("modal-role");
    const status = document.getElementById("modal-status");
    const edit = $("#modal-edit");
    const modalId = $("#createModalLabel");
    const modalBtn = $(".btn-modal");

    let modalRequest = null;

    modalBtn.unbind('click')
    modalBtn.bind('click', function () {

        let id = $(this).attr('data-id');


        if (modalRequest !== null) modalRequest.abort();
        modalRequest = $.ajax({
            type: 'POST',
            url: 'fillModal',
            data: {modalId: id},
            dataType: 'json',
            success: function (data) {
                let user = JSON.parse(data);
                console.log(user);
                lastname.innerHTML = ' ' + user.lastname;
                firstname.innerHTML = ' ' + user.firstname;
                email.innerHTML = ' ' + user.mail;
                phone.innerHTML = ' ' + user.phone;
                role.innerHTML = ' ' + user.role;
                status.innerHTML = ' ' + user.status;
                edit.attr("href", "/admin/user_details/" + user.id);
            }
        })

    })
})