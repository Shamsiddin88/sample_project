import 'package:flutter/material.dart';
import 'package:sample_project/screens/widgets/universal_button.dart';
import 'package:sample_project/utils/project_extensions.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/permission_utils/app_permissions.dart';
import '../../utils/styles/app_text_style.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Permission",
          style: AppTextStyle.rubikBold.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.c_1317DD,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UniversalButton(title: "Permissioin 1", onTap: (){
                AppPermissions.getStoragePermission();
              }),
              UniversalButton(title: "Permissioin 2", onTap: (){
                AppPermissions.getCameraPermission();
              }),
              UniversalButton(title: "Permissioin 3", onTap: (){
                AppPermissions.getLocationPermission();
              }),
              UniversalButton(title: "Permissioin 4", onTap: (){
                AppPermissions.getContactsPermission();
              }),
              UniversalButton(title: "Permissioin 5", onTap: (){
                AppPermissions.getPhonePermission();
              }),
              UniversalButton(title: "Permissioin 6", onTap: (){
                AppPermissions.getSmsPermission();
              }),
              UniversalButton(title: "Permissioin 7", onTap: (){
                AppPermissions.getAudioPermission();
              }),
              UniversalButton(title: "Permissioin 8", onTap: (){
                AppPermissions.getMicrophonePermission();
              }),
              UniversalButton(title: "Permissioin 9", onTap: (){
                AppPermissions.getBluetoothScanPermission();
              }),
              UniversalButton(title: "Permissioin 10", onTap: (){
                AppPermissions.getAccessMediaLocationPermission();
              }),
              UniversalButton(title: "Permissioin 11", onTap: (){
                AppPermissions.getSomePermissions();
              }),
          ],),
        ),
      ),
    );
  }
}
