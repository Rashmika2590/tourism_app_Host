// import 'dart:convert'; // For JSON encoding/decoding
// import 'package:http/http.dart' as http;

// class ApiService {
//   final String baseUrl;

//   ApiService({required this.baseUrl});

//   // Method to create a property
//   Future<dynamic> createProperty(String token, Map<String, dynamic> propertyData) async {
//     final url = Uri.parse('$baseUrl/api/Property');
//     final headers = {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: headers,
//         body: jsonEncode(propertyData),
//       );

//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         return jsonDecode(response.body); // Successful response
//       } else {
//         throw Exception('Failed to create property: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// }
