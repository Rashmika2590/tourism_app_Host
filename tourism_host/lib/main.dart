
import 'package:flutter/material.dart';
import 'package:tourism_host/screens/Add%20property/Place%20Shining/add_amenities.dart';
import 'package:tourism_host/screens/Add%20property/Place%20Shining/add_photos.dart';
import 'package:tourism_host/screens/Add%20property/Place%20Shining/name_description.dart';
import 'package:tourism_host/screens/Add%20property/Place%20Shining/package_creating.dart';
import 'package:tourism_host/screens/Add%20property/Property%20Describing/Place_type.dart';
import 'package:tourism_host/screens/Add%20property/Property%20Describing/Property_type_selection.dart';
import 'package:tourism_host/screens/Add%20property/Property%20Describing/property_location.dart';
import 'package:tourism_host/screens/Add%20property/Property%20Describing/space_usage.dart';
import 'package:tourism_host/screens/Add%20property/Property%20Veryfication/host_details.dart';
import 'package:tourism_host/screens/Add%20property/Property%20Veryfication/poperty_verification.dart';
import 'package:tourism_host/screens/Dashboard/dashboard.dart';
import 'package:tourism_host/screens/Property%20Details/property_details.dart';
import 'package:tourism_host/screens/Property%20Details/property_list.dart';
import 'package:tourism_host/screens/registration/progress_page.dart';
import 'package:tourism_host/screens/registration/registration.dart';

void main() {
  runApp(HostApp());
}

class HostApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Host-Side Hotel Booking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (context) => DashboardPage(),
        
        '/registration': (context) => HostRegistrationPage(),
        '/progress_page': (context) => ProgressTrackerPage(),

        '/propertyselection': (context) => PropertyTypeSelectionPage(),
        '/which_kind_of_place': (context) => PropertyGuestTypeSelectionPage (),
        '/space_usage': (context) => SpaceDetailsPage(),
        '/property_location': (context) => PropertyLocationPage(),
         
        '/add_photos': (context) => UploadPhotosPage(),
        '/name_description': (context) => DescribePlacePage(),
         '/package_creation': (context) => SpecialPackagesPage(),
         '/add_amenities': (context) => SelectAmenitiesPage(),

        '/host_details': (context) => HostDetailsPage(),
        '/Property_verification': (context) => PropertyVerificationPage(),


       '/property_list': (context) {
        final property = ModalRoute.of(context)!.settings.arguments as PropertyModel;
        return PropertyList(property: property);
      },
        //'/property_details': (context) => PropertyDetailPage(),
        
      },
    );
  }
}
