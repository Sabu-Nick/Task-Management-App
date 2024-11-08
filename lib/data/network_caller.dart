// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:taskmanagementapp/data/network_response.dart';
// import 'package:taskmanagementapp/ui/controller/auth_controller.dart';
//
// import '../app.dart';
// import '../ui/screen/sign_in.dart';
//
// class NetworkCaller {
//   static Future<NetworkResponse> getRequest({required String url}) async {
//     try {
//       Uri uri = Uri.parse(url);
//       debugPrint('Requesting URL: $url'); //extra
//       final http.Response response = await http.get(uri,
//         headers: {
//           'token': AuthController.accessToken.toString(),
//         },
//       );
//       debugPrint(
//           'URL: $url\nResponse Code: ${response.statusCode}\nBody: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final decodedData = jsonDecode(response.body);
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: response.statusCode,
//           responseData: decodedData,
//         );
//       } else {
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: response.statusCode,
//           responseData: null,
//           errorMessages: 'Failed with status code ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       return NetworkResponse(
//         isSuccess: false,
//         statusCode: -1,
//         responseData: null,
//         errorMessages: e.toString(),
//       );
//     }
//   }
//
//   static Future<NetworkResponse> postRequest(
//       {required String url, Map<String, dynamic>? body}) async {
//     try {
//       Uri uri = Uri.parse(url);
//       debugPrint('Requesting URL: $url');
//       final http.Response response = await http.post(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'token': AuthController.accessToken.toString(),
//         },
//         body: jsonEncode(body),
//       );
//       debugPrint(
//           'URL: $url\nResponse Code: ${response.statusCode}\nBody: ${response.body}');
//
//       final decodedData = jsonDecode(response.body);
//
//       if (response.statusCode == 200) {
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: response.statusCode,
//           responseData: decodedData,
//         );
//       } else if (decodedData['status'] == 'fail') {
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: response.statusCode,
//           responseData: decodedData,
//           errorMessages: decodedData['data'],
//         );
//       } else {
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: response.statusCode,
//           responseData: null,
//           errorMessages: 'Failed with status code ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       return NetworkResponse(
//         isSuccess: false,
//         statusCode: -1,
//         responseData: null,
//         errorMessages: e.toString(),
//       );
//     }
//   }
//
//   static void printResponse(String url, http.Response response) {
//     debugPrint(
//       'URL: $url\nResponse Code: ${response.statusCode}\nBody: ${response.body}',
//     );
//   }
//
//   static void _moveToLogin() {
//     Navigator.pushAndRemoveUntil(
//       TaskManagerApp.navigatorKey.currentState!.context,
//       MaterialPageRoute(builder: (context) => const SignIn()),
//           (route) => false,
//     );
//   }
// }

// CHATGDP

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taskmanagementapp/data/network_response.dart';
import 'package:taskmanagementapp/ui/controller/auth_controller.dart';

import '../app.dart';
import '../ui/screen/sign_in.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint('Requesting URL: $url');

      final http.Response response = await http.get(
        uri,
        headers: {
          'token': AuthController.accessToken.toString(),
        },
      );

      // Use helper function for logging response
      printResponse(url, response);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      } else if (response.statusCode == 401) {
        _moveToLogin(); // Move to login if unauthorized
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: null,
          errorMessages: 'Unauthorized access. Redirecting to login.',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: null,
          errorMessages: 'Failed with status code ${response.statusCode}',
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        responseData: null,
        errorMessages: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint('Requesting URL: $url');

      final http.Response response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken.toString(),
        },
        body: jsonEncode(body),
      );

      // Use helper function for logging response
      printResponse(url, response);

      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      } else if (response.statusCode == 401) {
        _moveToLogin(); // Move to login if unauthorized
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: null,
          errorMessages: 'Unauthorized access. Redirecting to login.',
        );
      } else if (decodedData['status'] == 'fail') {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedData,
          errorMessages: decodedData['data'],
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: null,
          errorMessages: 'Failed with status code ${response.statusCode}',
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        responseData: null,
        errorMessages: e.toString(),
      );
    }
  }

  static void printResponse(String url, http.Response response) {
    debugPrint(
      'URL: $url\nResponse Code: ${response.statusCode}\nBody: ${response.body}',
    );
  }

  static void _moveToLogin() {
    Navigator.pushAndRemoveUntil(
      TaskManagerApp.navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => const SignIn()),
          (route) => false,
    );
  }
}
