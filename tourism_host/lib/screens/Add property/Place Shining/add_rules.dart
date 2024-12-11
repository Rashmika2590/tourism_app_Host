import 'package:flutter/material.dart';
import 'package:tourism_host/Models/property_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RulesSelectionPage extends StatefulWidget {
  final List<String> selectedRules;

  RulesSelectionPage({Key? key, required this.selectedRules}) : super(key: key);

  @override
  _RulesSelectionPageState createState() => _RulesSelectionPageState();
}

class _RulesSelectionPageState extends State<RulesSelectionPage> {
  late List<String> _selectedRules;

  @override
  void initState() {
    super.initState();
    _selectedRules = widget.selectedRules;
  }

  void _toggleRule(String rule) {
    setState(() {
      if (_selectedRules.contains(rule)) {
        _selectedRules.remove(rule);
      } else {
        _selectedRules.add(rule);
      }
    });
  }

  Future<void> saveSelectedRulesToDatabase(List<String> selectedRules) async {
    try {
      // Replace with your backend API endpoint
      const String apiUrl = "https://your-api-endpoint.com/saveRules";

      // Prepare the request payload
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'rules': selectedRules,
        }),
      );

      if (response.statusCode == 200) {
        // Successfully saved to the database
        print("Rules saved successfully: ${response.body}");
      } else {
        // Handle errors
        print("Failed to save rules: ${response.body}");
      }
    } catch (e) {
      print("Error saving rules: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Make your place shine",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 20),
            Text(
              "Add your Rules & Regulations",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent[700],
              ),
            ),
            Expanded(
              child: ListView(
                children: Property.predefinedRules.map((rule) {
                  final isSelected = _selectedRules.contains(rule);
                  return GestureDetector(
                    onTap: () => _toggleRule(rule),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade50 : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? Colors.blue
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.blue.shade100,
                                  blurRadius: 4.0,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            rule,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected ? Colors.blue : Colors.black,
                            ),
                          ),
                          Checkbox(
                            value: isSelected,
                            onChanged: (value) => _toggleRule(rule),
                            activeColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/package_creation');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Details submitted!")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:Colors.blueAccent,
              padding: EdgeInsets.symmetric(vertical: 15),
              textStyle: TextStyle(fontSize: 16, color: Colors.white),
              minimumSize: Size(double.infinity, 50),
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
      ),
    );
  }
}
