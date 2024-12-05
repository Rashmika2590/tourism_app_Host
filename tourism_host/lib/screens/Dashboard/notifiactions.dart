import 'package:flutter/material.dart';

class HostNotificationPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'type': 'New Booking Arrival',
      'message': 'Booking confirmed for John Doe at Seaside Bliss.',
      'timestamp': '5 mins ago',
    },
    {
      'type': 'Message from User',
      'message': 'Jane Smith: Can I check in earlier?',
      'timestamp': '10 mins ago',
    },
    {
      'type': 'Check-in Reminder',
      'message': 'Reminder: Alex Johnson is arriving today.',
      'timestamp': '1 hour ago',
    },
    {
      'type': 'Check-out Notification',
      'message': 'Michael Clark has checked out.',
      'timestamp': '2 hours ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    //final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Scrollable Notification List
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.12),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
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
                          notification['type']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          notification['message']!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          notification['timestamp']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Fixed Messaging Section
          // Positioned(
          //   bottom: 0,
          //   child: Container(
          //     width: screenWidth,
          //     color: Colors.white,
          //     padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: TextField(
          //             decoration: InputDecoration(
          //               hintText: 'Type your message...',
          //               hintStyle: TextStyle(color: Colors.grey[600]),
          //               filled: true,
          //               fillColor: Colors.grey[200],
          //               contentPadding: const EdgeInsets.symmetric(
          //                   vertical: 10.0, horizontal: 12.0),
          //               border: OutlineInputBorder(
          //                 borderRadius: BorderRadius.circular(25.0),
          //                 borderSide: BorderSide.none,
          //               ),
          //             ),
          //           ),
          //         ),
          //         const SizedBox(width: 10),
          //         ElevatedButton(
          //           onPressed: () {
          //             // Handle send message
          //           },
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: Colors.blueAccent,
          //             shape: const CircleBorder(),
          //             padding: const EdgeInsets.all(12.0),
          //           ),
          //           child: const Icon(Icons.send, color: Colors.white),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
