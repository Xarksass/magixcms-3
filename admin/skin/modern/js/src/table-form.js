/**
 * @version    2.0
 * @author Salvatore Di Salvo <disalvo.infographiste@gmail.com>
 */
class TableForm {
    constructor() {
        if(typeof $ === "undefined") throw new Error("jQuery is required by GlobalForm to run properly");
        this.controller = null;
        this.offset = null;
    }

    set(options) {
        let instance = this;
        for (var key in options) {
            if (options.hasOwnProperty(key)) instance[key] = options[key];
        }
    }

    initCheckboxSelect() {
        $('.check-all').off().on('change',function(){
            let table = $(this).data('table');
            let chb = $('#table-'+table+' input[type="checkbox"]:enabled');
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

    initSortable() {
        let instance = this;
        if($.sortable !== undefined) {
            $.each($( ".ui-sortable" ), function() {
                $(this).sortable({
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
                            url: instance.controller+'&action=order'+(instance.offset !== null ? '&offset='+instance.offset : ''),
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
                $(this).disableSelection();
            });
        }
    }

    initialize() {
        this.initCheckboxSelect();
        this.initSortable();
    }
}
const tableForm = new TableForm();

$(document).ready(function(){
    if(controller && offset) {
        tableForm.set({
            controller: controller,
            offset: offset
        });
        tableForm.initialize();
    }
});