var tableForm = (function ($, undefined) {
    'use strict';
    /**
     * Initializes the multi-select checkboxes
     */
    function initCheckboxSelect() {
        $('.check-all').off().on('change',function(){
            let table = $(this).data('table');
            let chb = $('#table-'+table+' input[type="checkbox"]:enabled');
            console.log(table);
            console.log(chb);
            chb.prop('checked',$(this).prop('checked'));
        });

        $('.update-checkbox').off().on('click',function(e){
            e.preventDefault();
            let table = $(this).data('table');
            let chb = $('#table-'+table+' input[type="checkbox"]:enabled'),
                checked = ($(this).val() === 'check-all');

            $('#'+table+' .check-all').prop('checked',checked);
            chb.prop('checked',checked);
            return false;
        });
    }

    /**
     * Public method of tableForm object
     */
    return {
        // Public Functions
        run: function (controller,offset) {
            if(typeof offset === 'undefined') offset = null;
            // Initialization of the multi-select checkboxes
            initCheckboxSelect();

            $.each($( ".ui-sortable" ), function() {
                $( this ).sortable({
                    containment: $(this).parent(),
                    items: "> tr",
                    handle: ".sort-handle",
                    cursor: "ns-resize",
                    axis: "y",
                    opacity: 0.5,
                    placeholder: "tr-placeholder",
                    helper: function(e, tr)
                    {
                        var $originals = tr.children();
                        var $helper = tr.clone();
                        $helper.children().each(function(index)
                        {
                            // Set helper cell sizes to match the original sizes
                            $(this).width($originals.eq(index).width());
                        });
                        return $helper;
                    },
                    update: function(){
                        let serial = $( this ).sortable('serialize');
                        $.jmRequest({
                            handler: "ajax",
                            url: controller+'&action=order'+(offset !== null ? '&offset='+offset : ''),
                            method: 'POST',
                            data : serial,
                            success:function(e){
                                $.jmRequest.initbox(e,{
                                        display: false
                                    }
                                );
                            }
                        });
                    }
                });
                $( this ).disableSelection();
            });
        }
    };
})(jQuery);