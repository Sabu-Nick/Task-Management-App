import 'package:flutter/material.dart';
import 'package:taskmanagementapp/ui/controller/auth_controller.dart';

import '../screen/profile_screen.dart';
import '../screen/sign_in.dart';
import '../style/text_style.dart';

class TaskMenegerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskMenegerAppBar({
    super.key,
    this.isProfileScreenOpen = false,
  });

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isProfileScreenOpen) {
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(),
          ),
        );
      },
      child: AppBar(
        toolbarHeight: 300,
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back icon color to white
        ),
        title: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(

                backgroundColor: Colors.white,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   AuthController.userData?.fullName ?? '',
                    style: AppTextStyles.appBarTitileStyle,
                  ),
                  Text(
                    AuthController.userData?.email ?? '',
                    style: AppTextStyles.appBarSubTitileStyle,
                  ),
                ],
              )),
              IconButton(
                onPressed: () async {
                  await AuthController.clearUserData();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ),
                  );
                },
                icon: Icon(Icons.logout),
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
