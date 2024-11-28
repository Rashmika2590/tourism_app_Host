import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPropertyPage extends StatefulWidget {
  final PropertyModel property;

  EditPropertyPage({required this.property});

  @override
  _EditPropertyPageState createState() => _EditPropertyPageState();
}

class _EditPropertyPageState extends State<EditPropertyPage> {
  late List<String> photos;
  late List<String> amenities;
  late List<Package> packages;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    photos = List.from(widget.property.photos);
    amenities = List.from(widget.property.amenities);
    packages = List.from(widget.property.packages);
  }

  void _addPhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        photos.add(pickedFile.path);
      });
    }
  }

  void _removePhoto(int index) {
    setState(() {
      photos.removeAt(index);
    });
  }

  void _addAmenity(String amenity) {
    setState(() {
      amenities.add(amenity);
    });
  }

  void _removeAmenity(String amenity) {
    setState(() {
      amenities.remove(amenity);
    });
  }

  void _addPackage() {
    setState(() {
      packages.add(Package(title: '', price: 0, description: ''));
    });
  }

  void _removePackage(int index) {
    setState(() {
      packages.removeAt(index);
    });
  }

  void _saveChanges() {
    // Save updated details to the database or backend
    widget.property.photos = photos;
    widget.property.amenities = amenities;
    widget.property.packages = packages;
    Navigator.pop(context);
  }

  void _cancelChanges() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: _cancelChanges,
                  ),
                  Text(
                    "Edit Property",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: _saveChanges,
                    child: Text("Save"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text("Photos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...photos.map((photo) {
                      int index = photos.indexOf(photo);
                      return Stack(
                        children: [
                          Image.file(
                            File(photo),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () => _removePhoto(index),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: _addPhoto,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text("Amenities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8.0,
                children: amenities.map((amenity) {
                  return Chip(
                    label: Text(amenity),
                    onDeleted: () => _removeAmenity(amenity),
                  );
                }).toList(),
              ),
              TextField(
                onSubmitted: (value) {
                  if (value.isNotEmpty) _addAmenity(value);
                },
                decoration: InputDecoration(
                  labelText: "Add Amenity",
                  suffixIcon: Icon(Icons.add),
                ),
              ),
              SizedBox(height: 20),
              Text("Packages", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: packages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: TextField(
                        controller: TextEditingController(text: packages[index].title),
                        onChanged: (value) {
                          packages[index].title = value;
                        },
                        decoration: InputDecoration(labelText: "Package Title"),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: TextEditingController(text: packages[index].price.toString()),
                            onChanged: (value) {
                              packages[index].price = double.tryParse(value) ?? 0;
                            },
                            decoration: InputDecoration(labelText: "Price"),
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            controller: TextEditingController(text: packages[index].description),
                            onChanged: (value) {
                              packages[index].description = value;
                            },
                            decoration: InputDecoration(labelText: "Description"),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removePackage(index),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addPackage,
                child: Text("Add Package"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PropertyModel {
  List<String> photos;
  List<String> amenities;
  List<Package> packages;

  PropertyModel({required this.photos, required this.amenities, required this.packages});
}

class Package {
  String title;
  double price;
  String description;

  Package({required this.title, required this.price, required this.description});
}
