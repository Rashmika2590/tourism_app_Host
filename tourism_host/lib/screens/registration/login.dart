// lib/views/host/login_page.dart

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tourism_host/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  bool _isLoading = false;

  // Controllers for input fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService(); // Initialize AuthService

  // Error messages
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();

    // Add listeners for real-time validation
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      _emailError = EmailValidator.validate(_emailController.text)
          ? null
          : 'Enter a valid email';

      _passwordError = _passwordController.text.isNotEmpty
          ? null
          : 'Password is required';

      _isButtonEnabled = _emailError == null && _passwordError == null;
    });
  }

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) {
      // If form is not valid, do not proceed
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Login user with Firebase Authentication
      final user = await _authService.loginWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Successful!')),
        );
        // Navigate to the dashboard or home page
        Navigator.pushNamed(context, '/dashboard');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Optional: Add a logo or image here
              SizedBox(height: 80), // Top spacing
              Text(
                "Login to Stay Haven Host",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Welcome back! Please login to continue.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 80), // Space before the form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      errorText: _emailError,
                      validator: (value) => EmailValidator.validate(value ?? '')
                          ? null
                          : 'Enter a valid email',
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Password',
                      obscureText: true,
                      errorText: _passwordError,
                      validator: (value) =>
                          value != null && value.isNotEmpty ? null : 'Password is required',
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: _isButtonEnabled && !_isLoading
                          ? () {
                              _loginUser();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        textStyle:
                            TextStyle(fontSize: 16, color: Colors.white), // Text style
                        minimumSize: Size(MediaQuery.of(context).size.width, 50), // Full-width button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Login',
                              style: TextStyle(color: Colors.white), // Text color explicitly set to white
                            ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registration');
                      },
                      child: Text(
                        'Don\'t have an account? Register',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
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
      validator: validator,
    );
  }
}
