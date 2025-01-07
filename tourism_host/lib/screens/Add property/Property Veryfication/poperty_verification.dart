import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:tourism_host/Reusables/widgets/bottom_nav_buttons.dart';

class PropertyVerificationPage extends StatefulWidget {
  @override
  _PropertyVerificationPageState createState() => _PropertyVerificationPageState();
}

class _PropertyVerificationPageState extends State<PropertyVerificationPage> {
  final ImagePicker _picker = ImagePicker();
  String? _propertyType;
  String? _companyName;
  String? _country;
  String? _taxRegNo;
  XFile? _brOrSltdaCertificate;
  XFile? _ownershipProof;

  bool get isNextEnabled => (_propertyType == 'company' && _companyName != null && _country != null && _taxRegNo != null && _brOrSltdaCertificate != null) ||
                            (_propertyType == 'personal' && _ownershipProof != null);

  Future<void> _pickVerificationDocument() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
      });
    }
  }

  Future<void> _pickCompanyCertificate() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _brOrSltdaCertificate = pickedFile;
      });
    }
  }

  Future<void> _pickOwnershipProof() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _ownershipProof = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step Heading
                SizedBox(height: 20),
                Text(
                  "Verification",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Divider(),
                SizedBox(height: 20),
              Text(
                "Verify your property",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent[700]),
              ),
              SizedBox(height: 20),
                // Property Type Selection (Company or Personal)
                Text(
                  "Is your property for a company or personal use?",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _propertyType = 'company';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _propertyType == 'company' ? Colors.blueAccent : Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Center(
                            child: Text(
                              "Company",
                              style: TextStyle(
                                color: _propertyType == 'company' ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _propertyType = 'personal';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _propertyType == 'personal' ? Colors.blueAccent : Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Center(
                            child: Text(
                              "Personal",
                              style: TextStyle(
                                color: _propertyType == 'personal' ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
          
                // Company Fields
                if (_propertyType == 'company') ...[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Company Name",
                              hintText: "Enter your company name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.blueAccent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.blueAccent),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _companyName = value;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Country",
                              hintText: "Enter the country of the company",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.blueAccent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.blueAccent),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _country = value;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Tax Registration Number",
                              hintText: "Enter the tax registration number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.blueAccent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.blueAccent),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _taxRegNo = value;
                              });
                            },
                          ),
                          SizedBox(height: 35),
                          Text(
                            "Upload BR or SLTDA Certificate",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: _pickCompanyCertificate,
                            child: Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: _brOrSltdaCertificate == null
                                  ? Center(child: Icon(Icons.upload_file, size: 30, color: Colors.grey))
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.file_present, color: Colors.blueAccent),
                                          SizedBox(width: 10),
                                          Expanded(child: Text(_brOrSltdaCertificate!.name, overflow: TextOverflow.ellipsis)),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] 
          
                // Personal Property Fields
                else if (_propertyType == 'personal') ...[
                  SizedBox(height: 10),
                  Text(
                    "Upload Ownership Proof (e.g. Utility Bill, Land Deed)",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: _pickOwnershipProof,
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: _ownershipProof == null
                          ? Center(child: Icon(Icons.upload_file, size: 30, color: Colors.grey))
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.file_present, color: Colors.blueAccent),
                                  SizedBox(width: 10),
                                  Expanded(child: Text(_ownershipProof!.name, overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
                Spacer(),
                SizedBox(
                  width:double.infinity,
                  child: ElevatedButton(
                    onPressed: isNextEnabled
                        ? () {
                            // Show the green snackbar with success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,  // You can keep the static icon here if you want
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Your property is added!",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                backgroundColor: Colors.green, // Green background for success
                                duration: Duration(seconds: 2),
                              ),
                            );
                        
                            // Show the alert dialog with the animated icon
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.all(0), // Remove default padding
                                  content: Container(
                                    height: 220,  // Set fixed height for the AlertDialog
                                    width: double.maxFinite,  // Make it take full width
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,  // Center the content vertically
                                      mainAxisSize: MainAxisSize.min,  // Let the column take only the needed space
                                      children: [
                                        Lottie.asset(
                                          'assets/animations/Animation - 1732271712282.json',  // Make sure to add this animation file in assets
                                          width: 200,  // Larger size for the icon
                                          height: 200,  // Larger size for the icon
                                          fit: BoxFit.cover,
                                        ), // Space between icon and text
                                        Text(
                                          "Your property is added!",
                                          style: TextStyle(
                                            fontSize: 14,  // Adjust the text size for better alignment with the icon
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                      Navigator.pushNamed(context, '/login');  // Close the dialog
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        : null,
                        
                    child: Text('FINISH',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: isNextEnabled ? Colors.blueAccent : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
       bottomNavigationBar: BottomNavigationButtons(
          onNext: () {
            if ( isNextEnabled) {
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
