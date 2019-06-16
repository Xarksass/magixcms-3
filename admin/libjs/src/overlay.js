function makeid(length) {
    let result           = '';
    let characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let charactersLength = characters.length;
    for ( let i = 0; i < length; i++ ) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

class overlay {
    constructor(options) {
        this.element = null;
        this.target = options.target;
        this.method = options.method;
        this.id = makeid(3);

        this.create();
    }

    create() {
        let ol = document.createElement('div');

        let olid = document.createAttribute("id");
        olid.value = 'overlay_'+this.id;
        ol.setAttributeNode(olid);

        let olclass = document.createAttribute("class");
        olclass.value = "overlay";
        ol.setAttributeNode(olclass);

        let footer = document.getElementById('footer');
        footer.parentNode.insertBefore(ol, footer.nextSibling);

        this.element = ol;
        this.activate(true);
    }

    toggle(mode) {
        this.element.classList.toggle('active',mode);
    }

    activate() {
        let self = this;
        self.toggle(true);
        self.element.addEventListener('click',function(){ self.destroy(); });
    }

    destroy() {
        let self = this,
            target = document.getElementById(self.target);

        switch (self.method.type) {
            case 'class':
                target.classList.remove(self.method.class);
                break;
            case 'collapse':
                // ToDo
                break;
            default:
                return;
        }

        self.toggle(false);
        document.body.removeChild(self.element);
    }
}