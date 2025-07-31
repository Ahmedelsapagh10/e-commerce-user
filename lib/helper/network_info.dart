import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mstore/features/splash/controllers/splash_controller.dart';
import 'package:mstore/localization/language_constrants.dart';
import 'package:mstore/main.dart';
import 'package:provider/provider.dart';

// class NetworkInfo {
//   final Connectivity? connectivity;
//   NetworkInfo(this.connectivity);
//
//    Future<bool> get isConnected async {
//     ConnectivityResult result = await connectivity!.checkConnectivity();
//     return result != ConnectivityResult.none;
//   }
//
//   static void checkConnectivity(BuildContext context) {
//     bool firstTime = true;
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
//
//       print("====>>${result.name}");
//
//       bool isNotConnected = result == ConnectivityResult.none;
//       if(!firstTime) {
//         // bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
//         bool isNotConnected;
//         if(result == ConnectivityResult.none) {
//           isNotConnected = true;
//         }else {
//           isNotConnected = !await (_updateConnectivityStatus() as FutureOr<bool>);
//         }
//
//         // isNotConnected ? const SizedBox() : ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
//         ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
//           backgroundColor: isNotConnected ? Colors.red : Colors.green,
//           duration: Duration(seconds: isNotConnected ? 6000 : 3),
//           content: Text(
//             isNotConnected ? getTranslated('no_connection', Get.context!)! : getTranslated('connected', Get.context!)!,
//             textAlign: TextAlign.center,
//           ),
//         ));
//       }
//       firstTime = false;
//     });
//   }
//
//   static Future<bool?> _updateConnectivityStatus() async {
//      bool? isConnected;
//      try {
//        final List<InternetAddress> result = await InternetAddress.lookup('google.com');
//        if(result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//          isConnected = true;
//        }
//      }catch(e) {
//        isConnected = false;
//      }
//      return isConnected;
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    // Now checkConnectivity returns List<ConnectivityResult>
    List<ConnectivityResult> resultList =
        await connectivity.checkConnectivity();
    // Check if any connection type is available (not none)
    return resultList.any((result) => result != ConnectivityResult.none);
  }

/*************  ✨ Windsurf Command ⭐  *************/
  /// Listen to connectivity changes and show snackbar on change.
  ///
  /// If network is connected, show a green snackbar for 3 seconds.
  /// If network is not connected, show a red snackbar for 10 minutes.
  ///
  /// Additional internet check is performed to be more sure about
  /// the connectivity.
  ///
/*******  a141a881-bb2a-48dc-9db4-07e80d0962e8  *******/ static void
      checkConnectivity(BuildContext context) {
    bool firstTime = true;

    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> resultList) async {
      if (firstTime) {
        firstTime = false;
        return;
      }

      // If all results are none, treat as no connection
      bool isNotConnected = resultList.isEmpty ||
          resultList.every((r) => r == ConnectivityResult.none);

      if (!isNotConnected) {
        // Additional internet check to be more sure about connectivity
        isNotConnected = !await _updateConnectivityStatus();
      }

      // Show snackbar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: isNotConnected ? Colors.red : Colors.green,
        duration: Duration(seconds: isNotConnected ? 6000 : 3),
        content: Text(
          isNotConnected
              ? getTranslated('no_connection', context)!
              : getTranslated('connected', context)!,
          textAlign: TextAlign.center,
        ),
      ));
    });
  }

  static Future<bool> _updateConnectivityStatus() async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
