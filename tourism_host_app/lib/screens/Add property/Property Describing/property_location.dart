import 'package:flutter/material.dart';

class PropertyLocationPage extends StatefulWidget {
  @override
  _PropertyLocationPageState createState() => _PropertyLocationPageState();
}

class _PropertyLocationPageState extends State<PropertyLocationPage> {
  final TextEditingController _noController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  bool get _isFormValid {
    return _noController.text.isNotEmpty &&
        _streetController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _provinceController.text.isNotEmpty &&
        _countryController.text.isNotEmpty;
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Prevent overflow when keyboard appears
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
               Padding(
                 padding: const EdgeInsets.only(left: 20.0,top: 10,right: 20),
                 child: Column(
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
               ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                         Text(
                        "Where’s your property located?",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 20, color: Colors.blueAccent[700],fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Provide your property address below to help guests find it.",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                        ),
                        SizedBox(height: 10),
                    
                        // Address Form Wrapped in a Box
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildAddressField("No", _noController),
                              SizedBox(height: 10),
                              _buildAddressField("Street", _streetController),
                              SizedBox(height: 10),
                              _buildAddressField("City", _cityController),
                              SizedBox(height: 10),
                              _buildAddressField("Province", _provinceController),
                              SizedBox(height: 10),
                              _buildAddressField("Country", _countryController),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Point your place in Map.",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 10),
                        // Map Container
                        Container(
                          height: 300, // Reduced height for the map container
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Map will be shown here",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          
              // Continue Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: ElevatedButton(
                  onPressed: _isFormValid
                      ? () {
                        Navigator.pushNamed(context, '/add_photos');
                          _dismissKeyboard(); // Automatically dismiss keyboard
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Address: ${_noController.text}, ${_streetController.text}, ${_cityController.text}, ${_provinceController.text}, ${_countryController.text}",
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Method to Build Address Fields
  Widget _buildAddressField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10),
      ),
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        setState(() {}); // Update button state
      },
      onEditingComplete: () {
        if (_isFormValid) _dismissKeyboard();
      },
    );
  }
}
