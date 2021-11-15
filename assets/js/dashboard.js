var ctx = document.getElementById("lineChart").getContext('2d');
var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        datasets: [{
            label: "Total # of Inquiries",
            backgroundColor: "rgba(155, 89, 182,0.2)",
            borderColor: "rgba(142, 68, 173,1.0)",
            pointBackgroundColor: "rgba(142, 68, 173,1.0)",
            data: [
                inquiry_jan,
                inquiry_feb,
                inquiry_mar,
                inquiry_apr,
                inquiry_may,
                inquiry_jun,
                inquiry_jul,
                inquiry_aug,
                inquiry_sep,
                inquiry_oct,
                inquiry_nov,
                inquiry_dec
            ]
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
})