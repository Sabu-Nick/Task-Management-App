import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagementapp/data/network_caller.dart';
import 'package:taskmanagementapp/data/network_response.dart';
import 'package:taskmanagementapp/data/urls.dart';
import 'package:taskmanagementapp/ui/screen/sign_in.dart';
import 'package:taskmanagementapp/ui/style/text_style.dart';
import 'package:taskmanagementapp/ui/widgets/background_screen.dart';
import '../style/buttom_style.dart';
import '../style/text_field_style.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/snack_bar_mgs.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileNumberTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Join With Us", style: AppTextStyles.headline),
                      Text(
                        "Welcome back! Please log in to access your account and manage all your activities with ease.",
                        style: AppTextStyles.bodyText,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _firstNameTEController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: TextFormFieldDecoration("First Name"),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Enter Your First Name';
                          return null;
                        },
                      ),
                      SizedBox(height: 14),
                      TextFormField(
                        controller: _lastNameTEController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: TextFormFieldDecoration("Last Name"),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Enter Your Last Name';
                          return null;
                        },
                      ),
                      SizedBox(height: 14),
                      TextFormField(
                        controller: _mobileNumberTEController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.phone,
                        decoration: TextFormFieldDecoration("Mobile Number"),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Enter Your Mobile Number';
                          // if (value.length != 11) return 'Mobile number must be exactly 11 digits';
                          return null;
                        },
                      ),
                      SizedBox(height: 14),
                      TextFormField(
                        controller: _emailTEController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        decoration: TextFormFieldDecoration("Email"),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Enter Your Email';
                          return null;
                        },
                      ),
                      SizedBox(height: 14),
                      TextFormField(
                        controller: _passwordTEController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        decoration: TextFormFieldDecoration("Password"),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Enter Your Password';
                          return null;
                        },
                      ),
                      SizedBox(height: 14),
                      Visibility(
                        visible: !_inProgress,
                        replacement: CenterCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onTabSignUpButton,
                          style: ElevatedButtonButtonStyle(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Sign Up', style: AppTextStyles.buttonTextStyle),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.white),
                            text: "Have an account? ",
                            children: [
                              TextSpan(
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                                text: "Sign In",
                                recognizer: TapGestureRecognizer()..onTap = _onTabSignIn,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTabSignUpButton() {
    if (_formKey.currentState?.validate() ?? false) {
      _signup();
    }
  }

  Future<void> _signup() async {
    setState(() => _inProgress = true);

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileNumberTEController.text.trim(),
      "password": _passwordTEController.text.trim(),
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.registration,
      body: requestBody,
    );

    setState(() => _inProgress = false);

    if (response.isSuccess) {
      _clearTextFields();
      SnackBarMessages(context, 'New user created');
    } else {
      SnackBarMessages(context, 'Something went wrong', true);
    }
  }

  void _onTabSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  void _clearTextFields() {
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _emailTEController.clear();
    _mobileNumberTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    _mobileNumberTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
