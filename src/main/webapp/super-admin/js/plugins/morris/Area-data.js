// Morris.js Charts sample data for SB Admin template

$(function() {

    // Area Chart
    Morris.Area({
        element: 'morris-area-chart',
        data: [{
            period: '1 Q1',
            iphone: 2666,
            ipad: null,
            itouch: 2647
        }, {
            period: '1 Q2',
            iphone: 2778,
            ipad: 2294,
            itouch: 2441
        }, {
            period: '1 Q3',
            iphone: 4912,
            ipad: 1969,
            itouch: 2501
        }, {
            period: '1 Q4',
            iphone: 3767,
            ipad: 3597,
            itouch: 5689
        }, {
            period: '1 Q1',
            iphone: 6810,
            ipad: 1914,
            itouch: 2293
        }, {
            period: '1 Q2',
            iphone: 5670,
            ipad: 4293,
            itouch: 1881
        }, {
            period: '1 Q3',
            iphone: 4820,
            ipad: 3795,
            itouch: 1588
        }, {
            period: '1 Q4',
            iphone: 15073,
            ipad: 5967,
            itouch: 5175
        } ],
        xkey: 'period',
        ykeys: ['iphone', 'ipad', 'itouch'],
        labels: ['iPhone', 'iPad', 'iPod Touch'],
        pointSize: 2,
        hideHover: 'auto',
        resize: true
    });

   

});
