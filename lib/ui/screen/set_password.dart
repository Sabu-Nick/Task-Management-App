import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagementapp/ui/screen/sign_in.dart';

import 'package:taskmanagementapp/ui/style/text_style.dart';
import 'package:taskmanagementapp/ui/widgets/background_screen.dart';
import '../style/buttom_style.dart';
import '../style/text_field_style.dart';


class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
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
                      "Enter Your Password",
                      style: AppTextStyles.headline,
                    ),
                    Text(
                      "Your password must be at least 8 characters long and include a combination of letters, numbers, and symbols.",
                      style: AppTextStyles.bodyText,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: TextFormFieldDecoration("Password"),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 14),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: TextFormFieldDecoration("Confrim Password"),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 14),


                    // ElevatedButton with label and icon
                    ElevatedButton(
                      onPressed: _onTabUpdatePasswordButton,
                      style: ElevatedButtonButtonStyle(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Update Password', style: AppTextStyles.buttonTextStyle),
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
  void _onTabUpdatePasswordButton() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignIn(),
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
