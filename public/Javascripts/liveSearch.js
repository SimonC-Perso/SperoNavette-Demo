$(document).ready(function () {

    let searchRequest = null;
    const SearchBar = $("#searchBar");

    SearchBar.unbind('keyup');
    SearchBar.bind('keyup', function () {
        let input = $(this).val();
        const landing = $("#body-search-result").html('');

        if (input !== '') {
            if (searchRequest !== null)
                searchRequest.abort();
            searchRequest = $.ajax({
                type: 'POST',
                url: 'liveSearch',
                data: {input: input},
                dataType: "json",
                success: function (data) {
                    let result = JSON.parse(data);
                    if (result && result.length > 0) {
                        for (let i = 0; i < result.length; i++) {
                            if (result[i].isActive === true) {
                                landing.append('                    <tr>\n' +
                                    '                        <td>' + result[i].lastname + ' ' + result[i].firstname + '</td>\n' +
                                    '                        <td>' + result[i].mail + '</td>\n' +
                                    '                        <td>' + result[i].phone + '</td>\n' +
                                    '                        <td>\n' +
                                    '                            <a href="/admin/user_details/' + result[i].id + '"><button type="button" class="btn btn-sm btn-outline-primary btn-modal"  data-id="' + result[i].id + '" id="modal-btn"><i class="fa-solid fa-pen-to-square"></i></button></a>\n' +
                                    '                        </td>\n' +
                                    '                    </tr>');
                            }
                        }
                        $("#search-result").attr('hidden', false);
                        $("#uList").attr('hidden', true);
                    } else if (result.length === 0) {
                        $("#search-result").attr('hidden', false);
                        landing.append('<tr id="noMatch">\n' +
                            '                        <td colspan="10">Pas de match :(</td>\n' +
                            '                    </tr>')
                        $("#uList").attr('hidden', true);
                    }

                },
                error: function (error) {
                    console.log(JSON.stringify(error));
                }
            });

        } else {
            $("#search-result").attr('hidden', true);
            $("#uList").attr('hidden', false);
            $("#noMatch").attr('hidden', true);
        }
    })
})