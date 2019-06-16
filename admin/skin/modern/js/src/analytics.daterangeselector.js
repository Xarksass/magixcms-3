gapi.analytics.ready(function() {
    function t(t) {
        if (r.test(t))
            return t;
        var i = a.exec(t);
        if (i)
            return n(+i[1]);
        if ("today" == t)
            return n(0);
        if ("yesterday" == t)
            return n(1);
        if ("firstDayOfMonth" == t)
            return e();
        throw new Error("Cannot convert date " + t)
    }
    function e() {
        var t = new Date;
        return t.getFullYear().toString().padStart(4, 0) + "-" + (t.getMonth() + 1).toString().padStart(2, 0) + "-01"
    }
    function n(t) {
        var e = new Date;
        e.setDate(e.getDate() - t);
        var n = String(e.getMonth() + 1);
        n = 1 == n.length ? "0" + n : n;
        var a = String(e.getDate());
        return a = 1 == a.length ? "0" + a : a,
        e.getFullYear() + "-" + n + "-" + a
    }
    function cb(start, end) {
        let display = document.getElementById('reportrange').getElementsByTagName('span')[0];
        display.innerHTML = start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY');

        let sInput = document.getElementById('start-date'),
            eInput = document.getElementById('end-date');

        sInput.value = start.format('YYYY-MM-DD');
        eInput.value = end.format('YYYY-MM-DD');

        if ("createEvent" in document) {
            var evt = document.createEvent("HTMLEvents");
            evt.initEvent("change", false, true);
            sInput.dispatchEvent(evt);
            eInput.dispatchEvent(evt);
        }
        else {
            sInput.fireEvent("onchange");
            eInput.fireEvent("onchange");
        }
    }
    var a = /(\d+)daysAgo/
        , r = /\d{4}\-\d{2}\-\d{2}/;

    // This code will not run until the Embed API is fully loaded.
    gapi.analytics.createComponent('DateRangeSelector', {
        execute: function() {
            let e = this.get();
            e["start-date"] = e["start-date"] || "7daysAgo";
            e["end-date"] = e["end-date"] || "yesterday";
            this.container = "string" == typeof e.container ? document.getElementById(e.container) : e.container;
            let n = this.container.querySelectorAll("input");
            let start = moment().subtract(29, 'days');
            let end = moment();
            let ranges = {};

            ranges[global_var.Today] = [moment(), moment()];
            ranges[global_var.Yesterday] = [moment().subtract(1, 'days'), moment().subtract(1, 'days')];
            ranges[global_var.Days7] = [moment().subtract(6, 'days'), moment()];
            ranges[global_var.Days30] = [moment().subtract(29, 'days'), moment()];
            ranges[global_var.Month] = [moment().startOf('month'), moment().endOf('month')];
            ranges[global_var.LastMonth] = [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')];

            $('#reportrange').daterangepicker({
                parentEl: '#daterange',
                opens: "right",
                startDate: start,
                endDate: end,
                ranges: ranges,
                locale: {
                    customRangeLabel: global_var.CustomRange
                }
            }, cb);
            cb(start, end);

            return this.startDateInput = n[0],
                this.startDateInput.value = t(e["start-date"]),
                this.endDateInput = n[1],
                this.endDateInput.value = t(e["end-date"]),
                this.setValues(),
                this.setMinMax(),
                this.container.onchange = this.onChange.bind(this),
                this
        },
        onChange: function() {
            this.setValues();
            this.setMinMax();
            this.emit("change", {
                "start-date": this["start-date"],
                "end-date": this["end-date"]
            });
        },
        setValues: function() {
            this["start-date"] = this.startDateInput.value;
            this["end-date"] = this.endDateInput.value;
        },
        setMinMax: function() {
            this.startDateInput.max = this.endDateInput.value;
            this.endDateInput.min = this.startDateInput.value;
        }
    });
});