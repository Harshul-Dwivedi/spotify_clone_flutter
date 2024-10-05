import 'package:blog_app/common/helpers/is_dark_mode.dart';
import 'package:blog_app/common/widgets/appbar/app_bar.dart';
import 'package:blog_app/common/widgets/buttons/custom_button.dart';
import 'package:blog_app/core/configs/assets/app_images.dart';
import 'package:blog_app/core/configs/assets/app_vectors.dart';
import 'package:blog_app/presentation/authentication/pages/sign_in.dart';
import 'package:blog_app/presentation/authentication/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpOrSignInPage extends StatelessWidget {
  const SignUpOrSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBG),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppVectors.logo),
                const SizedBox(
                  height: 42,
                ),
                const Text(
                  "Enjoy Listening To Music",
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Spotify is a proprietary Swedish audio streaming and media services provider ",
                  style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 13,
                      color: context.isDarkMode
                          ? Colors.grey[300]
                          : Colors.black54,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => SignUp()));
                        },
                        label: "Register",
                        height: 60,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => SignIn()));
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
