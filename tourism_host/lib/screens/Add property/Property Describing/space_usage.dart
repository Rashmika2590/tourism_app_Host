import 'package:flutter/material.dart';

class SpaceDetailsPage extends StatefulWidget {
  @override
  _SpaceDetailsPageState createState() => _SpaceDetailsPageState();
}

class _SpaceDetailsPageState extends State<SpaceDetailsPage> {
  // Quantities
  int _guests = 1;
  int _bedrooms = 1;
  int _beds = 1;
  int _bathrooms = 1;

  // Update quantity function
  void _updateQuantity(String type, int change) {
    setState(() {
      if (type == 'guests') _guests = (_guests + change).clamp(1, 20);
      if (type == 'bedrooms') _bedrooms = (_bedrooms + change).clamp(1, 10);
      if (type == 'beds') _beds = (_beds + change).clamp(1, 20);
      if (type == 'bathrooms') _bathrooms = (_bathrooms + change).clamp(1, 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title section
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tell us about your place",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                  ],
                ),
                SizedBox(height: 35),
                Text(
                  "How many of your space can guests use?",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent[700]),
                ),
                SizedBox(height: 25),
                Expanded(
                  child: Column(
                    children: [
                      _buildCounterRow(
                        context,
                        icon: Icons.person,
                        label: "Guests",
                        value: _guests,
                        onIncrement: () => _updateQuantity('guests', 1),
                        onDecrement: () => _updateQuantity('guests', -1),
                      ),
                      SizedBox(height: 20),
                      _buildCounterRow(
                        context,
                        icon: Icons.room,
                        label: "Bedrooms",
                        value: _bedrooms,
                        onIncrement: () => _updateQuantity('bedrooms', 1),
                        onDecrement: () => _updateQuantity('bedrooms', -1),
                      ),
                      SizedBox(height: 20),
                      _buildCounterRow(
                        context,
                        icon: Icons.king_bed,
                        label: "Beds",
                        value: _beds,
                        onIncrement: () => _updateQuantity('beds', 1),
                        onDecrement: () => _updateQuantity('beds', -1),
                      ),
                      SizedBox(height: 20),
                      _buildCounterRow(
                        context,
                        icon: Icons.bathroom,
                        label: "Bathrooms",
                        value: _bathrooms,
                        onIncrement: () => _updateQuantity('bathrooms', 1),
                        onDecrement: () => _updateQuantity('bathrooms', -1),
                      ),
                    ],
                  ),
                ),
                // Continue button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle continue action
                      Navigator.pushNamed(context, '/select_gust_types');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Details saved!')),
                      );
                    },
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget to build a counter row
  Widget _buildCounterRow(BuildContext context,
      {required IconData icon,
      required String label,
      required int value,
      required VoidCallback onIncrement,
      required VoidCallback onDecrement}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black, size: 20),
              SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(fontSize: 15,),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: value > 1 ? onDecrement : null,
                icon: Icon(Icons.remove, color: Colors.redAccent),
              ),
              Text(
                '$value',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: onIncrement,
                icon: Icon(Icons.add, color: Colors.blueAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
