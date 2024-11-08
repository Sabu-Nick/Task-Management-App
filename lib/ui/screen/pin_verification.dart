import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanagementapp/ui/screen/sign_in.dart';

import 'package:taskmanagementapp/ui/style/text_style.dart';
import 'package:taskmanagementapp/ui/widgets/background_screen.dart';
import '../style/buttom_style.dart';

import 'set_password.dart';

class PinVerification extends StatefulWidget {
  const PinVerification({super.key});

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
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
                      "Enter Your PIN",
                      style: AppTextStyles.headline,
                    ),
                    Text(
                     "Please enter the 5-digit PIN that was sent to your email address.",
                      style: AppTextStyles.bodyText,
                    ),
                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                      child: PinCodeTextField(
                        length: 5,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),

                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white10,
                          inactiveFillColor: Colors.white10,
                          selectedFillColor: Colors.white10,

                        ),
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        textStyle: TextStyle(color: Colors.white),
                        enableActiveFill: true,
                        appContext: context,
                      ),
                    ),

                    SizedBox(height: 14),


                    // ElevatedButton with label and icon
                    ElevatedButton(
                      onPressed: _onTabVerifyButton,
                      style: ElevatedButtonButtonStyle(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Verify PIN', style: AppTextStyles.buttonTextStyle),
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
  void _onTabVerifyButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetPassword(),
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
