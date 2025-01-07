
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tourism_host/firebase_options.dart';
import 'package:tourism_host/screens/Add%20property/Place%20Shining/add_rules.dart';
import 'package:tourism_host/screens/Add%20property/Property%20Describing/select_gust_types.dart';

import 'package:tourism_host/screens/Add%20property/progress_page.dart';
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
import 'package:tourism_host/screens/Dashboard/notifiactions.dart';
import 'package:tourism_host/screens/Dashboard/profile.dart';
import 'package:tourism_host/screens/Dashboard/property_creation_test.dart';

import 'package:tourism_host/screens/Property%20Details/property_details.dart';
import 'package:tourism_host/screens/Property%20Details/property_list.dart';
import 'package:tourism_host/screens/Report/report.dart';
//import 'package:tourism_host/screens/Today%20Bookings/booking_detail.dart';
import 'package:tourism_host/screens/Today%20Bookings/booking_list.dart';
import 'package:tourism_host/screens/registration/login.dart';


import 'package:tourism_host/screens/registration/registration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      initialRoute: '/login_page',
      routes: {
        '/dashboard': (context) => DashboardPage(),
        
        '/registration': (context) => HostRegistrationPage(),
        '/login_page': (context) => LoginPage(),

        '/progress_page': (context) => ProgressTrackerPage(),

        '/propertyselection': (context) => PropertyTypeSelectionPage(),
        '/which_kind_of_place': (context) => PropertyGuestTypeSelectionPage (),
        '/space_usage': (context) => SpaceDetailsPage(),
        '/property_location': (context) => PropertyLocationPage(),
        '/select_gust_types': (context) => SelectGuestTypesPage(),
        
        '/add_photos': (context) => UploadPhotosPage(),
        '/name_description': (context) => DescribePlacePage(),
         '/package_creation': (context) => SpecialPackagesPage(),
         '/add_amenities': (context) => SelectAmenitiesPage(),
         '/add_rules': (context) => RulesSelectionPage(selectedRules:[],),
         
        '/host_details': (context) => HostDetailsPage(),
        '/Property_verification': (context) => PropertyVerificationPage(),


       '/property_list': (context) {
        final property = ModalRoute.of(context)!.settings.arguments as PropertyModel;
        return PropertyList(property: property);
      },
        //'/property_details': (context) => PropertyDetailPage(),

      '/today_booking': (context) => TodaysBookingPage(),
      //'/booking_detail': (context) => BookingDetailsPage(),

      '/report': (context) => BookingReportPage(),
      

      '/notifications': (context) => HostNotificationPage(),
      '/profile': (context) => ProfilePage (),

      '/Property_creation_test': (context) => PropertyCreationPage (),
        
      },
    );
  }
}
