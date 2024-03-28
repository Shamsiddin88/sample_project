import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static getStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    debugPrint("STORAGE STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.storage.request();
      debugPrint("STORAGE STATUS AFTER ASK:$status");
    }
  }

  static getCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    debugPrint("CAMERA STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.camera.request();
      debugPrint("CAMERA STATUS AFTER ASK:$status");
    }
  }

  static getLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    debugPrint("LOCATION STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.location.request();
      debugPrint("LOCATION STATUS AFTER ASK:$status");
    }
  }

  static getContactsPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.contacts.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getPhonePermission() async {
    PermissionStatus status = await Permission.phone.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.phone.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getAccessMediaLocationPermission() async {
    PermissionStatus status = await Permission.accessMediaLocation.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.accessMediaLocation.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getSmsPermission() async {
    PermissionStatus status = await Permission.sms.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.sms.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getAudioPermission() async {
    PermissionStatus status = await Permission.audio.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.audio.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getBluetoothScanPermission() async {
    PermissionStatus status = await Permission.bluetoothScan.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.bluetoothScan.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.microphone.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getSomePermissions() async {
    List<Permission> permissions = [
      Permission.activityRecognition,
      Permission.bluetoothAdvertise,
      Permission.assistant,
      Permission.mediaLibrary,
      Permission.photos
    ];
    Map<Permission, PermissionStatus> somePermissionsResults =
        await permissions.request();


  }
}
