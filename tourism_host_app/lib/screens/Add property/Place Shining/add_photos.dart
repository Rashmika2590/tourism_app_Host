import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotosPage extends StatefulWidget {
  @override
  _UploadPhotosPageState createState() => _UploadPhotosPageState();
}

class _UploadPhotosPageState extends State<UploadPhotosPage> {
  final List<XFile> _photos = [];
  final ImagePicker _picker = ImagePicker();

  bool get _canComplete => _photos.length >= 1;

  Future<void> _pickImage(bool fromCamera) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      );
      if (image != null && _photos.length < 20) {
        setState(() {
          _photos.add(image);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Large title at the top
              SizedBox(height: 30),
               Padding(
                 padding: const EdgeInsets.only(left: 20.0,top: 10,right: 20),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                      "Make your place Shine",
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Instruction text
                        SizedBox(height: 10),
                        Text(
                        "Add images and Showcase Your Space",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.blueAccent[700]),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _photos.length >= 5
                              ? "You can add more photos of your place."
                              : "5 photos are required to proceed.",
                          style: TextStyle(
                            fontSize: 14,
                            color: _photos.length >= 5 ? Colors.green : Colors.redAccent,
                          ),
                        ),
                        SizedBox(height: 20),
          
                        // Grid view for showing uploaded photos
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: _photos.length + 1, // Add one for "Add photo" button
                          itemBuilder: (context, index) {
                            if (index == _photos.length && _photos.length < 20) {
                              return GestureDetector(
                                onTap: () => _showPhotoOptions(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.add_a_photo, size: 40, color: Colors.grey[700]),
                                ),
                              );
                            } else if (index < _photos.length) {
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(_photos[index].path),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _photos.removeAt(index);
                                        });
                                      },
                                      child: Icon(
                                        Icons.remove_circle,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                        SizedBox(height: 20),
                        // Photo options
                        // Text(
                        //   "Options:",
                        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        // ),
                        // SizedBox(height: 10),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     ElevatedButton.icon(
                        //       onPressed: () => _pickImage(false),
                        //       icon: Icon(Icons.photo_library),
                        //       label: Text("Choose from Library"),
                        //     ),
                        //     ElevatedButton.icon(
                        //       onPressed: () => _pickImage(true),
                        //       icon: Icon(Icons.camera_alt),
                        //       label: Text("Take Photo"),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              // Complete button at the bottom
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: _canComplete
                      ? () {
                          // Handle completion
                          Navigator.pushNamed(context, '/add_amenities');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Photos uploaded successfully!')),
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
                    'Complete',
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

  // Show photo options dialog
  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Choose from Library"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(false);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Take Photo"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
