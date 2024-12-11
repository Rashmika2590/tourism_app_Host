import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

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

  late GoogleMapController _mapController;
  LatLng _mapCenter = LatLng(0, 0); // Initial position
  Set<Marker> _markers = {}; // Set of markers to display
// Static pointer on map

  bool get _isFormValid {
    return _noController.text.isNotEmpty &&
        _streetController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _provinceController.text.isNotEmpty &&
        _countryController.text.isNotEmpty;
  }

  Future<void> _searchLocation() async {
    String fullAddress =
        "${_noController.text}, ${_streetController.text}, ${_cityController.text}, ${_provinceController.text}, ${_countryController.text}";

    try {
      List<Location> locations = await locationFromAddress(fullAddress);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng latLng = LatLng(location.latitude, location.longitude);

        setState(() {
          _mapCenter = latLng;
        });

        // Move the map camera to the new position
        _mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to find location: $e")),
      );
    }
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tell us about your place",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    SizedBox(height: 10),
                    Text(
                      "Where’s your property located?",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueAccent[700],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Provide your property address below to help guests find it.",
                      style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                    ),
                    SizedBox(height: 10),
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
                        // Address Form
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
                              _buildAddressField(
                                  "Province", _provinceController),
                              SizedBox(height: 10),
                              _buildAddressField("Country", _countryController),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: ElevatedButton(
                                  onPressed: _isFormValid ? _searchLocation : null,
                                  child: Text('OK'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Point your place in Map.",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              GoogleMap(
                                onMapCreated: (controller) =>
                                    _mapController = controller,
                                initialCameraPosition: CameraPosition(
                                  target: _mapCenter,
                                  zoom: 15,
                                ),
                                onCameraMove: (position) {
                                  setState(() {
                                    _mapCenter = position.target;
                                  });
                                },
                                markers: _markers,
                                onTap: (LatLng tappedLatLng) {
                                  // Navigate to full screen map on tap
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenMapPage(
                                        initialLocation: tappedLatLng,
                                        onLocationSelected: (selectedLocation) {
                                          setState(() {
                                            _mapCenter = selectedLocation;
                                          });
                                          _mapController.animateCamera(
                                            CameraUpdate.newLatLngZoom(
                                                selectedLocation, 15),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Center(
                                child: Icon(
                                  Icons.location_on,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        // ElevatedButton(
                        //   onPressed: _confirmLocation,
                        //   child: Text('Confirm Location'),
                        // ),
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

  Widget _buildAddressField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      onChanged: (value) => setState(() {}),
    );
  }
}

class FullScreenMapPage extends StatefulWidget {
  final LatLng initialLocation;
  final ValueChanged<LatLng> onLocationSelected;

  FullScreenMapPage({required this.initialLocation, required this.onLocationSelected});

  @override
  _FullScreenMapPageState createState() => _FullScreenMapPageState();
}

class _FullScreenMapPageState extends State<FullScreenMapPage> {
  // ignore: unused_field
  late GoogleMapController _mapController;
  late LatLng _selectedLocation;
  Set<Marker> _markers = {}; // Set of markers to display

  @override
  void initState() {
    super.initState();
    // Set the initial location and create the marker for it
    _selectedLocation = widget.initialLocation;
    _markers.add(
      Marker(
        markerId: MarkerId('selectedLocation'),
        position: _selectedLocation,
        infoWindow: InfoWindow(title: 'Selected Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  // Function to handle user tap and update the pointer
  void _onMapTapped(LatLng tappedLatLng) {
    setState(() {
      _selectedLocation = tappedLatLng;
      // Update the markers to show the new selected location
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('selectedLocation'),
          position: _selectedLocation,
          infoWindow: InfoWindow(title: 'Selected Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80, // Adjust the height of the AppBar to add more space
        title: Text(
          'Set Your Location',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0), // Add some spacing
            child: SizedBox(
              width: 40, // Set the width of the circle
              height: 35, // Set the height of the circle
              child: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: IconButton(
                  icon: Icon(Icons.check, color: Colors.white, size: 20), // Adjust icon size
                  onPressed: () {
                    // Show the SnackBar with the selected location's latitude and longitude
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Location confirmed: ${_selectedLocation.latitude}, ${_selectedLocation.longitude}',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    // Pass the selected location back to the PropertyLocationPage
                    widget.onLocationSelected(_selectedLocation);

                    // Close the full-screen map
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: (controller) => _mapController = controller,
        initialCameraPosition: CameraPosition(
          target: _selectedLocation,
          zoom: 15,
        ),
        markers: _markers,
        onCameraMove: (position) {
          // Optionally update the pointer position while the camera moves
          setState(() {
            _selectedLocation = position.target;
          });
        },
        onTap: _onMapTapped, // Handle map taps to update the pointer
      ),
    );
  }
}

