import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanagementapp/data/models/user_model.dart';
import 'package:taskmanagementapp/data/network_caller.dart';
import 'package:taskmanagementapp/data/network_response.dart';
import 'package:taskmanagementapp/data/urls.dart';
import 'package:taskmanagementapp/ui/controller/auth_controller.dart';
import 'package:taskmanagementapp/ui/widgets/background_screen.dart';
import 'package:taskmanagementapp/ui/widgets/center_circular_progress_indicator.dart';
import 'package:taskmanagementapp/ui/widgets/task_appbar.dart';

import '../style/buttom_style.dart';
import '../style/text_field_style.dart';
import '../style/text_style.dart';
import '../widgets/buttom_nav_bar_screen.dart';
import '../widgets/snack_bar_mgs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _fullNameTEController = TextEditingController();
  final TextEditingController _mobileNumberTEController =
      TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _selectedImages;
  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  void _setUserData() {
    _fullNameTEController.text = AuthController.userData?.fullName ?? '';
    _mobileNumberTEController.text = AuthController.userData?.mobile ?? '';
    _emailTEController.text = AuthController.userData?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskMenegerAppBar(isProfileScreenOpen: true),
      body: SingleChildScrollView(
        child: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Text(
                    "Update Profile",
                    style: AppTextStyles.headline,
                  ),
                  SizedBox(height: 20),
                  buildPhotoPicker(),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _fullNameTEController,
                    keyboardType: TextInputType.name,
                    decoration: TextFormFieldDecoration("Full Name"),
                    style: TextStyle(color: Colors.white),
                    validator: (String? value){
                      if(value?.trim().isEmpty?? true){
                            return 'Enter your name';
                      } return  null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _mobileNumberTEController,
                    keyboardType: TextInputType.phone,
                    decoration: TextFormFieldDecoration("Mobile Number"),
                    style: TextStyle(color: Colors.white),
                    validator: (String? value){
                      if(value?.trim().isEmpty?? true){
                        return 'Mobile Number';
                      } return  null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: false,
                    controller: _emailTEController,
                    decoration: TextFormFieldDecoration("Email"),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: !_updateProfileInProgress,
                    replacement: CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapUpdateProfile,
                      style: ElevatedButtonButtonStyle(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Update Information',
                              style: AppTextStyles.buttonTextStyle),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward),
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
    );
  }

  Widget buildPhotoPicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(236, 30, 38, 1),
          borderRadius: BorderRadius.circular(5),
        ),
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.camera_alt, color: Colors.white),
              SizedBox(width: 10),
              Text(
                _getSelectedPhotoTitle(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSelectedPhotoTitle() {
    if (_selectedImages != null) {
      return _selectedImages!.name;
    } else {
      return 'Please select your photo';
    }
  }

  Future<void> _updatedProfile() async {
    _updateProfileInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _fullNameTEController.text.trim(),
      "mobile": _mobileNumberTEController.text.trim(),
    };
    final _selectedImages = this._selectedImages;
    if (_selectedImages != null) {
      List<int> imageBytes = await _selectedImages!.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody['photo'] = convertedImage;
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.updateProfile, body: requestBody);
    _updateProfileInProgress = false;
    setState(() {});

    if(response.isSuccess){

      UserModel userModel = UserModel.fromJson(requestBody);
        AuthController.saveUserData(userModel);
        SnackBarMessages(context, 'Wow! you are successfully update your profile', true);

    }else{
      SnackBarMessages(context, 'Opps! you are faild to update your profile', true);
    }



  }

  Future<void> _pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      _selectedImages = pickImage;
      setState(() {});
    }
  }

  void _onTapUpdateProfile() {
    if (_formKey.currentState!.validate()) {}
    _updatedProfile();
  }
}
