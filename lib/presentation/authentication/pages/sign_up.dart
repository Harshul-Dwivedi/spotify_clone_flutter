import 'package:blog_app/common/widgets/appbar/app_bar.dart';
import 'package:blog_app/common/widgets/buttons/custom_button.dart';
import 'package:blog_app/core/configs/assets/app_vectors.dart';
import 'package:blog_app/data/models/auth/create_user_req.dart';
import 'package:blog_app/domain/usecases/auth/signup.dart';
import 'package:blog_app/presentation/authentication/pages/sign_in.dart';
import 'package:blog_app/presentation/home/pages/home.dart';
import 'package:blog_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signinText(context),
      appBar: CustomAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(
              height: 50,
            ),
            _fullNameField(context),
            const SizedBox(
              height: 16,
            ),
            _emailNameField(context),
            const SizedBox(
              height: 16,
            ),
            _passwordField(
              context,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              onPressed: () async {
                var result = await sl<SignupUsecase>().call(
                    params: CreateUserReq(
                        fullName: _fullName.text.toString(),
                        email: _email.text.toString(),
                        password: _password.text.toString()));
                result.fold((l) {
                  var snackbar = SnackBar(content: Text(l));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }, (r) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const HomePage()),
                      (route) => false);
                });
              },
              label: "Create Account",
              height: 70,
            )
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      "Register",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(hintText: "Full Name")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailNameField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(hintText: "Enter Email")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(hintText: "Password")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already have a account?",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignIn()));
              },
              child: const Text(
                "Sign In",
                style: TextStyle(color: Colors.blue),
              )),
        ],
      ),
    );
  }
}
