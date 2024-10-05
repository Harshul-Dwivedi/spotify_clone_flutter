import 'package:blog_app/common/widgets/appbar/app_bar.dart';
import 'package:blog_app/common/widgets/buttons/custom_button.dart';
import 'package:blog_app/core/configs/assets/app_vectors.dart';
import 'package:blog_app/data/models/auth/signin_user_req.dart';
import 'package:blog_app/domain/usecases/auth/signin.dart';
import 'package:blog_app/presentation/authentication/pages/sign_up.dart';
import 'package:blog_app/presentation/home/pages/home.dart';
import 'package:blog_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
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
            _signinText(),
            const SizedBox(
              height: 50,
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
                var result = await sl<SigninUsecase>().call(
                    params: SigninUserReq(
                        email: _email.text.toString(),
                        password: _password.text.toString()));
                result.fold((l) {
                  var snackbar = SnackBar(
                    content: Text(l),
                    behavior: SnackBarBehavior.floating,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }, (r) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const HomePage()),
                      (route) => false);
                });
              },
              label: "Sign In",
              height: 70,
            )
          ],
        ),
      ),
    );
  }

  Widget _signinText() {
    return const Text(
      "Sign In",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailNameField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(hintText: "Enter Username or Email")
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

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Not a Member?",
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
                        builder: (BuildContext context) => SignUp()));
              },
              child: const Text(
                "Register Now",
                style: TextStyle(color: Colors.blue),
              )),
        ],
      ),
    );
  }
}
