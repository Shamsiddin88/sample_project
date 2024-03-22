import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/utils/project_extensions.dart';
import '../../../view_models/auth_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AuthViewModel>().getUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Info",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: user != null
          ? context.watch<AuthViewModel>().loading
          ? const Center(child: CircularProgressIndicator())
          :
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w()),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      "https://brur.ac.bd/wp-content/uploads/2019/03/male.jpg",
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(onPressed: (){ context.read<AuthViewModel>().updateImageUrl(
                          "https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-business-user-profile-vector-png-image_1541960.jpg");
                      }, icon: Icon(Icons.camera_alt, size: 30,)))
                ],
              ),
              20.getH(),
              Text(
                user.displayName.toString(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),textAlign: TextAlign.center,
              ),
              20.getH(),
              Container(width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w(), vertical: 12.h()),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 9),
                  ),
                ],borderRadius: BorderRadius.circular(20), color:Theme.of(context).primaryColor.withOpacity(.2) ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Username", style: Theme.of(context).textTheme.bodyLarge),
                    TextButton(onPressed: (){context.read<AuthViewModel>().updateUsername("Shamsiddin Djuraev");}, child: Text("change", style: Theme.of(context).textTheme.labelMedium,))
        
                  ],
                ),
                  Text(
                    user.displayName.toString(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700, color:Theme.of(context).primaryColor ),textAlign: TextAlign.center,
                  ),
              ],),),
              20.getH(),
              Container(width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w(), vertical: 12.h()),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 9),
                  ),
                ],borderRadius: BorderRadius.circular(20), color:Theme.of(context).primaryColor.withOpacity(.2) ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Email", style: Theme.of(context).textTheme.bodyLarge),
                        TextButton(onPressed: (){}, child: Text("change", style: Theme.of(context).textTheme.labelMedium,))
        
                      ],
                    ),
                    Text(
                      user.email.toString(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700, color:Theme.of(context).primaryColor ),textAlign: TextAlign.center,
                    ),
                  ],),),
              20.getH(),
              Container(width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w(), vertical: 12.h()),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 9),
                  ),
                ],borderRadius: BorderRadius.circular(20), color:Theme.of(context).primaryColor.withOpacity(.2) ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Phone number", style: Theme.of(context).textTheme.bodyLarge),
                        TextButton(onPressed: (){context.read<AuthViewModel>().updatePhoneNumber("+998933304660");}, child: Text("change", style: Theme.of(context).textTheme.labelMedium,))
        
                      ],
                    ),
                    Text(
                      user.phoneNumber.toString(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700, color:Theme.of(context).primaryColor ),textAlign: TextAlign.center,
                    ),
                  ],),),
              20.getH(),
              TextButton(onPressed: (){context.read<AuthViewModel>().logout(context);}, child: Text("Sign Out",style: Theme.of(context).textTheme.bodyLarge))
        
            ],
          ),
        ),
      ): const Center(
        child: Text("USER NOT EXIST"),
      ),
    );
  }
}
