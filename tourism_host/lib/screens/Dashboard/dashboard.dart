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
              blurRadius: 2,
              offset: const Offset(3, 3),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dashboard title
            const Text(
              "Welcome Back!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Manage your properties and bookings easily.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
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
      Package(title: 'Basic Package', price: 100, description: 'Basic amenities included'),
      Package(title: 'Premium Package', price: 200, description: 'All amenities included'),
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
                      Navigator.pushNamed(context, '/registration');
                    },
                  ),
                  buildDashboardCard(
                    icon: Icons.calendar_today,
                    title: "Today's Bookings",
                    subtitle: "Check all received bookings",
                    color: Colors.orange,
                    onTap: () {
                      Navigator.pushNamed(context, '/today_bookings');
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
            // Notifications button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/notifications');
              },
              icon: const Icon(Icons.notifications),
              label: const Text("Notifications"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
