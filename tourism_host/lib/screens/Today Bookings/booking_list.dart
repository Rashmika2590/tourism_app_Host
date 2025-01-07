import 'package:flutter/material.dart';
import 'package:tourism_host/Reusables/widgets/bottom_nav_buttons.dart';
import 'package:tourism_host/screens/Today%20Bookings/booking_detail.dart';

class TodaysBookingPage extends StatefulWidget {
  @override
  _TodaysBookingPageState createState() => _TodaysBookingPageState();
}

class _TodaysBookingPageState extends State<TodaysBookingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool showOngoing = false;

  final List<Map<String, String>> shortStayNewBookings = [
    {
      'guestName': 'John Doe',
      'property': 'Seaside Bliss',
      'checkInDate': '2024-12-06',
      'status': 'Confirmed',
    },
    {
      'guestName': 'Jane Smith',
      'property': 'Urban Retreat',
      'checkInDate': '2024-12-06',
      'status': 'Pending',
    },
  ];

  final List<Map<String, String>> shortStayOngoingBookings = [
    {
      'guestName': 'Alice Brown',
      'property': 'Beach Haven',
      'checkOutDate': '2024-12-08',
    },
  ];

  final List<Map<String, String>> longStayNewBookings = [
    {
      'guestName': 'Alex Johnson',
      'property': 'Mountain Escape',
      'checkInDate': '2024-12-06',
      'status': 'Confirmed',
    },
    {
      'guestName': 'Emily Davis',
      'property': 'Countryside Villa',
      'checkInDate': '2024-12-06',
      'status': 'Pending',
    },
  ];

  final List<Map<String, String>> longStayOngoingBookings = [
    {
      'guestName': 'Michael Clark',
      'property': 'Valley Retreat',
      'checkOutDate': '2024-12-15',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget bookingCard(Map<String, String> booking, bool isOngoing) {
    return GestureDetector(
      onTap: () {
        // Handle card tap
       Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingDetailsPage(
            bookingDetails: {
              'name': 'John Doe',
              'email': 'john.doe@example.com',
              'checkInDate': '2024-12-06',
              'checkOutDate': '2024-12-08',
              'roomType': 'Deluxe',
              'roomQty': 2,
              'amenities': ['WiFi', 'Breakfast'],
              'packageName': 'Honeymoon Package',
            },
          ),
        ),
      );

        print('${booking['guestName']} tapped');
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${booking['guestName']}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${booking['property']}',
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                isOngoing
                    ? 'Check-out Date: ${booking['checkOutDate']}'
                    : 'Check-in Date: ${booking['checkInDate']}',
                style: const TextStyle(fontSize: 14),
              ),
              if (!isOngoing)
                Text(
                  '${booking['status']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: booking['status'] == 'Confirmed'
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.045,left: screenWidth*0.05),
              child: Text(
                'Today\'s Bookings',
                style: TextStyle(
                  fontSize: screenHeight * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      
            // Tabs
            Container(
              padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                bottom: screenHeight * 0.02,
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.blueAccent,
                labelColor: Colors.blueAccent,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: 'Short Stay'),
                  Tab(text: 'Long Stay'),
                ],
              ),
            ),
      
            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Short Stay Tab
                  Column(
                    children: [
                      // Buttons
                      // Inside the respective `Row` widget for buttons
                      SizedBox(height: screenHeight*0.025,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start, // Change here to align to left
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  showOngoing = true;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: showOngoing ? Colors.blueAccent : Colors.grey[200],
                                foregroundColor: showOngoing ? Colors.white : Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              child: const Text('Ongoing Bookings'),
                            ),
                            SizedBox(width: screenWidth*0.05,),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  showOngoing = false;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: !showOngoing ? Colors.blueAccent : Colors.grey[200],
                                foregroundColor: !showOngoing ? Colors.white : Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              child: const Text('New Bookings'),
                            ),
                          ],
                        ),
                      ),
                      // List of Bookings
                      Expanded(
                        child: ListView.builder(
                          itemCount: showOngoing
                              ? shortStayOngoingBookings.length
                              : shortStayNewBookings.length,
                          itemBuilder: (context, index) {
                            return bookingCard(
                              showOngoing
                                  ? shortStayOngoingBookings[index]
                                  : shortStayNewBookings[index],
                              showOngoing,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      
                  // Long Stay Tab
                  Column(
                    children: [
                      // Buttons
                      // Inside the respective `Row` widget for buttons
                      SizedBox(height: screenHeight*0.025,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end, // Change here to align to left
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  showOngoing = true;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: showOngoing ? Colors.blueAccent : Colors.grey[200],
                                foregroundColor: showOngoing ? Colors.white : Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              child: const Text('Ongoing Bookings'),
                            ),
                            SizedBox(width: screenWidth*0.05,),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  showOngoing = false;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: !showOngoing ? Colors.blueAccent : Colors.grey[200],
                                foregroundColor: !showOngoing ? Colors.white : Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              child: const Text('New Bookings'),
                            ),
                          ],
                        ),
                      ),
                      // List of Bookings
                      Expanded(
                        child: ListView.builder(
                          itemCount: showOngoing
                              ? longStayOngoingBookings.length
                              : longStayNewBookings.length,
                          itemBuilder: (context, index) {
                            return bookingCard(
                              showOngoing
                                  ? longStayOngoingBookings[index]
                                  : longStayNewBookings[index],
                              showOngoing,
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed:(){
                          Navigator.pushNamed(context, '/report');
                        }, 
                        child: Text('Report')
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationButtons(
          onNext: () {
              Navigator.pushNamed(context, '/which_kind_of_place');
          },
        ),
      ),
    );
  }
}
