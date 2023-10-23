$(document).ready( function() {



        jQuery(function($){
            $.datepicker.regional['fr'] = {
                closeText: 'Fermer',
                prevText: '&#x3c;Préc',
                nextText: 'Suiv&#x3e;',
                monthNames: ['Janvier','Fevrier','Mars','Avril','Mai','Juin',
                    'Juillet','Aout','Septembre','Octobre','Novembre','Decembre'],
                monthNamesShort: ['Jan','Fev','Mar','Avr','Mai','Jun',
                    'Jul','Aou','Sep','Oct','Nov','Dec'],
                dayNames: ['Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi'],
                dayNamesShort: ['Dim','Lun','Mar','Mer','Jeu','Ven','Sam'],
                dayNamesMin: ['Di','Lu','Ma','Me','Je','Ve','Sa'],
                weekHeader: 'Sm',
                dateFormat: 'dd-mm-yy',
                firstDay: 1,
                isRTL: false,
                showMonthAfterYear: false,
                yearSuffix: '',
                numberOfMonths: 1
            };
            $.datepicker.setDefaults($.datepicker.regional['fr']);
        });


        // datepicker pour la birthDate
        $(".datepicker").datepicker({
            dateFormat: "dd-mm-yy",
            changeMonth: true,
            changeYear: true,
            yearRange: "-100:+0",
            inline: true,
            showOtherMonths: true,
        });
    //datepicker pour la réservation
    $(".datepickerReservation").datepicker({
        dateFormat: "dd-mm-yy",
        changeMonth: true,
        changeYear: true,

        //gérer le menu déroulant année "avant:après"
        yearRange: "-100:+1",
        inline: true,
        showOtherMonths: true,
    });

    }
)