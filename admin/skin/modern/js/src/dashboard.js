const dashboard =  {
    initQuickMenu: function () {
        let btn = document.getElementById('quick-add-menu').getElementsByClassName('menu-trigger');

        let btn_overlay = null;
        btn[0].addEventListener('click',function(e){
            e.preventDefault();
            let target = this.parentNode;
            let opened = target.classList.contains('open');
            target.classList.toggle('open',!opened);
            if(!opened) {
                btn_overlay = new overlay({
                    target: 'quick-add-menu',
                    method: {
                        type: 'class',
                        class: 'open'
                    }
                });
            }
            else {
                btn_overlay.destroy();
                btn_overlay = null;
            }
            return false;
        });
    },
};

window.addEventListener('load',function(){
    dashboard.initQuickMenu();

    const analytics = new mc_analytics(CLIENT_ID, VIEW_ID);

    gapi.analytics.ready(function() {
        analytics.initialize();
    });
});