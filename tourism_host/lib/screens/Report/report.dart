import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BookingReportPage extends StatefulWidget {
  @override
  _BookingReportPageState createState() => _BookingReportPageState();
}

class _BookingReportPageState extends State<BookingReportPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Widget buildChart(String period) {
    // Example data
    final List<double> bookingsData = period == "Today"
        ? [5, 10, 15, 7, 12]
        : period == "This Week"
            ? [20, 25, 30, 22, 27, 35, 40]
            : [150, 180, 200, 170, 190, 210, 230, 250, 260, 280];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Booking Trends for $period',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 1.5,
            child: BarChart(
              BarChartData(
                barGroups: bookingsData
                    .asMap()
                    .map((index, value) => MapEntry(
                          index,
                          BarChartGroupData(x: index, barRods: [
                            BarChartRodData(toY: value, color: Colors.blueAccent),
                          ]),
                        ))
                    .values
                    .toList(),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        if (period == "Today") {
                          const labels = ['8 AM', '10 AM', '12 PM', '2 PM', '4 PM'];
                          return Text(labels[value.toInt()]);
                        } else if (period == "This Week") {
                          const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                          return Text(labels[value.toInt()]);
                        } else {
                          return Text("Day ${value.toInt() + 1}");
                        }
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSummaryCard(String title, String value, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildTabContent(String period) {
    // Example data for each tab
    final Map<String, dynamic> data = {
      "Today": {
        "totalBookings": "25",
        "revenue": "\$500",
        "cancellations": "2",
        "pending": "3"
      },
      "This Week": {
        "totalBookings": "150",
        "revenue": "\$3,000",
        "cancellations": "10",
        "pending": "8"
      },
      "This Month": {
        "totalBookings": "600",
        "revenue": "\$12,000",
        "cancellations": "30",
        "pending": "20"
      },
    };

    final currentData = data[period]!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Booking Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 3,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              buildSummaryCard('Total Bookings', currentData["totalBookings"], Colors.blue),
              buildSummaryCard('Revenue', currentData["revenue"], Colors.green),
              buildSummaryCard('Cancellations', currentData["cancellations"], Colors.red),
              buildSummaryCard('Pending', currentData["pending"], Colors.orange),
            ],
          ),
          SizedBox(height: 20),
          // Chart Section
          buildChart(period),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Property Booking Report'),
          backgroundColor: Colors.blueAccent,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Today'),
              Tab(text: 'This Week'),
              Tab(text: 'This Month'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            buildTabContent('Today'),
            buildTabContent('This Week'),
            buildTabContent('This Month'),
          ],
        ),
      ),
    );
  }
}
