import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagementapp/ui/screen/sign_in.dart';

import 'package:taskmanagementapp/ui/style/text_style.dart';
import 'package:taskmanagementapp/ui/widgets/background_screen.dart';
import '../style/buttom_style.dart';
import '../style/text_field_style.dart';
import 'pin_verification.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start, // Adjust as needed for horizontal alignment
                  children: [
                    Text(
                      "Enter Your Email",
                      style: AppTextStyles.headline,
                    ),
                    Text(
                      "Please enter your email address. We will send you a verification CODE to confirm your identity and ensure the security of your account",
                      style: AppTextStyles.bodyText,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: TextFormFieldDecoration("Email"),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 14),


                    // ElevatedButton with label and icon
                    ElevatedButton(
                      onPressed: _onTabNextButton,
                      style: ElevatedButtonButtonStyle(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Next', style: AppTextStyles.buttonTextStyle),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),

                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              text: "Have an account? ",
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  text: "Sign In",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _onTabSignIn,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PinVerification(),
      ),
    );
  }

  void _onTabSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignIn(),
      ),
    );
  }
}
