import 'package:flutter/material.dart';
import 'package:tourism_host/Reusables/widgets/bottom_nav_buttons.dart';

class SelectAmenitiesPage extends StatefulWidget {
  @override
  _SelectAmenitiesPageState createState() => _SelectAmenitiesPageState();
}

class _SelectAmenitiesPageState extends State<SelectAmenitiesPage> {
  // A list to hold the selected amenities
  List<String> _selectedAmenities = [];

  // List of amenities divided by categories
  final Map<String, List<Map<String, dynamic>>> _amenities = {
    "Entertainment": [
      {"name": "Wi-Fi", "icon": Icons.wifi},
      {"name": "TV", "icon": Icons.tv},
      {"name": "Bluetooth Speaker", "icon": Icons.speaker},
      {"name": "Streaming Services", "icon": Icons.live_tv},
    ],
    "Outdoor": [
      {"name": "BBQ Machine", "icon": Icons.outdoor_grill},
      {"name": "Parking", "icon": Icons.local_parking},
      {"name": "Garden", "icon": Icons.nature},
      {"name": "Swimming Pool", "icon": Icons.pool},
      {"name": "Hot Tub", "icon": Icons.hot_tub},
      {"name": "Outdoor Furniture", "icon": Icons.chair},
    ],
    "Indoor": [
      {"name": "Air Conditioning", "icon": Icons.ac_unit},
      {"name": "Heater", "icon": Icons.thermostat},
      {"name": "Washer", "icon": Icons.local_laundry_service},
      {"name": "Dryer", "icon": Icons.device_thermostat},
      {"name": "Microwave", "icon": Icons.microwave},
      {"name": "Refrigerator", "icon": Icons.kitchen},
    ],
    "Safety": [
      {"name": "Fire Extinguisher", "icon": Icons.fire_extinguisher},
      {"name": "Smoke Detector", "icon": Icons.safety_divider},
      {"name": "First Aid Kit", "icon": Icons.health_and_safety},
      {"name": "Security Camera", "icon": Icons.security},
    ],
    "Special": [
      {"name": "Breakfast", "icon": Icons.fastfood},
      {"name": "Laundry", "icon": Icons.soap},
      {"name": "Spa", "icon": Icons.spa},
      {"name": "Airport Pickup", "icon": Icons.airplanemode_active},
    ]
  };

  // Function to handle selecting an amenity
  void _toggleSelection(String amenity) {
    setState(() {
      if (_selectedAmenities.contains(amenity)) {
        _selectedAmenities.remove(amenity);
      } else {
        _selectedAmenities.add(amenity);
      }
    });
  }

  // Continue button enabled when at least 4 amenities are selected
  bool _isContinueEnabled() {
    return _selectedAmenities.length >= 4;
  }

 @override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Large text sentences
                SizedBox(height: 30),
                const Text(
                  "Make your place Shine",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Divider(),
                SizedBox(height: 20),
                Text(
                  "Select the amenities available in your property",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, color: Colors.blueAccent[700], fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                // Property type tiles
                Column(
                  children: _amenities.entries.map((category) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child: Text(
                            category.key,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 15),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // Show 4 tiles per row
                            crossAxisSpacing: 15, // Spacing between tiles horizontally
                            mainAxisSpacing: 15, // Spacing between tiles vertically
                          ),
                          itemCount: category.value.length,
                          itemBuilder: (context, index) {
                            var amenity = category.value[index];
                            bool isSelected = _selectedAmenities.contains(amenity['name']);
                            return GestureDetector(
                              onTap: () => _toggleSelection(amenity['name']),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.lightBlue[100] : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(3, 3), // Shadow positioned at bottom-right
                                      blurRadius: 2, // Spread of the shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      amenity['icon'],
                                      size: 30, // Slightly smaller icon size
                                      color: isSelected ? Colors.black : Colors.grey,
                                    ),
                                    SizedBox(height: 8), // Reduced spacing
                                    Text(
                                      amenity['name'],
                                      style: TextStyle(
                                        fontSize: 14, // Reduced font size
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? Colors.black : Colors.grey,
                                      ),
                                      textAlign: TextAlign.center, // Center-aligned text for better readability
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 35),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                // Continue button
                ElevatedButton(
                  onPressed: _isContinueEnabled()
                      ? () {
                          // Handle continue action
                          Navigator.pushNamed(context, '/name_description');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected Amenities: $_selectedAmenities')),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    textStyle: TextStyle(fontSize: 16, color: Colors.white), // Text style
                    minimumSize: Size(MediaQuery.of(context).size.width, 50), // Full-width button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white), // Text color explicitly set to white
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationButtons(
          onNext: () {
            if ( _isContinueEnabled()) {
              Navigator.pushNamed(context, '/which_kind_of_place');
            } else {
              _showAlertDialog(context);
            }
          },
        ),
    ),
  );
}

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Please select at least one guest type before proceeding.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
