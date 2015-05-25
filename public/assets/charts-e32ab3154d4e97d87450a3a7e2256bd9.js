///////////////////////
//////// Data /////////
///////////////////////

var loadChartsData = {
  init: function(totalOnline, totalCasino, onlineHours, casinoHours, largestOnline, largestCasino, tournOnline, tournCasino, leastOnline, mostOnline, leastCasino, mostCasino) {
    this.totalOnline = totalOnline;
    this.totalCasino = totalCasino;
    this.onlineHours = onlineHours;
    this.casinoHours = casinoHours;
    this.largestOnline = largestOnline;
    this.largestCasino = largestCasino;
    this.tournOnline = tournOnline;
    this.tournCasino = tournCasino;
    this.leastOnline = leastOnline;
    this.mostOnline = mostOnline;
    this.leastCasino = leastCasino;
    this.mostCasino = mostCasino;
    google.load('visualization', '1.0', {'packages':['corechart']});
    google.setOnLoadCallback(this.drawChart);
  },


  drawChart: function() {
    charts.renderOnlineTotalProfitLoss();
    charts.renderCasinoTotalProfitLoss();

    charts.renderOnlineTotalHours();
    charts.renderCasinoTotalHours();

    charts.renderOnlineLargest();
    charts.renderCasinoLargest();

    charts.renderOnlineTourn();
    charts.renderCasinoTourn();

    charts.renderLeastOnline();
    charts.renderMostOnline();

    charts.renderLeastCasino();
    charts.renderMostCasino();

  }
}










var charts = {

  /////////////////////////////////////////
  // Total Gain And Loss By Month //
  ////////////////////////////////////////
  totalChartOptions: function() {
    return {
      width: 364, height: 200,
      axis: 'continuous',
      pointSize: 5,
      vAxis: {title: "Profit/Loss"},
      hAxis: {title: "Month"},
      colors:['#288B18','#EE6060'],
      backgroundColor: '#F2F2F2',
      legend: {position: 'none'}
    };
  },

  // Online
  renderOnlineTotalProfitLoss: function() {
    var totalOnlineTable = new google.visualization.DataTable();
    totalOnlineTable.addColumn('string', 'Month');
    totalOnlineTable.addColumn('number', 'Profit');
    totalOnlineTable.addColumn('number', 'Loss');
    totalOnlineTable.addRows(loadChartsData.totalOnline);

    var totalOnlineView = new google.visualization.DataView(totalOnlineTable);
    var onlineTotalChart = new google.visualization.LineChart(document.getElementById('total_online'));
    onlineTotalChart.draw(totalOnlineView, this.totalChartOptions());
  },

  // Casino

  renderCasinoTotalProfitLoss: function() {
    var totalCasinoTable = new google.visualization.DataTable();
    totalCasinoTable.addColumn('string', 'Month');
    totalCasinoTable.addColumn('number', 'Profit');
    totalCasinoTable.addColumn('number', 'Loss');
    totalCasinoTable.addRows(loadChartsData.totalCasino);

    var totalCasinoView = new google.visualization.DataView(totalCasinoTable);
    var casinoTotalChart = new google.visualization.LineChart(document.getElementById('total_casino'));
    casinoTotalChart.draw(totalCasinoView, this.totalChartOptions());

  },

  ///////////////////////////////////
  // Total Hours Played By Month   //
  ///////////////////////////////////

  totalHoursOptions: function() {
    return {
      width: 364, height: 200,
      backgroundColor: '#F2F2F2',
      legend: {position: 'none'},
      colors:['#000000'],
      tooltip: { isHtml: true },
      pointSize: 5,
      vAxis: {title: "Hours"},
      hAxis: {title: "Month"}
    };
  },

  hoursTooltip: function(month, hours, avg) {
    return '<div style="padding:5px;text-align:center;min-width:200px;background-color:#E7E7E7;border:none;">' +
            '<p style="margin:0;">Total Hours: ' + hours + '</p>' +
            '<p style="margin:0;">Average hours: ' + avg + '</p>' +
            '</div>'
  },

  // Online
  renderOnlineTotalHours: function() {
    var onlineHourTable = new google.visualization.DataTable();
    onlineHourTable.addColumn('string', 'Month');
    onlineHourTable.addColumn('number', 'Hours');
    onlineHourTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});

    var self = this;
    $.each(loadChartsData.onlineHours, function(index,el) {
      onlineHourTable.addRows([[el[0], el[1], self.hoursTooltip(el[0], el[1], el[2]) ]]);
    });
    var onlineHoursChart = new google.visualization.LineChart(document.getElementById('hours_online'));
    onlineHoursChart.draw(onlineHourTable, this.totalHoursOptions())
  },

  // Casino
  renderCasinoTotalHours: function() {
    var casinoHoursTable = new google.visualization.DataTable();
    casinoHoursTable.addColumn('string', 'Month');
    casinoHoursTable.addColumn('number', 'Hours');
    casinoHoursTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});

    var self = this;
    $.each(loadChartsData.casinoHours, function(index,el) {
      casinoHoursTable.addRows([[el[0], el[1], self.hoursTooltip(el[0], el[1], el[2]) ]]);
    });

    var casinoHoursChart = new google.visualization.LineChart(document.getElementById('hours_casino'));
    casinoHoursChart.draw(casinoHoursTable, this.totalHoursOptions())
  },

  /////////////////////////////////////
  // Largest Win Worst Loss By Month //
  /////////////////////////////////////

  largestOptions: function() {
    return {
      width: 364, height: 200,
      axis: 'continuous',
      pointSize: 5,
      vAxis: {title: "Profit/Loss"},
      hAxis: {title: "Month"},
      colors:['#288B18','#EE6060'],
      backgroundColor: '#F2F2F2',
      tooltip: { isHtml: true },
      legend: {position: 'none'}
    };
  },

  largestWinTooltip: function(win, date, location) {
    return '<div style="padding:5px;text-align:center;min-width:200px;background-color:#E7E7E7;border:none;">' +
            '<p style="margin:0;">' + date + '</p>' +
            '<p style="margin:0;color:#57931E">Largest Win: $'+ win + '</p>' +
            '<p>Poker Room: ' + location + '</p>' +
            '</div>';
  },

  largestLossTooltip: function(loss, date, location) {
    return '<div style="padding:5px;text-align:center;min-width:200px;background-color:#E7E7E7;border:none;">' +
            '<p style="margin:0;">' + date + '</p>' +
            '<p style="margin:0;color:#CE3830">Worst Loss: $'+ Math.abs(loss) + '</p>' +
            '<p>Poker Room: ' + location + '</p>' +
            '</div>';
  },

  // Online
  renderOnlineLargest: function() {
    var largestOnlineTable = new google.visualization.DataTable();
    largestOnlineTable.addColumn('string', 'Month');
    largestOnlineTable.addColumn('number', 'Profit');
    largestOnlineTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
    largestOnlineTable.addColumn('number', 'Loss');
    largestOnlineTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});

    var self = this;
    $.each(loadChartsData.largestOnline, function(index,el) {
      largestOnlineTable.addRows([[
        el[0],
        el[1],
        self.largestWinTooltip(el[1], el[2], el[3]),
        el[4],
        self.largestLossTooltip(el[4], el[5], el[6])
      ]]);
    });

    var largestOnlineChart = new google.visualization.LineChart(document.getElementById('largest_online'));
    largestOnlineChart.draw(largestOnlineTable, this.largestOptions());

  },

  // Casino
  renderCasinoLargest: function() {
    var largestCasinoTable = new google.visualization.DataTable();
    largestCasinoTable.addColumn('string', 'Month');
    largestCasinoTable.addColumn('number', 'Profit');
    largestCasinoTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
    largestCasinoTable.addColumn('number', 'Loss');
    largestCasinoTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});

    var self = this;
    $.each(loadChartsData.largestCasino, function(index,el) {
      largestCasinoTable.addRows([[
        el[0],
        el[1],
        self.largestWinTooltip(el[1], el[2], el[3]),
        el[4],
        self.largestLossTooltip(el[4], el[5], el[6])
      ]]);
    });

    var largestCasinoChart = new google.visualization.LineChart(document.getElementById('largest_casino'));
    largestCasinoChart.draw(largestCasinoTable, this.largestOptions());

  },

  /////////////////////////////////////
  // Tournament Winning Summary //
  /////////////////////////////////////

  barOptions: function() {
    return {
      width: 364, height: 200,
      backgroundColor: '#F2F2F2',
      legend: {position: 'none'},
      colors:['#656565'],
      bar: {groupWidth: "10%"},
      vAxis: {title: "Number Of Tournaments"},
      hAxis: {title: "Month"},
      tooltip: { isHtml: true }
    };
  },

  tournTooltip: function(tournaments, total) {
    var htmlArray = ['<div style="padding:5px;text-align:center;min-width:300px;background-color:#E7E7E7;border:none;">'];

    $.each(tournaments, function(index, array) {
      name = array[0];
      amount = array[1];
      date = array[2];
      if (amount >= 0) {
        html = '<p style="margin:0;">' + name + ': <span style="color:#288B18;">$' + amount + '</span> on ' + date + '</p>';
      } else {
        html = '<p style="margin:0;">' + name + ': <span style="color:#CE3830;">' + amount.slice(0, 1) + "$" + amount.slice(1) + '</span> on ' + date + '</p>';
      }

      htmlArray.push(html);
    });
    if (total >= 0) {
      htmlArray.push('<p style="margin:0;">Total Tournament Winnings: <span style="color:#288B18;">$'+ total + '</span></p></div>');
    } else {
      htmlArray.push('<p style="margin:0;">Total Tournament Loss: <span style="color:#CE3830;">($'+ Math.abs(total) + ')</span></p></div>');

    }

    return htmlArray.join('');

  },

  // Online
  renderOnlineTourn: function() {
    var onlineTournWinTable = new google.visualization.DataTable();
    onlineTournWinTable.addColumn('string', 'Month');
    onlineTournWinTable.addColumn('number', 'Winnings');
    onlineTournWinTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});


    var self = this;
    $.each(loadChartsData.tournOnline, function(index,el) {
      onlineTournWinTable.addRows([[
        el[0],
        el[1],
        self.tournTooltip(el[2], el[3])
      ]]);
    });

    var onlineTournChart = new google.visualization.ColumnChart(document.getElementById('tourn_online'));
    onlineTournChart.draw(onlineTournWinTable, this.barOptions());


  },

  // Casino
  renderCasinoTourn: function() {
    var casinoTournWinTable = new google.visualization.DataTable();
    casinoTournWinTable.addColumn('string', 'Month');
    casinoTournWinTable.addColumn('number', 'Winnings');
    casinoTournWinTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});


    var self = this;
    $.each(loadChartsData.tournCasino, function(index,el) {
      casinoTournWinTable.addRows([[
        el[0],
        el[1],
        self.tournTooltip(el[2], el[3])
      ]]);
    });

    var casinoTournChart = new google.visualization.ColumnChart(document.getElementById('tourn_casino'));
    casinoTournChart.draw(casinoTournWinTable, this.barOptions());

  },

  //////////////////////////////////////////////
  // Least And Most Profitable Room By Month //
  //////////////////////////////////////////////

  leastPieOptions: function() {
    return {
      width: 184, height: 200,
      title: 'Least Profitable Room',
      legend: {position: 'none'},
      pieSliceText: 'none',
      backgroundColor: '#F2F2F2',
      colors: ['#D75F59', '#E08880', '#F5D8D5'],
      tooltip: { isHtml: true }
    };

  },

  mostPieOptions: function() {
    return {
      width: 184, height: 200,
      title: 'Most Profitable Room',
      legend: {position: 'none'},
      pieSliceText: 'none',
      backgroundColor: '#F2F2F2',
      colors: ['#2D4907', '#599118', '#BDD39B'],
      tooltip: { isHtml: true }

    };

  },
  // Curent not supported for Google Pie Charts
  leastPieTooltip: function(room, amount) {
    return '<div style="padding:5px;text-align:center;min-width:300px;background-color:#E7E7E7;border:none;">' +
           '<p style="margin:0;"sdfsdf>' + room + '</p>' +
           '<p style="margin:0;color:#D75F59;">Loss: ' + amount + 'dfdfd</p>' +
           '</div>';

  },

  // Online
  renderLeastOnline: function() {
    var leastOnlineTable = new google.visualization.DataTable();
    leastOnlineTable.addColumn('string', 'Room');
    leastOnlineTable.addColumn('number', 'Loss');
    leastOnlineTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});

    var self = this;
    $.each(loadChartsData.leastOnline, function(index,el) {
       leastOnlineTable.addRows([[
         el[0],
         Math.abs(el[1]),
         self.leastPieTooltip(el[0], el[1])
       ]]);
    });

    var leastOnlineChart = new google.visualization.PieChart(document.getElementById('least_room_online'));
    leastOnlineChart.draw(leastOnlineTable, this.leastPieOptions());

  },

  renderMostOnline: function() {
    var mostOnlineTable = new google.visualization.DataTable();
    mostOnlineTable.addColumn('string', 'Room');
    mostOnlineTable.addColumn('number', 'Loss');
    mostOnlineTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});


    var self = this;
    $.each(loadChartsData.mostOnline, function(index,el) {
      mostOnlineTable.addRows([[
        el[0],
        Math.abs(el[1]),
        self.leastPieTooltip(el[0], el[1])
      ]]);
    });

    var mostOnlineChart = new google.visualization.PieChart(document.getElementById('most_room_online'));
    mostOnlineChart.draw(mostOnlineTable, this.mostPieOptions());

  },

  // Casino
  renderLeastCasino: function() {
    var leastCasinoTable = new google.visualization.DataTable();
    leastCasinoTable.addColumn('string', 'Room');
    leastCasinoTable.addColumn('number', 'Loss');
    leastCasinoTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});

    var self = this;
    $.each(loadChartsData.leastCasino, function(index,el) {
       leastCasinoTable.addRows([[
         el[0],
         Math.abs(el[1]),
         self.leastPieTooltip(el[0], el[1])
       ]]);
    });

    var leastCasinoChart = new google.visualization.PieChart(document.getElementById('least_room_casino'));
    leastCasinoChart.draw(leastCasinoTable, this.leastPieOptions());

  },

  renderMostCasino: function() {
    var mostCasinoTable = new google.visualization.DataTable();
    mostCasinoTable.addColumn('string', 'Room');
    mostCasinoTable.addColumn('number', 'Loss');
    mostCasinoTable.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});


    var self = this;
    $.each(loadChartsData.mostCasino, function(index,el) {
      mostCasinoTable.addRows([[
        el[0],
        Math.abs(el[1]),
        self.leastPieTooltip(el[0], el[1])
      ]]);
    });

    var mostCasinoChart = new google.visualization.PieChart(document.getElementById('most_room_casino'));
    mostCasinoChart.draw(mostCasinoTable, this.mostPieOptions());

  }
}


;
