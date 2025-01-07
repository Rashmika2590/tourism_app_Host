import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // Register with email and password
  Future<String?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Retrieve the ID token
      String? idToken = await result.user?.getIdToken();
      print('Firebase ID Token (Registration): $idToken');
      return idToken; // Return the token
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }
  Future<void> saveToken(String token) async {
  try {
    await secureStorage.write(key: 'firebase_token', value: token);
    print('Token saved securely.');
  } catch (e) {
    print('Error saving token: $e');
  }
}


  // Login with email and password
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    String? idToken = await result.user?.getIdToken();
    if (idToken != null) {
      await saveToken(idToken);
    }
    print('Firebase ID Token (Login): $idToken');
    return result.user; // Ensure this returns a User object
  } catch (e) {
    throw Exception('Login failed: ${e.toString()}');
  }
}



//  Future<String?> getIdToken() async {
//   try {
//     final user = _auth.currentUser;
//     if (user == null) {
//       print('No user is currently logged in.');
//       return null;
//     }
//     String? token = await user.getIdToken();
//     print('Firebase ID Token: $token');
//     return token;
//   } catch (e) {
//     print('Failed to get ID Token: ${e.toString()}');
//     throw Exception('Failed to get ID Token: ${e.toString()}');
//   }
// }



  // Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  // Get the current user
  User? get currentUser => _auth.currentUser;

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Reset password failed: ${e.toString()}');
    }
  }

  // Delete account
  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
    } catch (e) {
      throw Exception('Account deletion failed: ${e.toString()}');
    }
  }
}
