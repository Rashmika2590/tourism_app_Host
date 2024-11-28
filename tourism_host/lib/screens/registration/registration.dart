import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tourism_host/Services/auth_service.dart';


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

  void _validateInputs() {
    setState(() {
      _isButtonEnabled = _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          EmailValidator.validate(_emailController.text) &&
          _passwordController.text.length >= 6 &&
          _phoneController.text.length >= 10; // Minimum 10 digits
    });
  }

  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Register user with Firebase Authentication
      final user = await _authService.registerWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (user != null) {
        // Save additional user details to Firestore (optional, can be added later)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Successful!')),
        );
        // Navigate to the next page (e.g., Property Type Selection)
        Navigator.pushNamed(context, '/progress_page');
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 100), // Top spacing
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Welcome to ",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Stay Haven",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    TextSpan(
                      text: " Host",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We're excited to have you",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 70), // Space before the form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _firstNameController,
                      label: 'First Name',
                      validator: (value) =>
                          value == null || value.isEmpty ? 'First Name is required' : null,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: _lastNameController,
                      label: 'Last Name',
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Last Name is required' : null,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => EmailValidator.validate(value ?? '')
                          ? null
                          : 'Enter a valid email',
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Password',
                      obscureText: true,
                      validator: (value) => value != null && value.length >= 6
                          ? null
                          : 'Password must be at least 6 characters',
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      validator: (value) => value != null && value.length >= 10
                          ? null
                          : 'Enter a valid phone number',
                    ),
                    SizedBox(height: 70),
                    ElevatedButton(
                      onPressed: _isButtonEnabled
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                _registerUser();
                              }
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
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Continue',
                              style: TextStyle(color: Colors.white),
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
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
      onChanged: (_) => _validateInputs(),
      validator: validator,
    );
  }
}
