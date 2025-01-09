import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tourism_host/Utils/shared_preferences.dart';

class PropertyCreationPage extends StatefulWidget {
  const PropertyCreationPage({super.key});

  @override
  State<PropertyCreationPage> createState() => _PropertyCreationPageState();
}

class _PropertyCreationPageState extends State<PropertyCreationPage> {
  final _formKey = GlobalKey<FormState>();
  final _propertyNameController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();

  final _secureStorage =
      const FlutterSecureStorage(); // Secure storage instance

  var token;

  @override
  initState() {
    token = SharedPreferecesUtil.getToken();
    print('$token');
    super.initState();
  }

  Future<void> createProperty(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      // Retrieve token from secure storage
      final token = await _secureStorage.read(key: 'firebase_token');
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to retrieve authentication token.')),
        );
        return;
      } else {
        print('Firebase ID Token (stored): $token');
      }

      final propertyData = {
        "propertyName": _propertyNameController.text,
        "propertyType": 0,
        "availability": 0,
        "allowShortStays": true,
        "allowLongStays": true,
        "userRole": 1,
        "numOfHours": 0,
        "guestStayType": 0,
        "address": {
          "no": "123",
          "street": _streetController.text,
          "city": _cityController.text,
          "province": "NY", // Make dynamic if needed
          "country": _countryController.text,
          "postalCode": "10001", // Make dynamic if needed
          "latitude": 40.7128, // Make dynamic if needed
          "longitude": -74.0060, // Make dynamic if needed
        },
        "propertyImage": {
          "primaryImageUrl": "https://example.com/image1.jpg", // Make dynamic
          "secondaryImageUrl1":
              "https://example.com/image2.jpg", // Make dynamic
          "secondaryImageUrl2":
              "https://example.com/image3.jpg", // Make dynamic
          "secondaryImageUrl3":
              "https://example.com/image4.jpg", // Make dynamic
          "secondaryImageUrl4":
              "https://example.com/image5.jpg", // Make dynamic
          "secondaryImageUrl5":
              "https://example.com/image6.jpg", // Make dynamic
        },
        "guestCapacities": [
          {
            "guestType": 0,
            "maxGuests": 4, // Make dynamic if needed
          }
        ],
      };

      final response = await http
          .post(
            Uri.parse(
                'http://uexplusmobileapi-env.eba-ppaf7hqh.eu-north-1.elasticbeanstalk.com/api/Property'),
            headers: {
              'Authorization':
                  'Bearer $token', // Use the token from secure storage
              'Content-Type': 'application/json',
            },
            body: jsonEncode(propertyData),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Property created successfully!')),
        );
      } else {
        final errorBody = response.body;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed with status code ${response.statusCode}: $errorBody')),
        );
        print('Error occurred: ${response.statusCode} $errorBody');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
      print('Error: $e');
    }
  }

  Future<void> sendRequestToBackend() async {
    final url = Uri.parse(
        'http://uexplusmobileapi-env.eba-ppaf7hqh.eu-north-1.elasticbeanstalk.com/api/Property/255a0acb-f2eb-4894-2bce-08dd2a528817');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      
    );

    if (response.statusCode == 200) {
      print('Request successful: ${response.body}');
    } else {
      print('Request failed: ${response.statusCode} - ${response.body}');
    }
  }


  @override
  void dispose() {
    _propertyNameController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Property')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _propertyNameController,
                decoration: const InputDecoration(labelText: 'Property Name'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter property name'
                    : null,
              ),
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(labelText: 'Street'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter street' : null,
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter city' : null,
              ),
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter country' : null,
              ),
              ElevatedButton(
                onPressed: () => sendRequestToBackend(),
                child: const Text('Create Property'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
