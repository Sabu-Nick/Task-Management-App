import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagementapp/data/models/login_model.dart';
import 'package:taskmanagementapp/data/network_caller.dart';
import 'package:taskmanagementapp/data/network_response.dart';
import 'package:taskmanagementapp/ui/screen/sign_up.dart';
import 'package:taskmanagementapp/ui/style/text_style.dart';
import 'package:taskmanagementapp/ui/widgets/background_screen.dart';
import '../../data/urls.dart';
import '../controller/auth_controller.dart';
import '../style/buttom_style.dart';
import '../style/text_field_style.dart';
import '../widgets/buttom_nav_bar_screen.dart';
import '../widgets/snack_bar_mgs.dart';
import 'email_verification.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                      Text(
                        "Get Started With",
                        style: AppTextStyles.headline,
                      ),
                      Text(
                        "Welcome back! Please log in to access your account and manage all your activities with ease.",
                        style: AppTextStyles.bodyText,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailTEController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        decoration: TextFormFieldDecoration("Email"),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _passwordTEController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        decoration: TextFormFieldDecoration("Password"),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your password';
                          }
                          if (value!.length <= 6) {
                            return 'Please enter your password with more than 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      Visibility(
                        visible: !_inProgress,
                        replacement: const CircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onTabNextButton,
                          style: ElevatedButtonButtonStyle(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Login',
                                  style: AppTextStyles.buttonTextStyle),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: _onTabForgotPassword,
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                text: "Don't have an account? ",
                                children: [
                                  TextSpan(
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    text: " Sign Up",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _onTabSignUp,
                                  ),
                                ],
                              ),
                            ),
                          ],
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

  // Handlers for button actions
  void _onTabNextButton() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _signIn();
  }

  Future<void> _signIn() async {
    setState(() {
      _inProgress = true;
    });

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text,
      "password": _passwordTEController.text,
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.login, body: requestBody);

    setState(() {
      _inProgress = false;
    });

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ButtomNavBarScreen()),
      );
    } else {
      SnackBarMessages(context, 'No user found', true);
    }
  }

  void _onTabForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmailVerification()),
    );
  }

  void _onTabSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
    );
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
