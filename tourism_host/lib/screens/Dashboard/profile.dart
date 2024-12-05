import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String firstName = 'John';
  final String lastName = 'Doe';
  final String email = 'johndoe@example.com';
  final String phone = '+1 123-456-7890';
  String _profileImage = 'assets/default_profile.jpg';
  bool _isEditing = false;
  bool _isPropertyListVisible = false;
  List<String> properties = [];

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with existing values
    _firstNameController.text = firstName;
    _lastNameController.text = lastName;
    _emailController.text = email;
    _phoneController.text = phone;
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = image.path;
      });
    }
  }

  void _viewPropertyList() {
    // Simulate a list of property names
    setState(() {
      properties = [
        'Property 1',
        'Property 2',
        'Property 3',
        'Property 4',
        'Property 5',
      ];
      _isPropertyListVisible = true;
    });
  }

  void _togglePropertyListVisibility() {
    setState(() {
      _isPropertyListVisible = !_isPropertyListVisible;
    });
  }

  void _openSettings(BuildContext context) {
    // Navigate to settings page (not implemented in this example)
    print('Navigating to settings...');
  }

  void _signOut(BuildContext context) {
    // Perform sign-out logic (not implemented in this example)
    print('Signing out...');
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile title and divider
                SizedBox(height: screenHeight * 0.035),
                const Text(
                  "Profile",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Divider(),
                SizedBox(height: screenHeight * 0.055),
        
                // Profile Image (top center)
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(_profileImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
        
                // Name, Email, Phone, Edit Icon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_firstNameController.text} ${_lastNameController.text}',
                            style: TextStyle(
                              fontSize: screenHeight * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _emailController.text,
                            style: TextStyle(fontSize: screenHeight * 0.02),
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            _phoneController.text,
                            style: TextStyle(fontSize: screenHeight * 0.02),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: _pickImage,
                        child: IconButton(
                          icon: Icon(
                            _isEditing ? Icons.check : Icons.edit,
                            color: Colors.blueAccent,
                          ),
                          onPressed: _toggleEdit,
                        ),
                      ),
                    ],
                  ),
                ),
        
                const SizedBox(height: 24.0),
        
                // Editable Profile Fields
                if (_isEditing) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(labelText: 'First Name'),
                        ),
                        TextField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(labelText: 'Last Name'),
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                          controller: _phoneController,
                          decoration: const InputDecoration(labelText: 'Phone Number'),
                        ),
                        const SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                ],
        
                // My Properties Button
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.blueAccent),
                  title: const Text('My Properties'),
                  onTap: _viewPropertyList,
                ),
                const SizedBox(height: 16.0),
        
                // Display Property List if available
                if (_isPropertyListVisible)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var property in properties)
                              ListTile(
                                title: Text(property),
                              ),
                          ],
                        ),
                      ),
                      // Hide Property List Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.arrow_upward, color: Colors.blueAccent),
                          onPressed: _togglePropertyListVisibility,
                        ),
                      ),
                    ],
                  ),
        
                // Settings Option
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.blueAccent),
                  title: const Text('Settings'),
                  onTap: () => _openSettings(context),
                ),
                const SizedBox(height: 16.0),
        
                // Sign Out Button at the bottom of the screen
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () => _signOut(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
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
}
