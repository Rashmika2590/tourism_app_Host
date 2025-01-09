import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourism_host/Utils/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register with email and password
  Future<String?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Retrieve the ID token
      String? idToken = await result.user?.getIdToken();
      await SharedPreferecesUtil.setToken(idToken!);
      print('Firebase ID Token (Registration): $idToken');
      return idToken; // Return the token
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  // Login with email and password
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        // Retrieve Firebase token
        String? token = await user.getIdToken();
        await SharedPreferecesUtil.setToken(token!);

        // You can pass the token to your backend or store it securely
        return user;
      }
      return null; // Return null if user is null
    } catch (e) {
      print('Error in signInWithEmailPassword: $e');
      return null; // Return null on error
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
