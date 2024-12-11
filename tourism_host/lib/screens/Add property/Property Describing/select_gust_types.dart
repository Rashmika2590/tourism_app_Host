import 'package:flutter/material.dart';
import 'package:tourism_host/Models/property_model.dart';
import 'package:tourism_host/Reusables/widgets/bottom_nav_buttons.dart';

class SelectGuestTypesPage extends StatefulWidget {
  @override
  _SelectGuestTypesPageState createState() => _SelectGuestTypesPageState();
}

class _SelectGuestTypesPageState extends State<SelectGuestTypesPage> {
  List<String> _selectedGuestTypes = []; // Holds the selected guest types

  // Fetching guest types from the Property model
  final List<String> _guestTypes = Property.predefinedGuestTypes; // Using the guest types from Property model

  // Function to toggle selection of guest types
  void _toggleSelection(String guestType) {
    setState(() {
      if (_selectedGuestTypes.contains(guestType)) {
        _selectedGuestTypes.remove(guestType);
      } else {
        _selectedGuestTypes.add(guestType);
      }
    });
  }

  // Continue button is enabled when at least one guest type is selected
  bool _isContinueEnabled() {
    return _selectedGuestTypes.isNotEmpty;
  }

  // Save selected guest types to the database
  void _saveGuestTypesToDatabase() {
    // Save _selectedGuestTypes to your database here
    // For example:
    // FirebaseFirestore.instance.collection('properties').doc(propertyId).update({
    //   'guestTypes': _selectedGuestTypes,
    // });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected Guest Types: $_selectedGuestTypes')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Heading and Divider
              SizedBox(height: 35),
              const Text(
                "Select the Guest Types",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Divider(),
              SizedBox(height: 20),
              Text(
                "Choose the types of guests who will stay at your property",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent[700],
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),

              // Guest type selection grid
              Expanded(
                child: GridView.builder(
                  itemCount: _guestTypes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Show 3 guest types per row
                    crossAxisSpacing: 15, // Horizontal space between cards
                    mainAxisSpacing: 15, // Vertical space between cards
                  ),
                  itemBuilder: (context, index) {
                    String guestType = _guestTypes[index];
                    bool isSelected = _selectedGuestTypes.contains(guestType);

                    return GestureDetector(
                      onTap: () => _toggleSelection(guestType),
                      child: Card(
                        color:
                            isSelected ? Colors.lightBlue[100] : Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons
                                  .people, // You can replace this with different icons based on guest type
                              size: 30,
                              color: isSelected ? Colors.black : Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text(
                              guestType,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.black : Colors.grey,
                              ),
                              textAlign: TextAlign.center,
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
                onPressed: _isContinueEnabled()
                    ? () {
                        _saveGuestTypesToDatabase();
                        Navigator.pushNamed(context,
                            '/property_location'); // Navigate to the next page
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 16, color: Colors.white),
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationButtons(
        onNext: () {
          // Check if any guest type is selected
          if (_isContinueEnabled()) {
            // Proceed to next page if guest types are selected
            _saveGuestTypesToDatabase();
            Navigator.pushNamed(context, '/property_location');
          } else {
            // Show alert dialog if no guest types are selected
            _showAlertDialog(context);
          }
        },
      ),
    );
  }

  // Show alert dialog when no guest types are selected
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
