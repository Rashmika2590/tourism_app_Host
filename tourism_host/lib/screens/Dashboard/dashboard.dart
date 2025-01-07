import 'package:flutter/material.dart';
import 'package:tourism_host/screens/Property%20Details/property_details.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  Widget buildDashboardCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color color = Colors.blue,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: const Offset(4, 4), // Shift the shadow to bottom-right
              spreadRadius: 2, // Optional: control shadow spread
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, // 5% of screen width for padding
            vertical: screenHeight * 0.04,  // 4% of screen height for padding
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Dashboard title
              SizedBox(height: screenHeight * 0.05), // 5% of screen height for spacing
              const Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Manage your properties and bookings easily.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Divider(),
              const SizedBox(height: 20),
              // Grid of options
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    buildDashboardCard(
                      icon: Icons.home,
                      title: "Property Details",
                      subtitle: "View and manage properties",
                      color: Colors.green,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/property_list',
                          arguments: PropertyModel(
                            photos: ['path/to/photo1.jpg', 'path/to/photo2.jpg'],
                            amenities: ['WiFi', 'Parking', 'Pool'],
                            packages: [
                              Package(
                                title: 'Basic Package',
                                price: 100,
                                description: 'Basic amenities included',
                              ),
                              Package(
                                title: 'Premium Package',
                                price: 200,
                                description: 'All amenities included',
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    buildDashboardCard(
                      icon: Icons.add_box,
                      title: "Add New Property",
                      subtitle: "List a new property",
                      color: Colors.blue,
                      onTap: () {
                        Navigator.pushNamed(context, '/progress_page');
                      },
                    ),
                    buildDashboardCard(
                      icon: Icons.calendar_today,
                      title: "Today's Bookings",
                      subtitle: "Check all received bookings",
                      color: Colors.orange,
                      onTap: () {
                        Navigator.pushNamed(context, '/today_booking');
                      },
                    ),
                    buildDashboardCard(
                      icon: Icons.person,
                      title: "Profile",
                      subtitle: "View and edit your profile",
                      color: Colors.purple,
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/Property_creation_test');
                }, 
                child: Text('property creation test')
                ),
              // Notifications button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
                icon: const Icon(Icons.notifications,color: Colors.white,),
                label: const Text("Notifications",style: TextStyle(color: Colors.white) ,),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02, // 2% of screen height for padding
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
