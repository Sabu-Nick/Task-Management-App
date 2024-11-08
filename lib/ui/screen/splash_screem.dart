import 'package:flutter/material.dart';
import 'package:taskmanagementapp/ui/controller/auth_controller.dart';
import '../utility/assets_paths.dart';
import '../widgets/background_screen.dart';
import '../widgets/buttom_nav_bar_screen.dart';
import 'sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    _goToSignInScreen();
  }

  Future<void> _goToSignInScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    String? token = await AuthController.getAccessToken();
    if (token != null && AuthController.isLogin()) {
      await AuthController.getUserData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ButtomNavBarScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AssetsPaths.logoPng, width: 280, height: 280),
            ],
          ),
        ),
      ),
    );
  }
}
