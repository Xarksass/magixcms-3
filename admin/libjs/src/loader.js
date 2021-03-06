function makeid(length) {
    let result           = '';
    let characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let charactersLength = characters.length;
    for ( let i = 0; i < length; i++ ) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

class loaderSVG {
    constructor(options) {
        this.id = makeid(3);
        this.radius = 100;
        this.calculate();
        if(typeof options === 'object') {
            this.label = options.label ? options.label : null;
            this.background = options.background ? options.background : null;
        }
    }

    set(options) {
        let instance = this;
        for (var key in options) {
            if (options.hasOwnProperty(key)) instance[key] = options[key];
        }
        this.calculate();
    }

    calculate() {
        this.viewbox = {
            x: 0,
            y: 0,
            w: this.radius*2,
            h: this.radius*2
        };
        this.center = {
            x: this.viewbox.w/2,
            y: this.viewbox.h/2
        };
    }

    render(radius) {
        if(typeof radius === "number") this.set({radius: radius});
        let html = '<div id="loaderSVG_'+ this.id +'" class="svg-loader text-center'+ ((typeof this.label === "string") ? ' is-labelled" data-label="'+ this.label : '') +'">';
        html += '<svg xmlns="http://www.w3.org/2000/svg" width="'+ this.viewbox.w +'" height="'+ this.viewbox.h +'" viewBox="'+ this.viewbox.x +' '+ this.viewbox.y +' '+ this.viewbox.w +' '+ this.viewbox.h +'">\n';
        if(this.background === true) html += '\t<circle class="ring-bg" cx="'+ this.center.x +'" cy="'+ this.center.y +'" r="'+ this.radius +'"></circle>\n';
        html += '\t<circle class="outer" cx="'+ this.center.x +'" cy="'+ this.center.y +'" r="'+ this.radius +'"></circle>\n';
        html += '</svg></div>';

        return html;
    }

    remove() {
        document.getElementById('loaderSVG_'+this.id).remove();
    }
}