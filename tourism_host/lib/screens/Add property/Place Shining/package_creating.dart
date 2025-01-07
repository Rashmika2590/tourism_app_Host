import 'package:flutter/material.dart';
import 'package:tourism_host/Reusables/widgets/bottom_nav_buttons.dart';

class SpecialPackagesPage extends StatefulWidget {
  @override
  _SpecialPackagesPageState createState() => _SpecialPackagesPageState();
}

class _SpecialPackagesPageState extends State<SpecialPackagesPage> {
  final TextEditingController _packageNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _scheduleController = TextEditingController();
  final TextEditingController _featuresController = TextEditingController();

  bool _isFormVisible = false;
  bool _isLearnMoreVisible = false;

  // Handle toggle for "Learn More"
  void _toggleLearnMore() {
    setState(() {
      _isLearnMoreVisible = !_isLearnMoreVisible;
    });
  }

  @override
  void dispose() {
    _packageNameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _scheduleController.dispose();
    _featuresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              // Title and overview
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25),
                    Text(
                      "Make your place shine",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    SizedBox(height: 15),
                    Text(
                      "Introduce special packages from your place",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent[700],
                      ),
                    ),
                  ],
                ),
              ),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Customize and create special packages for your guests here. "
                          "Fill in the details like package name, price, description, and special features.",
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        // Learn More Button
                        TextButton(
                          onPressed: _toggleLearnMore,
                          child: Text(
                            _isLearnMoreVisible ? "Show Less" : "Learn More",
                            style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                          ),
                        ),
                        // Learn More details (visible when clicked)
                        if (_isLearnMoreVisible)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Here, you can create customized special packages that will be "
                              "available to your guests. Start by filling in basic details such as the "
                              "package name, price, and description. You can also add a schedule, and "
                              "special features to make your package stand out. Once created, the package "
                              "will be available for your guests to view and book.",
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),
                          ),
                        SizedBox(height: 15),
                        // Add Package Button
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _isFormVisible = !_isFormVisible;
                            });
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Create New Package",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        // Package creation form (visible only when Add button is clicked)
                        Visibility(
                          visible: _isFormVisible,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInputField(
                                controller: _packageNameController,
                                label: "Package Name",
                                hint: "Package name",
                              ),
                              SizedBox(height: 15),
                              _buildInputField(
                                controller: _priceController,
                                label: "Package Price",
                                hint: "Package price",
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 15),
                              _buildInputField(
                                controller: _descriptionController,
                                label: "Description",
                                hint: "Package description",
                                maxLines: 4,
                              ),
                              SizedBox(height: 15),
                              _buildInputField(
                                controller: _scheduleController,
                                label: "Schedule",
                                hint: "Package schedule",
                              ),
                              SizedBox(height: 15),
                              _buildInputField(
                                controller: _featuresController,
                                label: "Special Features",
                                hint: "Special features",
                                maxLines: 3,
                              ),
                              SizedBox(height: 25),
                              // Done Button to save package details
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle done action (save package details)
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Package saved successfully!')),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    textStyle: TextStyle(fontSize: 16, color: Colors.white),
                                    minimumSize: Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Save',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              // Continue Button
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle continue action
                                    Navigator.pushNamed(context, '/host_details');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Package process continues!')),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Fixed Continue Button (only when form is not visible)
              if (!_isFormVisible)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle continue action
                      Navigator.pushNamed(context, '/host_details');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Package process continues!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
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
            ],
          ),
        ),
       bottomNavigationBar: BottomNavigationButtons(
          onNext: () {
              Navigator.pushNamed(context, '/which_kind_of_place');
          },
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Colors.blueAccent, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: const Color.fromARGB(255, 207, 206, 206)),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            "${controller.text.length}/${maxLines == 1 ? 50 : 500}",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
