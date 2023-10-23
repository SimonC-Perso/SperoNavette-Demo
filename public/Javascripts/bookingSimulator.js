let arrayIdDisabled;
$(document).ready(function () {
    $(window).keydown(function (event) {
        if (event.keyCode === 13) {
            event.preventDefault();
            return false;
        }
    });
    // Les constantes
    const passenger = $("#reservations_passenger");
    const baggage = $("#addBaggage");
    const contentAdditionFee = $("#contentAdditionFee");
    const tableBaggageBody = $("#tableBaggageBody");


    //nombre de passagers
    passenger.unbind('click');
    passenger.bind('change', function (e) {
        e.preventDefault();
        removeBadges();
        passengerValue = passenger.val();
    })

    //bouton baggage
    baggage.unbind('click');
    baggage.bind('click', function (e) {
        e.preventDefault();
        arrayIdDisabled = [];
        console.log(contentAdditionFee.attr('hidden'))
        if ('hidden' === contentAdditionFee.attr("hidden")) {
            listBaggageFiltered();
            listBaggage();
            contentAdditionFee.attr("hidden", false);
        } else {
            tableBaggageBody.html('');
            contentAdditionFee.attr("hidden", true);
        }

    })


    /**
     * Affiche les baggage
     */
    function listBaggage() {
        // On récupère l'id des filtres
        var divFiltreBagages = $('#filtersBaggage');
        var checkboxes = divFiltreBagages.find('input[type="checkbox"]:checked');
        var checkboxValues = [];
        checkboxes.each(function () {
            var dataId = $(this).data('id');
            checkboxValues.push(dataId);
        });

        $.ajax({
            type: 'GET',
            url: "getAllBaggageByFilter",
            data: {filters: checkboxValues},
            dataType: 'json',
            timeout: 5000,
            success: function (response) {
                let listBaggage = JSON.parse(response);
                //l'id de la partie filtre
                let container = document.getElementById('listBaggage');
                container.innerHTML = '';
                //on parcourt la response pour insérer les données dans une div-badge
                listBaggage.forEach((bagages) => {
                    let baggageDiv = document.createElement('div');
                    let baggageLink = document.createElement('input');
                    baggageLink.type = "button"
                    baggageLink.classList.add('btn', 'btn-primary', 'btn-lg', 'btn-sm');
                    baggageLink.value = bagages.baggage_types + " : " + bagages.label;
                    baggageLink.id = 'btnBaggage' + bagages.id;
                    console.log('bagg ', bagages);
                    console.log('blid ', baggageLink.id);
                    console.log(arrayIdDisabled);
                    for (const arrayIdDisabledElement of arrayIdDisabled) {
                        if (baggageLink.id === arrayIdDisabledElement)
                            baggageLink.disabled = true;
                    }
                    //on attache la fonction
                    baggageLink.addEventListener('click', function (e) {
                        console.log("click on baggageLink")
                        baggageLink.disabled = true;
                        arrayIdDisabled.push(baggageLink.id);
                        addRowBaggageTable(bagages.label, bagages.baggage_types, bagages.price, bagages.baggage_types_id, baggageLink, bagages.id);
                    });
                    baggageDiv.appendChild(baggageLink)
                    baggageDiv.appendChild(baggageLink)
                    container.append(baggageDiv);
                })
            },
            error: function () {
                errorMessage('#listBaggage');
            }

        });
    }

    /**
     * va rechercher les filtres actifs en base de données
     */
    function listBaggageFiltered() {
        $.ajax({
            type: 'GET',
            url: "getAllBaggageType",
            dataType: 'json',
            async: false,
            timeout: 5000,
            success: function (response) {
                console.log(response);
                let listTypesBagages = JSON.parse(response);
                //l'id de la partie filtre
                let container = document.getElementById('filtersBaggage');
                container.classList.add('text-lg-start');
                container.innerHTML = '';
                //on parcourt la response
                listTypesBagages.forEach((typeBagage) => {
                        //on crée la case à cocher
                        let checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.value = typeBagage.label;
                        checkbox.id = 'checkBox-' + typeBagage.label;
                        checkbox.dataset.id = typeBagage.id;
                        checkbox.classList.add('form-check-input');
                        $(checkbox).on('change', listBaggage);
                        // on crée le label
                        let label = document.createElement('label');
                        label.htmlFor = 'checkBox-' + typeBagage.label;
                        label.innerHTML = typeBagage.label;
                        // on crée la div
                        let div = document.createElement('div');
                        div.id = 'div' + typeBagage.label;
                        // on met dans le container
                        container.appendChild(div);
                        div.appendChild(checkbox);
                        div.appendChild(label);
                    }
                )
            },
            error: function () {
                errorMessage('#filtersBaggage');
            }
        });
    }


    /**
     * ajoute un bagage au tableau
     * @param title
     * @param type
     * @param price
     */
    function addRowBaggageTable(label, type, price, baggage_types_id, baggageLink, baggageId) {

        //sélectionne le tableau
        let tableBody = document.getElementById('tableBaggageBody');

        //crée une nouvelle ligne
        let newRow = document.createElement('tr');

        // crée la cellule pour le type et le label
        let tdLabel = document.createElement('td');
        tdLabel.innerHTML = type + " : " + label;

        // crée la cellule pour le type et le prix
        let tdPrice = document.createElement('td');
        tdPrice.innerHTML = price + '€';

        // crée la cellule pour la quantitée
        let tdQuantity = document.createElement('td');

        // Créez un input number pour la quantité
        let inputNumber = document.createElement('input');
        let inputTd = document.createElement('input');
        let inputTd2 = document.createElement('input');
        inputNumber.type = 'number';
        if (baggage_types_id === 4 || baggage_types_id === 5)
            inputNumber.max = '1';
        inputNumber.value = '1';
        inputNumber.min = '1';
        inputNumber.name = "booking_simulator_form_additional_fee_qte[]";
        inputNumber.classList.add('col-sm-4')
        // inputNumber.classList.add('inputNumberSimulateur');
        inputNumber.addEventListener('change', function (e) {
            console.log(e)
            if (e.target.validity.valid)
                updateTotal();
            else if (e.target.value < e.target.min)
                e.target.value = e.target.min
            else if (e.target.value > e.target.max)
                e.target.value = e.target.max
        })

        //Crée la cellule total
        let tdTotal = document.createElement('td');
        tdTotal.innerHTML = price + '€';
        tdTotal.classList.add('total-cell');
        inputTd.classList.add('input-cell');
        inputTd.hidden = 'hidden';
        inputTd.value = price;
        inputTd.innerHTML = price;
        inputTd.name = "booking_simulator_form_additional_fee[]";
        inputTd.id = baggageId;
        inputTd2.classList.add('input-cell');
        inputTd2.hidden = 'hidden';
        inputTd2.value = baggageId;
        inputTd2.innerHTML = price;
        inputTd2.name = "booking_simulator_form_additional_fee_id[]";
        inputTd2.id = baggageId;
        newRow.id = 'trbtnBaggage' + baggageId
        //Crée le bouton supprimer
        let tdDeleteIcon = document.createElement('td');
        let deleteIcon = document.createElement('i');
        deleteIcon.classList.add('fas', 'fa-trash-alt');
        deleteIcon.classList.add('delete-icon');
        $(document).on('click', '.delete-icon', function () {
            let row = $(this).closest('tr');
            arrayIdDisabled = arrayIdDisabled.filter(function (a) {
                console.log("a ", a);
                let element = 'tr' + a;
                if (element === row[0].id)
                    document.getElementById(a).disabled = false;
                return element !== row[0].id
            })
            row.remove();
            updateTotal();
        });


        // Ajoutez les éléments à la cellule de quantité
        // tdQuantity.appendChild(btnPlus);
        tdQuantity.appendChild(inputNumber);
        // tdQuantity.appendChild(btnMinus);

        //Ajouter le favicon à la cellule

        tdDeleteIcon.appendChild(deleteIcon);
        // Ajoutez les cellules à la ligne
        newRow.appendChild(tdLabel);
        newRow.appendChild(tdPrice);
        newRow.appendChild(tdQuantity);
        newRow.appendChild(tdTotal);
        newRow.appendChild(inputTd);
        newRow.appendChild(inputTd2);
        newRow.appendChild(tdDeleteIcon);

        // Ajoutez la nouvelle ligne au corps du tableau
        tableBody.appendChild(newRow);
    }

    /**
     * Calcul quantity * price
     */
    function updateTotal() {
        let tableRows = document.querySelectorAll('#tableBaggageBody tr');
        tableRows.forEach(function (row) {
            let inputNumber = row.querySelector('input[type="number"]');
            let inputTd = row.querySelector('input[type="number"]');
            let price = parseFloat(row.querySelector('td:nth-child(2)').innerHTML);
            console.log("updateTotal ", price)
            let quantity = parseInt(inputNumber.value);
            let totalPrice = price * quantity;
            row.querySelector('.total-cell').innerHTML = totalPrice.toFixed(2) + '€';
            row.querySelector('.input-cell').value = totalPrice.toFixed(2);

        });
    }

    //
    // /**
    //  * vide tous les badges
    //  */
    // function removeBadges() {
    //     $('#suggesstionBoxDepartStreet').html("");
    //     $('#suggesstionBoxDepartCodePostal').html("");
    //     $('#suggesstionBoxDepartLocalite').html("");
    //     $('#suggesstionBoxDestinationStreet').html("");
    //     $('#suggesstionBoxDestinationCodePostal').html("");
    //     $('#suggesstionBoxDestinationLocalite').html("");
    // }


    /**
     * Fonction pour afficher un message en cas d'erreur ajax
     * @param tag
     */
    function errorMessage(tag) {
        $(tag).html('Une erreur est survenue. Veuillez réessayer plus tard ou nous contacter au +32 490 197 914.');
    }
})


function validSimulatorForm() {
    const departureCountryEL = document.querySelector('#booking_simulator_form_travel_departureAddress_departureCity_Country');
    const departureCityEL = document.querySelector('#booking_simulator_form_travel_departureAddress_departureCity_label');
    const departureStreetEL = document.querySelector('#booking_simulator_form_travel_departureAddress_departureStreet');
    const departureNumberEL = document.querySelector('#booking_simulator_form_travel_departureAddress_departureNumber');
    const arrivalStreetEL = document.querySelector('#booking_simulator_form_travel_arrivalAddress_arrivalStreet');
    const arrivalCityEL = document.querySelector('#booking_simulator_form_travel_arrivalAddress_arrivalCity_label');
    const arrivalCountryEL = document.querySelector('#booking_simulator_form_travel_arrivalAddress_arrivalCity_Country');
    const departureCountryErrorEL = document.querySelector('#bookingForm_travel_departureAddress_departureCity_Country_error');
    const arrivalCountryErrorEL = document.querySelector('#bookingForm_travel_arrivalAddress_arrivalCity_Country_error');
    const departureStreetErrorEL = document.querySelector('#bookingForm_travel_departureAddress_departureStreet_error');
    const departureNumberErrorEL = document.querySelector('#bookingForm_travel_departureAddress_departureNumber_error');
    const arrivalStreetErrorEL = document.querySelector('#bookingForm_travel_arrivalAddress_arrivalStreet_error');
    const departureCityErrorEL = document.querySelector('#bookingForm_travel_departureAddress_departureCity_label_error');
    const arrivalCityErrorEL = document.querySelector('#bookingForm_travel_arrivalAddress_arrivalCity_label_error');
    const isRequired = value => value !== '';
    const checkDepartureCountryValidity = () => {
        return isRequired(departureCountryEL.value);
    }
    const departureStreetValidity = () => {
        return isRequired(departureStreetEL.value);
    }
    const departureNumberValidity = () => {
        if (departureNumberEL.required === true) {
            console.log(departureNumberEL.required)
            return isRequired(departureNumberEL.value);
        } else return true;
    }
    const departureCityValidity = () => {
        return isRequired(departureCityEL.value) && departureCityEL.value !== arrivalCityEL.value;
    }
    const checkArrivalCountryValidity = () => {
        return isRequired(arrivalCountryEL.value);
    }
    const arrivalStreetValidity = () => {
        return isRequired(arrivalStreetEL.value);
    }
    const arrivalCityValidity = () => {
        return isRequired(arrivalCityEL.value) && departureCityEL.value !== arrivalCityEL.value;
    }
    const validForm = () => {
        departureCountryErrorEL.hidden = validInvalidCss(departureCountryEL, checkDepartureCountryValidity());
        departureStreetErrorEL.hidden = validInvalidCss(departureStreetEL, departureStreetValidity());
        departureNumberErrorEL.hidden = validInvalidCss(departureNumberEL, departureNumberValidity());
        departureCityErrorEL.hidden = validInvalidCss(departureCityEL, departureCityValidity());
        arrivalCountryErrorEL.hidden = validInvalidCss(arrivalCountryEL, checkArrivalCountryValidity());
        arrivalStreetErrorEL.hidden = validInvalidCss(arrivalStreetEL, arrivalStreetValidity());
        arrivalCityErrorEL.hidden = validInvalidCss(arrivalCityEL, arrivalCityValidity());
        return !!(departureCountryErrorEL.hidden && departureStreetErrorEL.hidden && departureNumberErrorEL.hidden && departureCityErrorEL.hidden &&
            arrivalCountryErrorEL.hidden && arrivalStreetErrorEL.hidden && arrivalCityErrorEL.hidden);
    }
    return validForm();
}

document.addEventListener('DOMContentLoaded', function (event) {
    event.preventDefault();
    $('#simulatorCloseModal').on('click', function () {
        $('#simulatorModal').modal('toggle');
    });
    $('#simulatorErrorCloseModal').on('click', function () {
        $('#SimulatorError').modal('toggle');
    });
    $('#sendInformation').on('click', function (e) {
        e.preventDefault();
        $('#contactSimulatorModal').modal('toggle');
    })
    $('#btnBookingForm').on('click', function (e) {
        e.preventDefault();
        console.log("valid", validSimulatorForm())

        /**
         * Price calculating for each element and in relation with prices database
         * @param passengerEL
         * @param departureCityZipCodeEL
         * @param arrivalCityZipCodeEL
         * @param additionalFee
         * @param modalAdditionalFeeEL
         * @param modalTravelTypeEL
         * @param privateTravel
         * @param travelGoOnly
         * @returns {*}
         */
        const priceCalc = (passengerEL, departureCityZipCodeEL, arrivalCityZipCodeEL, additionalFee, modalAdditionalFeeEL, modalTravelTypeEL, privateTravel, travelGoOnly) => {
            document.getElementById('sendInformation').disabled = false;
            document.querySelector('#modalAdditionalFeeDiv').hidden = additionalFee.length === 0;
            console.log('passenger ', passengerEL[passengerEL.value - 1].innerHTML);
            console.log('departureCity ', departureCityZipCodeEL.value);
            console.log('arrivalCityEL ', arrivalCityZipCodeEL.value);
            console.log('modalTravelTypeEL ', modalTravelTypeEL);
            console.log('additionalFee ', additionalFee);
            modalAdditionalFeeEL.innerHTML = "";
            let additionalFeePrice = 0;
            let i = 0
            for (const additionalFeeElement of additionalFee) {
                i++;
                console.log(additionalFee)
                const element = additionalFeeElement.parentElement.innerText;
                modalAdditionalFeeEL.innerHTML += element.substring(0, element.indexOf("\t")) + " " + additionalFeeElement.value + ' €' + '<br>';
                additionalFeePrice += parseInt(additionalFeeElement.value);
                console.log("baggage type additionalFeeElementId ", additionalFeeElement.id)
                if (parseInt(additionalFeeElement.id) === 4) {
                    console.log("before private travel ", privateTravel)
                    privateTravel = true;
                    console.log("after true private travel ", privateTravel)
                }
            }
            console.log("params departureCityZipCodeEL ", departureCityZipCodeEL.value + " arrivalCityZipCodeEL " + arrivalCityZipCodeEL.value)
            let price;
            let error;
            /**
             * get prices from database
             * @param form id
             * @param to id
             */
            $.ajax({
                type: 'GET',
                url: "getPrices",
                dataType: 'json',
                data: {"fromId": departureCityZipCodeEL.value, "toId": arrivalCityZipCodeEL.value},
                async: false,
                timeout: 5000,
                success: function (data) {

                    if (data !== null) {
                        let prices = JSON.parse(data);
                        price = priceAndAdditionalFee(prices.price, passengerEL[passengerEL.value - 1].innerHTML, additionalFeePrice, privateTravel, travelGoOnly);
                    }

                    /**
                     * calculating additional fee and price
                     * for information see Excel file
                     * @param price
                     * @param passenger
                     * @param additionalFeePrice
                     * @param privateTravel
                     * @param travelGoOnly
                     * @returns {string}
                     */
                    function priceAndAdditionalFee(price, passenger, additionalFeePrice, privateTravel, travelGoOnly) {
                        let privateTravelPrice;
                        switch (parseInt(passenger)) {
                            case 1:
                            case 2:
                                //console.log("price 2 passenger ", price);
                                price;
                                break;
                            case 3:
                                price = price + 5;
                                //console.log("price 3 passenger ", price)
                                break;
                            case 4:
                                price = price + 10;
                                // console.log("price 4 passenger ", price)
                                break;
                            case 5:
                                price = price + 15;
                                // console.log("price 5 passenger ", price)
                                break;
                            case 6:
                                price = price + 20;
                                // console.log("price 6 passenger ", price)
                                break;
                            case 7:
                                price = (price + 30) * 1.15;
                                privateTravelPrice = price;
                                //  console.log("price 7 passenger ", price)
                                break;
                            case 8:
                                price = (price + 30) * 1.15;
                                privateTravelPrice = price;
                                //  console.log("price 8 passenger ", price)
                                break;
                        }
                        price += additionalFeePrice;
                        //  console.log("price + additional fee ", price)
                        //   console.log("private travel ", privateTravel)
                        if (price < 60) {
                            // console.log("price < 60 ");
                            privateTravelPrice = price + 20;
                        } else if (price < 101) {
                            // console.log("price < 101 ");
                            privateTravelPrice = price + 25;
                        } else if (price > 101) {
                            // console.log("price > 101 ");
                            privateTravelPrice = price * 1.25;
                        }
                        // console.log(travelGoOnly)
                        if (!travelGoOnly)
                            price = price * 2;
                        price = privateTravel ? privateTravelPrice + " €" : price + " €";
                        // console.log("price final ", price)
                        return price;
                    }
                },
                error: function (e) {
                    console.log("error *****************************");
                    throw new Error('error price calculating!');
                }
            });
            return price;
        }

        if (validSimulatorForm()) {
            let privateTravel = false;
            let travelGoOnly = false;
            const passengerEL = document.querySelector('#booking_simulator_form_passenger');
            const bookingTypeEL = document.getElementsByName('booking_simulator_form[bookingType]');
            const travelTypeEL = document.getElementsByName('booking_simulator_form[travelType]');
            const departureCountryEL = document.querySelector('#booking_simulator_form_travel_departureAddress_departureCity_Country');
            const departureCityEL = document.querySelector('#booking_simulator_form_travel_departureAddress_departureCity_label');
            const departureCityZipCodeEL = document.querySelector('#booking_simulator_form_travel_departureAddress_departureCity_zipcode');
            const departureStreetEL = document.querySelector('#booking_simulator_form_travel_departureAddress_departureStreet');
            const departureNumberEL = document.querySelector('#booking_simulator_form_travel_departureAddress_departureNumber');
            const arrivalNumberEL = document.querySelector('#booking_simulator_form_travel_arrivalAddress_arrivalNumber');
            const arrivalStreetEL = document.querySelector('#booking_simulator_form_travel_arrivalAddress_arrivalStreet');
            const arrivalCityEL = document.querySelector('#booking_simulator_form_travel_arrivalAddress_arrivalCity_label');
            const arrivalCityZipCodeEL = document.querySelector('#booking_simulator_form_travel_arrivalAddress_arrivalCity_zipcode');
            const arrivalCountryEL = document.querySelector('#booking_simulator_form_travel_arrivalAddress_arrivalCity_Country');
            const modalTravelTypeEL = document.getElementById('modal_travel_type')
            const modalTravelFromEL = document.getElementById('modal_travel_from')
            const modalTravelToEL = document.getElementById('modal_travel_to')
            const modalPassengerEL = document.getElementById('modal_passenger')
            const modalAdditionalFeeEL = document.getElementById('modal_additional_fee')
            const modalPriceEL = document.getElementById('modal_price')
            const priceEL = document.querySelector('#price')
            const additionalFee = document.getElementsByName('booking_simulator_form_additional_fee[]');

            if (departureStreetEL.value.toLowerCase().startsWith('aéro') || departureStreetEL.value.toLowerCase() === 'brussel-zuid/midi')
                modalTravelFromEL.innerHTML = " " + departureCityEL.innerHTML + "(" + departureCountryEL[departureCountryEL.value - 1].innerHTML + ")";
            else
                modalTravelFromEL.innerHTML = " " + departureStreetEL.value + " " + departureNumberEL.value + " " + departureCityEL.innerHTML + "(" + departureCountryEL[departureCountryEL.value - 1].innerHTML + ")";
            if (arrivalStreetEL.value.toLowerCase().startsWith('aéro') || arrivalStreetEL.value.toLowerCase() === 'brussel-zuid/midi')
                modalTravelToEL.innerHTML = " " + arrivalCityEL.innerHTML + "(" + arrivalCountryEL[arrivalCountryEL.value - 1].innerHTML + ")";
            else
                modalTravelToEL.innerHTML = " " + arrivalStreetEL.value + " " + arrivalNumberEL.value + " " + arrivalCityEL.innerHTML + "(" + arrivalCountryEL[arrivalCountryEL.value - 1].innerHTML + ")";
            modalPassengerEL.innerHTML = " " + passengerEL[passengerEL.value - 1].innerHTML;
            for (const bookingTypeELElement of bookingTypeEL) {
                console.log("element ", bookingTypeELElement);
                if (bookingTypeELElement.checked) {
                    modalTravelTypeEL.innerHTML = " " + bookingTypeELElement.value;
                    if (bookingTypeELElement.value === 'Aller')
                        travelGoOnly = true;
                }
            }
            for (const travelTypeELElement of travelTypeEL) {
                console.log("element ", travelTypeELElement);
                if (travelTypeELElement.checked) {
                    console.log("travelType ::::: ", travelTypeELElement.value);
                    if (travelTypeELElement.value !== "shared")
                        privateTravel = true;
                    const textTravelType = (travelTypeELElement.value === "shared") ? " en navette partagée" : " en navette privée";
                    modalTravelTypeEL.innerHTML += "  " + textTravelType;
                }
            }
            try {
                sPrice = " " + priceCalc(passengerEL, departureCityZipCodeEL, arrivalCityZipCodeEL, additionalFee, modalAdditionalFeeEL, bookingTypeEL, privateTravel, travelGoOnly)
                console.log("sPrice", sPrice);
                if (sPrice !== ' undefined') {
                    modalPriceEL.innerHTML = sPrice
                    priceEL.value = sPrice;
                    $('#simulatorModal').modal('toggle');
                } else {
                    $('#SimulatorError').modal('toggle');
                }
            } catch (e) {
                console.log(e);
                $('#SimulatorError').modal('toggle');
            }


        }
    });

    const select2DepartureCity = $('.select-departure-city');
    const select2ArrivalCity = $('.select-arrival-city');
    $('#booking_simulator_form_travel_departureAddress_departureCity_Country').val("22").change();
    $('#booking_simulator_form_travel_arrivalAddress_arrivalCity_Country').val("22").change();
    $(select2ArrivalCity).select2(
        {
            placeholder: "CP ou Ville ou Aéroport",
            theme: "bootstrap-5",
            ajax: {
                url: 'getCities',
                dataType: 'json',
                data: function (params) {
                    // Query parameters will be ?search=[term]&page=[page]
                    country = $('#booking_simulator_form_travel_arrivalAddress_arrivalCity_Country').val();
                    return {
                        cp: params.term,
                        country: country,
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
    $(select2DepartureCity).select2({
        placeholder: "CP ou Ville ou Aéroport",
        theme: "bootstrap-5",
        ajax: {
            url: 'getCities',
            dataType: 'json',
            data: function (params) {
                // Query parameters will be ?search=[term]&page=[page]
                country = $('#booking_simulator_form_travel_departureAddress_departureCity_Country').val();
                return {
                    cp: params.term,
                    country: country,
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
    $(select2DepartureCity).change(function () {
        const departureNumberEL = document.querySelector('#booking_simulator_form_travel_departureAddress_departureNumber');
        departureNumberEL.required = true;
        const departure = select2DepartureCity.select2('data')[0];
        console.log("departure :::::", departure)
        console.log("departure :::::", departure.zipcodeId)
        $('#booking_simulator_form_travel_departureAddress_departureCity_Country').val(departure.country).change();
        $('#booking_simulator_form_travel_departureAddress_departureCity_zipcode').val(departure.zipcodeId);
        if (departure.text.toLowerCase().startsWith('aero') || departure.text.toLowerCase().startsWith('aéro') || departure.text.toLowerCase() === 'brussel-zuid/midi') {
            $('#booking_simulator_form_travel_departureAddress_departureStreet').val(departure.text);
            departureNumberEL.required = false;
        }
        //validSimulatorForm();
    })
    $(select2ArrivalCity).change(function () {
        const arrivalNumberEL = document.querySelector('#booking_simulator_form_travel_arrivalAddress_arrivalNumber');
        arrivalNumberEL.required = true;
        const arrival = select2ArrivalCity.select2('data')[0];
        $('#booking_simulator_form_travel_arrivalAddress_arrivalCity_Country').val(arrival.country).change();
        arrivalNumberEL.required = false;
        $('#booking_simulator_form_travel_arrivalAddress_arrivalCity_zipcode').val(arrival.zipcodeId);
        if (arrival.text.toLowerCase().startsWith('aero') || arrival.text.toLowerCase().startsWith('aéro') || arrival.text.toLowerCase() === 'brussel-zuid/midi') {
            $('#booking_simulator_form_travel_arrivalAddress_arrivalStreet').val(arrival.text);
            arrivalNumberEL.required = false;
        }
        validSimulatorForm();
    })
}, {once: true});

function delay(callback, ms) {
    let timer = 0;
    return function () {
        const context = this, args = arguments;
        clearTimeout(timer);
        timer = setTimeout(function () {
            callback.apply(context, args);
        }, ms || 0);
    };
}

/**
 * Change le css
 * @param input
 * @param isValid bool
 * @param removeAll
 */
function validInvalidCss(input, isValid, removeAll = false) {
    if (removeAll) {
        input.classList.remove("is-valid");
        input.classList.remove("is-invalid");
    } else if (isValid) {
        input.classList.add("is-valid");
        input.classList.remove("is-invalid");
    } else {
        input.classList.add("is-invalid");
        input.classList.remove("is-valid");
    }
    return isValid;
}


function setContent() {
    let content = '<div className="modal-header">' + document.getElementById('modalSimulator').outerHTML + '</div>';
    content += document.getElementById('modalSimulatorBody').outerHTML;
    let ok = false;
    $.ajax({
            type: 'POST',
            url: "setContent",
            dataType: 'json',
            data: {"contentSessionHTML": content},
            async: false,
            timeout: 5000,
            success: function (data) {
                ok = true;
            },
            error: function () {
                ok = false;
            }
        }
    );
    return ok;
}