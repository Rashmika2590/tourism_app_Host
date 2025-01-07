import 'package:flutter/material.dart';
import 'package:tourism_host/Reusables/widgets/bottom_nav_buttons.dart';

class PropertyTypeSelectionPage extends StatefulWidget {
  @override
  _PropertyTypeSelectionPageState createState() =>
      _PropertyTypeSelectionPageState();
}

class _PropertyTypeSelectionPageState extends State<PropertyTypeSelectionPage> {
  final List<Map<String, dynamic>> propertyTypes = [
  {'type': 'Villa', 'icon': Icons.villa},
  {'type': 'Hotel', 'icon': Icons.hotel},
  {'type': 'Homestay', 'icon': Icons.home},
  {'type': 'Guesthouse', 'icon': Icons.apartment},
  {'type': 'Cottage', 'icon': Icons.cottage}, // New
  {'type': 'Resort', 'icon': Icons.pool}, // New
  {'type': 'Farmhouse', 'icon': Icons.landscape}, // New
  {'type': 'Cabin', 'icon': Icons.cabin}, // New
  {'type': 'Hostel', 'icon': Icons.meeting_room}, // New
];


  int? _selectedIndex;

  void _onTileTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Large text sentences
                SizedBox(height: 30,),
                const Text(
                  "Tell us about your place",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Divider(),
                SizedBox(height: 25),
                Text(
                  "What are you registering?.",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, color: Colors.blueAccent[700],fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                // Property type tiles
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Reduced tile size by increasing the number of columns
                      crossAxisSpacing: 20, // Reduced spacing between columns
                      mainAxisSpacing: 20, // Reduced spacing between rows
                    ),
                    itemCount: propertyTypes.length,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedIndex == index;
                      return GestureDetector(
                        onTap: () => _onTileTap(index),
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
                                propertyTypes[index]['icon'],
                                size: 30, // Slightly smaller icon size
                                color: isSelected ? Colors.black : Colors.grey,
                              ),
                              SizedBox(height: 8), // Reduced spacing
                              Text(
                                propertyTypes[index]['type'],
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
                ),
                SizedBox(height: 20),
                // Continue button
                ElevatedButton(
                  onPressed: _selectedIndex != null
                      ? () {
                          // Continue action
                          Navigator.pushNamed(context, '/which_kind_of_place');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "You selected: ${propertyTypes[_selectedIndex!]['type']}",
                              ),
                            ),
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
        bottomNavigationBar: BottomNavigationButtons(
          onNext: () {
            if ( _selectedIndex != null) {
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
