import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourism_host/Reusables/widgets/bottom_nav_buttons.dart';

class HostDetailsPage extends StatefulWidget {
  @override
  _HostDetailsPageState createState() => _HostDetailsPageState();
}

class _HostDetailsPageState extends State<HostDetailsPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selfie;
  XFile? _nicOrPassport;
  bool isVerified = false;
  bool isVerifying = false;

  Future<void> captureSelfie() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selfie = pickedFile;
      });
    }
  }

  Future<void> pickDocument() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _nicOrPassport = pickedFile;
      });
    }
  }

  bool get isVerifyEnabled => _selfie != null && _nicOrPassport != null;
  bool get isNextEnabled => isVerified;

  Future<void> startVerification() async {
    setState(() {
      isVerifying = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isVerifying = false;
      isVerified = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Verification",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Divider(),
                SizedBox(height: 25),
                Text(
                  "Upload owner details",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent[700]),
                ),
                SizedBox(height: 20),
                // Selfie Upload
                Text(
                  'Take your selfie',
                  style: TextStyle(fontSize: 16),
                ),
                Center(
                  child: GestureDetector(
                    onTap: captureSelfie,
                    child: CircleAvatar(
                      radius: 100, // Increased radius for a larger circle
                      backgroundColor: Colors.grey[300],
                      child: _selfie == null
                          ? Icon(
                              Icons.camera_alt,
                              size: 60, // Adjust icon size proportionally
                              color: Colors.grey[700],
                            )
                          : ClipOval(
                              child: Image.file(
                                File(_selfie!.path),
                                fit: BoxFit.cover,
                                width: 200, // Match the diameter of the circle
                                height: 200, // Match the diameter of the circle
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // NIC/Passport Upload
                Text(
                  'Upload NIC or Passport:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: pickDocument,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: _nicOrPassport == null
                        ? Center(
                            child: Icon(
                              Icons.upload_file,
                              size: 30,
                              color: Colors.grey,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.file_present, color: Colors.blueAccent),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _nicOrPassport!.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: isVerifyEnabled && !isVerifying && !isVerified
                        ? startVerification
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      backgroundColor: isVerified
                          ? Colors.green // Verified state color
                          : Colors.blueAccent, // Default state color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      disabledBackgroundColor: isVerified
                          ? Colors.green // Ensure green color remains for disabled verified button
                          : Colors.grey[400], // Default disabled color
                    ),
                    child: isVerifying
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            isVerified ? "Verified" : "Verify",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                Spacer(), // Pushes the "Next" button to the bottom
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isNextEnabled
                        ? () {
                            Navigator.pushNamed(context, '/Property_verification');
                          }
                        : null,
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.blueAccent,
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
            if (isNextEnabled) {
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