class mc_analytics {
    constructor(CID,VID) {
        this.auth_opt = {
            container: 'auth-button',
            clientid: CID
        };
        this.query = {
            ids:'ga:'+VID,
            metrics: 'ga:users,ga:sessions,ga:pageviews',
            dimensions: 'ga:date'
        };
        this.dateRange = {
            'start-date': '30daysAgo',
            'end-date': 'yesterday',
        };
        this.wait = null;
        this.reportData = null;
        this.dateRangeSelector = null;
        this.materialChart = null;
    }

    translateBtn() {
        let btn = document.getElementById('auth-button').getElementsByClassName('gapi-analytics-auth-styles-signinbutton-buttonText');
        btn[0].innerHTML = global_var.analyticsBtn;
    }

    getReportData(opt) {
        let instance = this;
        for (var key in opt) {
            if (opt.hasOwnProperty(key)) instance.query[key] = opt[key];
        }

        let report = new gapi.analytics.report.Data({
            query: instance.query
        });

        let success = false;

        report.on('success', function(response) {
            if(!success) {
                success = true;
                instance.validSignIn();
            }
            instance.reportData = response;
            instance.materialChart.drawChart(response);

        });

        report.on('error', function() {
            gapi.analytics.auth.signOut();
        });

        report.execute();
    }

    reDraw(ms) {
        let instance = this;
        if (instance.wait !== null) clearTimeout(instance.wait);
        instance.wait = setTimeout(function () {
            instance.materialChart.drawChart(instance.reportData);
        }, ms);
    }

    validSignIn() {
        let instance = this;
        document.getElementById('auth-button').classList.add('hide');
        document.getElementById('DateRangeSelector_container').classList.remove('hide');
        instance.dateRangeSelector.execute();

        instance.dateRangeSelector.on('change', function (d) {
            instance.dateRange = d;
            instance.getReportData(d);
        });
        window.addEventListener('resize', function () {
            instance.reDraw(750);
        });
        document.body.addEventListener('body-resize', function () {
            instance.reDraw(400);
        });
    }

    initialize() {
        let instance = this;

        instance.dateRangeSelector = new gapi.analytics.ext.DateRangeSelector({
            container: 'DateRangeSelector_container'
        });
        instance.materialChart = new gapi.analytics.ext.CustomMaterialChart({
            container: 'timeline'
        });

        instance.dateRangeSelector.set(instance.dateRange);

        gapi.analytics.auth.authorize(instance.auth_opt);

        gapi.analytics.auth.on('needsAuthorization', function () {
            instance.translateBtn();
        });

        gapi.analytics.auth.on('signOut', function () {
            gapi.analytics.auth.authorize(instance.auth_opt);
            document.getElementById('auth-button').classList.remove('hide');
            document.getElementById('DateRangeSelector_container').classList.add('hide');
            instance.translateBtn();
        });

        gapi.analytics.auth.on('signIn', function () {
            if(!gapi.analytics.auth.isAuthorized()) {
                gapi.analytics.auth.signOut();
            }
            else {
                instance.getReportData(instance.dateRange);
            }
        });
    }
}