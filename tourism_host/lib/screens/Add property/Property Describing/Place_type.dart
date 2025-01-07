import 'package:flutter/material.dart';
import 'package:tourism_host/Reusables/widgets/bottom_nav_buttons.dart';

class PropertyGuestTypeSelectionPage extends StatefulWidget {
  @override
  _PropertyGuestTypeSelectionPageState createState() =>
      _PropertyGuestTypeSelectionPageState();
}

class _PropertyGuestTypeSelectionPageState
    extends State<PropertyGuestTypeSelectionPage> {
  // List of place types with suitable icons
  final List<Map<String, dynamic>> guestTypes = [
    {'type': 'Entire Place', 'icon': Icons.house},
    {'type': 'Room', 'icon': Icons.room},
    {'type': 'Private Room', 'icon': Icons.lock},
    {'type': 'Shared Room', 'icon': Icons.people},
  ];

  // List to keep track of selected options
  List<int> _selectedIndices = [];

  // Method to handle selection and deselection
  void _onCardTap(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
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
                // Large and small text at the top
                SizedBox(height: 30),
                Text(
                  "Tell us about your place",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Divider(),
                SizedBox(height: 25),
                Text(
                  "How will guests stay?",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, color: Colors.blueAccent[700],fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                
                // Cards for selectable options
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: guestTypes.length,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedIndices.contains(index);
                      return GestureDetector(
                        onTap: () => _onCardTap(index),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          color: isSelected ? Colors.lightBlue[100] : Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                guestTypes[index]['icon'],
                                size: 40,
                                color: isSelected ? Colors.black : Colors.grey,
                              ),
                              SizedBox(height: 10),
                              Text(
                                guestTypes[index]['type'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.black : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
          
                // Continue button
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _selectedIndices.isNotEmpty
                      ? () {
                          Navigator.pushNamed(context, '/space_usage');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "You selected: ${_selectedIndices.map((index) => guestTypes[index]['type']).join(', ')}",
                              ),
                            ),
                          );
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
            if ( _selectedIndices.isNotEmpty) {
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
