import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tourism_host/Services/auth_service.dart'; // Add this import

class HostRegistrationPage extends StatefulWidget {
  @override
  _HostRegistrationPageState createState() => _HostRegistrationPageState();
}

class _HostRegistrationPageState extends State<HostRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  bool _isLoading = false;

  // Controllers for input fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final AuthService _authService = AuthService(); // Initialize AuthService

  // Error messages
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _passwordError;
  String? _phoneError;

  @override
  void initState() {
    super.initState();

    // Add listeners for real-time validation
    _firstNameController.addListener(_validateInputs);
    _lastNameController.addListener(_validateInputs);
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
    _phoneController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      _firstNameError = _firstNameController.text.isEmpty ? 'First Name is required' : null;
      _lastNameError = _lastNameController.text.isEmpty ? 'Last Name is required' : null;
      _emailError = EmailValidator.validate(_emailController.text) ? null : 'Enter a valid email';
      _passwordError = _validatePassword(_passwordController.text);
      _phoneError = _phoneController.text.length >= 10 ? null : 'Phone number must be at least 10 digits';

      _isButtonEnabled = _firstNameError == null &&
          _lastNameError == null &&
          _emailError == null &&
          _passwordError == null &&
          _phoneError == null;
    });
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    if (!RegExp(r'^(?=.*[a-z])').hasMatch(password)) return 'Password must contain a lowercase letter';
    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(password)) return 'Password must contain an uppercase letter';
    if (!RegExp(r'^(?=.*\d)').hasMatch(password)) return 'Password must contain a number';
    return null;
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _authService.registerWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration Successful!')));
        Navigator.pushNamed(context, '/dashboard');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the sign-in process
        return;
      }


      //final user = await _authService.signInWithGoogle();


      // if (user != null) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Google Sign-In Successful!')));
      //   Navigator.pushNamed(context, '/progress_page');
      // }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 100),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Welcome to ",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Stay Haven",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                    ),
                    TextSpan(text: " Host", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We're excited to have you",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 70),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(controller: _firstNameController, label: 'First Name', errorText: _firstNameError),
                    SizedBox(height: 15),
                    _buildTextField(controller: _lastNameController, label: 'Last Name', errorText: _lastNameError),
                    SizedBox(height: 15),
                    _buildTextField(controller: _emailController, label: 'Email', keyboardType: TextInputType.emailAddress, errorText: _emailError),
                    SizedBox(height: 15),
                    _buildTextField(controller: _passwordController, label: 'Password', obscureText: true, errorText: _passwordError),
                    SizedBox(height: 15),
                    _buildTextField(controller: _phoneController, label: 'Phone Number', keyboardType: TextInputType.phone, errorText: _phoneError),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _isButtonEnabled && !_isLoading ? _registerUser : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(fontSize: 16, color: Colors.white),
                        minimumSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Continue', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: 15),
                    TextButton(
                      onPressed: _googleSignIn, 
                      child: Text('Sign In with Google'),
                      ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login_page');
                      },
                      child: Text('Already have an account? Login', style: TextStyle(color: Colors.blueAccent)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? errorText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: const Color.fromARGB(255, 207, 206, 206)),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
