/**
 * @version    2.0
 * @author Salvatore Di Salvo <disalvo.infographiste@gmail.com>
 */
class NiceForms {
    constructor(selector, exclude) {
        if(typeof $ === "undefined") throw new Error("jQuery is required by GlobalForm to run properly");
        this.selector = typeof selector !== 'string' ? '.nice-form' : selector;
        this.exclude = typeof exclude !== 'string' ? '.not-nice' : exclude;
    }

    static isEmpty(elem) {
        let val = elem.val();
        return ((typeof val === 'string' && val.length === 0) || (typeof val === 'object' && val == null));
    }

    updateParent(elem) {
        $('[for="'+elem.attr('id')+'"]').toggleClass('is_empty', NiceForms.isEmpty(elem));
    }

    reset() {
        let instance = this;
        $(instance.selector).each(function(){
            let nicefields = $(this).find('input:not('+instance.exclude+'),textarea:not('+instance.exclude+'),select:not('+instance.exclude+')');
            nicefields.each(function(){ instance.updateParent($(this)); });
        });
    }

    init() {
        let instance = this;
        $(instance.selector).each(function(){
            let inputs = $(this).find('input:not('+instance.exclude+')');
            let txtareas = $(this).find('textarea:not('+instance.exclude+')');
            let selects = $(this).find('select:not('+instance.exclude+')');

            inputs.each(function(){
                let self = $(this);
                if(self.attr('type') !== 'hidden') {
                    instance.updateParent(self);
                    self.on('change',function(){instance.updateParent(self)});
                }
            });
            txtareas.each(function(){
                let self = $(this);
                instance.updateParent(self);
                self.on('change',function(){instance.updateParent(self)});
            });
            selects.each(function(){
                let self = $(this);
                instance.updateParent(self);
                self.on('change',function(){instance.updateParent(self)});
            });
        });
    }
}
const niceForms = new NiceForms();

$(document).ready(function(){
    niceForms.init();
});