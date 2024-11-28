import 'package:flutter/material.dart';

class DescribePlacePage extends StatefulWidget {
  @override
  _DescribePlacePageState createState() => _DescribePlacePageState();
}

class _DescribePlacePageState extends State<DescribePlacePage> {
  final TextEditingController _propertyNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _propertyNameController.addListener(_validateInput);
    _descriptionController.addListener(_validateInput);
  }

  @override
  void dispose() {
    _propertyNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      _isButtonEnabled = _propertyNameController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title section
                          SizedBox(height: 20),
                          Text(
                            "Make your place shine",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          SizedBox(height: 20),
                          // Property name field
                          Text(
                          "Describe your place",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.blueAccent[700]),
                          ),
                          SizedBox(height: 20),
                          _buildInputField(
                            controller: _propertyNameController,
                            label: "Property Name",
                            hint: "Enter the name of your property",
                            maxLength: 50,
                            backgroundColor: Colors.grey[100]!,
                          ),
                          SizedBox(height: 20),
                          // Description field
                          _buildInputField(
                            controller: _descriptionController,
                            label: "Description",
                            hint: "Describe your property in detail",
                            maxLength: 500,
                            backgroundColor: Colors.grey[100]!,
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Continue button at the bottom
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled
                          ? () {
                            Navigator.pushNamed(context, '/package_creation');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Details submitted!")),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isButtonEnabled ? Colors.blueAccent : Colors.grey,
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required int maxLength,
    required Color backgroundColor,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16,),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            maxLength: maxLength,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,hintStyle: TextStyle(color: Colors.grey[500]),
              counterText: "",
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 5),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            "${controller.text.length}/$maxLength",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
