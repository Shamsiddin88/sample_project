import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/routes.dart';
import 'package:sample_project/screens/widgets/universal_text_input.dart';
import 'package:sample_project/utils/colors/app_colors.dart';
import 'package:sample_project/utils/constants/app_constant.dart';
import 'package:sample_project/utils/images/app_images.dart';
import 'package:sample_project/utils/project_extensions.dart';

import '../../view_models/auth_view_model.dart';
import '../widgets/password_text_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
bool  isChecked=false;
class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController firstNameController=TextEditingController();
  final TextEditingController lastNameController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController confirmPasswordController=TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.dark)
      ,child: Scaffold(
      body:context.watch<AuthViewModel>().loading?
      const Center(child: CircularProgressIndicator(),)
          :
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 44.w()),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    AppImages.registerImage,
                    height: 250.h(),
                  ),
                ),
                16.getH(),
                Text("Sign Up", style: Theme.of(context)
                    .textTheme
                    .bodyLarge),
                16.getH(),
                UniversalTextInput(controller: firstNameController, hintText: "First Name", type: TextInputType.text, regExp: AppConstants.textRegExp, errorTitle: 'First Name', iconPath: AppImages.profile,),
                16.getH(),
                UniversalTextInput(controller: lastNameController, hintText: "Last Name", type: TextInputType.text, regExp: AppConstants.textRegExp, errorTitle: 'Last Name', iconPath: AppImages.profile,),
                16.getH(),
                UniversalTextInput(controller: emailController, hintText: "Email", type: TextInputType.emailAddress, regExp: AppConstants.emailRegExp, errorTitle: 'E-mail', iconPath: AppImages.email,),
                16.getH(),
                PasswordTextInput(controller: passwordController, ),
                16.getH(),
                PasswordTextInput(controller: confirmPasswordController,),
                13.getH(),
                TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 18.h(), horizontal: 80.w()),
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                    onPressed: (){context.read<AuthViewModel>().registerUser(
                      context,
                      email: emailController.text,
                      password: passwordController.text,
                      username: "${firstNameController.text}+ ${lastNameController.text}",
                    );},child: Text("SIGNUP", style: Theme.of(context)
                    .textTheme
                    .bodyMedium!.copyWith(color: AppColors.white))),
                13.getH(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Already have an account?"),
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(
                        context, RouteNames.loginRoute); }, child: Text("Login"))
                ],)



              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
