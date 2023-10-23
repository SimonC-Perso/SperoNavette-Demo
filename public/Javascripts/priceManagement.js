document.addEventListener('DOMContentLoaded', function (event) {
    /**
     * Toast
     */
    $('.toast').toast('show');

    event.preventDefault();
    let searchValue = '';
    const select2PricesFrom = $('.select-departure-city');
    const select2PricesTo = $('.select-arrival-city');
    (select2PricesTo).select2(
        {
            placeholder: "CP ou Ville ou Aéroport",
            theme: "bootstrap-5",
            ajax: {
                url: '/getCities',
                dataType: 'json',
                data: function (params) {
                    // Query parameters will be ?search=[term]&page=[page]
                    return {
                        cp: params.term,
                        page: params.page || 1
                    };
                },
                processResults: function (data, params) {
                    params.page = params.page || 1;
                    const dataList = JSON.parse(data);
                    // for (const city of data) {
                    //     dataList.push({'id': city.id, 'text': city.label});
                    // }
                    console.log(dataList)
                    return {
                        results: dataList,
                        pagination: {
                            more: (params.page * 30) < data.total_count
                        }
                    };
                },
            }
        });
    $(select2PricesFrom).select2({
        placeholder: "CP ou Ville ou Aéroport",
        theme: "bootstrap-5",
        ajax: {
            url: '/getCities',
            dataType: 'json',
            data: function (params) {
                // Query parameters will be ?search=[term]&page=[page]
                return {
                    cp: params.term,
                    page: params.page || 1
                };
            },
            processResults: function (data, params) {
                params.page = params.page || 1;
                const dataList = JSON.parse(data);
                console.log(dataList)
                return {
                    results: dataList,
                    pagination: {
                        more: (params.page * 5) < data.total_count
                    }
                };
            },
        }
    });

    const searchBar = $('#searchPriceManagementBar');

    $('#searchPriceManagementBar').on('keyup', function () {
        searchValue = $('#searchPriceManagementBar').val();
        $.ajax({
            type: 'GET',
            url: "filter",
            dataType: 'json',
            data: {"search=": searchValue},
            async: false,
            timeout: 5000,
            success: function (data) {

            }
        })
    });


    $(select2PricesTo).change(function () {
        const arrival = select2PricesTo.select2('data')[0];
        console.log("departure :::::", arrival.zipcodeId)
        $('#price_manager_form_to_zipcode').val(arrival.zipcodeId);
    });


    $(select2PricesFrom).change(function () {
        const departure = select2PricesFrom.select2('data')[0];
        console.log("departure :::::", departure.zipcodeId)
        $('#price_manager_form_from_zipcode').val(departure.zipcodeId);
    });
    // searchBar.on('keyup', function (e) {
    //     e.preventDefault();
    //
    // }
    $("a").click(function (e) {
        console.log(e.originalEvent.currentTarget.href.contains('priceManagement/update'));
        if (e.originalEvent.currentTarget.href.contains('priceManagement/update')) {
            if (searchValue !== '') {
                $(this).attr('href', $(this).attr('href') + '&search=' + searchValue);
            }
        }
    });

    const modalPriceManagementBtn = $(".btn-modal");
    const modalPriceSubmitBtn = $("#priceUpdateBtn");
    const modalPriceInput = $("#priceUpdated");
    const modalPriceIDInput = $("#priceId");
    let modalRequest = null;

    modalPriceManagementBtn.unbind('click')
    modalPriceManagementBtn.bind('click', function () {
        let id = $(this).attr('data-id');
        if (modalRequest !== null) modalRequest.abort();
        modalRequest = $.ajax({
            type: 'GET',
            url: 'getPrice/' + id,
            dataType: 'json',
            success: function (data) {
                const price = JSON.parse(data)
                modalPriceInput.val(price.price);
                modalPriceIDInput.val(id);
            }
        });
    });
});

function changeValue() {
    let value = modalPriceInput.val();
    value.replace(',', '.');
    modalPriceInput.val(value);
    return true;
}