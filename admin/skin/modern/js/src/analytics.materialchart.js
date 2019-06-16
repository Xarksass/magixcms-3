gapi.analytics.ready(function() {
    google.charts.load('current', {'packages':['line'], 'language': iso});

    function parseHeaders(headers) {
        let datekey = null;
        let iso_headers = [];

        for(var i=0;i < headers.length; i++) {
            let cut = headers[i].name.indexOf(':');
            let key = headers[i].name.slice(cut + 1);
            iso_headers[i] = {label:global_var[key],id:key,type:(key === 'date'?'date':'number')};

            if(key === 'date' && datekey === null) {
                datekey = i;
            }
        }

        return {
            date: datekey,
            headers: iso_headers
        }
    }

    function parseDateData(data, key) {
        for(var j=0;j < data.length;j++) {
            let row = data[j];

            for(var k=0;k < row.length;k++) {
                if(k === key) {
                    let date = row[k];
                    if(typeof date === "string") {
                        let yyyy = date.slice(0,4);
                        let mm = date.slice(4,6);
                        let dd = date.slice(-2);
                        let datebject = new Date(yyyy+'-'+mm+'-'+dd);  // 2009-11-10
                        let month = datebject.toLocaleString(iso, { month: 'long' });
                        data[j][k] = {v:datebject, f:month+' '+dd};
                    }
                    else {
                        data[j][k] = date;
                    }
                }
                else {
                    data[j][k] = Number(row[k]);
                }
            }
        }

        return data;
    }

    gapi.analytics.createComponent('CustomMaterialChart', {
        initialize: function(options) {
            this.options = {
                colors: ['#64b5f6', '#1565c0', '#8bc34a'],
                width: '100%',
                legend: {
                    position: 'left'
                },
                hAxis: {
                    title: '',
                    format: 'd MMM'
                }
            };
            this.container = typeof options.container == 'string' ? options.container : 'chart';
        },
        drawChart: function(reportData) {
            let headers = reportData.columnHeaders;
            let parsedHeaders = parseHeaders(headers);

            let rows = (parsedHeaders.date !== null) ? parseDateData(reportData.rows, parsedHeaders.date) : reportData.rows;

            let data = [parsedHeaders.headers].concat(rows);
            data = google.visualization.arrayToDataTable(data);

            let chart = new google.charts.Line(document.getElementById(this.container));
            chart.draw(data, google.charts.Line.convertOptions(this.options));
        }
    });
});