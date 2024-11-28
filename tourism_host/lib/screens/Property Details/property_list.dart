import 'package:flutter/material.dart';
import 'package:tourism_host/screens/Property%20Details/property_details.dart';


class PropertyList extends StatefulWidget {
  const PropertyList({super.key, required this.property});
  final PropertyModel property;

  @override
  _PropertyListState createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  final Map<String, List<Map<String, dynamic>>> categorizedProperties = {
    "Villas": [
      {"name": "Ocean View Villa", "bookingsComplete": false, "enabled": true},
      {"name": "Mountain Retreat Villa", "bookingsComplete": true, "enabled": false},
    ],
    "Hotels": [
      {"name": "Luxury Grand Hotel", "bookingsComplete": false, "enabled": true},
      {"name": "Cozy Budget Hotel", "bookingsComplete": false, "enabled": true},
    ],
    "Guesthouses": [
      {"name": "City Center Guesthouse", "bookingsComplete": true, "enabled": false},
      {"name": "Quiet Suburban Guesthouse", "bookingsComplete": false, "enabled": true},
    ],
  };

  void toggleBookingStatus(String category, int index, bool value) {
    setState(() {
      categorizedProperties[category]![index]["enabled"] = value;
    });
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
            // Large and small text at the top
            const SizedBox(height: 20),
            const Text(
              "Jhon's Properties",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Enable or disable bookings for your properties.",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            // Property categories and lists
            Expanded(
              child: ListView.builder(
                itemCount: categorizedProperties.keys.length,
                itemBuilder: (context, categoryIndex) {
                  final category = categorizedProperties.keys.elementAt(categoryIndex);
                  final properties = categorizedProperties[category]!;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Title
                        Text(
                          category,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // List of Properties
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: properties.length,
                          itemBuilder: (context, index) {
                            final property = properties[index];
                            final isDisabledByUser = !property["enabled"] && !property["bookingsComplete"];

                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              child: ListTile(
                                title: Text(
                                  property["name"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: property["bookingsComplete"] || isDisabledByUser
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  property["bookingsComplete"]
                                      ? "All bookings complete"
                                      : isDisabledByUser
                                          ? "Disabled by user"
                                          : "Available for bookings",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: property["bookingsComplete"]
                                        ? Colors.grey
                                        : isDisabledByUser
                                            ? Colors.red
                                            : Colors.green,
                                  ),
                                ),
                                trailing: Transform.scale(
                                  scale: 0.8, // Reduce switch size
                                  child: Switch(
                                    value: property["enabled"],
                                    onChanged: property["bookingsComplete"]
                                        ? null
                                        : (value) {
                                            toggleBookingStatus(category, index, value);
                                          },
                                    activeColor: Colors.blueAccent,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditPropertyPage(property:widget.property,),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

