import 'package:flutter/material.dart';

class BookingDetailsPage extends StatelessWidget {
  final Map<String, dynamic> bookingDetails;

  const BookingDetailsPage({Key? key, required this.bookingDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Section
              SizedBox(height: 35),
              const Text(
                "Booking Request for",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Divider(),
              SizedBox(height: 20),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(height: screenHeight * 0.02),
                // Booking Details Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(screenHeight * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Name', bookingDetails['name']),
                        _buildDetailRow('Email', bookingDetails['email']),
                        _buildDetailRow('Check-in Date', bookingDetails['checkInDate']),
                        _buildDetailRow('Check-out Date', bookingDetails['checkOutDate']),
                        _buildDetailRow('Room Type', bookingDetails['roomType']),
                        _buildDetailRow(
                          'Room Quantity',
                          '${bookingDetails['roomQty']}',
                        ),
                        _buildDetailRow(
                          'Additional Amenities',
                          bookingDetails['amenities'].isNotEmpty
                              ? bookingDetails['amenities'].join(', ')
                              : 'None',
                        ),
                        _buildDetailRow(
                          'Package',
                          bookingDetails['packageName'] ?? 'No package selected',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Positioned Buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
                horizontal: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Confirm Button
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Booking Confirmed')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                        vertical: screenHeight * 0.015,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    icon: const Icon(Icons.check,color: Colors.white,),
                    label: const Text(
                      'Confirm',
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                  ),

                  Spacer(),

                  // Decline Button
                  ElevatedButton.icon(
                    onPressed: () {
                      _showDeclineDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                        vertical: screenHeight * 0.015,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    icon: const Icon(Icons.cancel,color: Colors.white,),
                    label: const Text(
                      'Decline',
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Detail Row Widget
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Decline Dialog
  Future<void> _showDeclineDialog(BuildContext context) async {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Decline Booking',
            style: TextStyle(color: Colors.red),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please provide a reason for declining this booking:',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter reason',
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (reasonController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reason cannot be empty')),
                  );
                } else {
                  Navigator.pop(context); // Close dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Booking Declined: ${reasonController.text}',
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Decline'),
            ),
          ],
        );
      },
    );
  }
}
