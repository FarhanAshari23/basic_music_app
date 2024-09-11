import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/basic_appbar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/auth/pages/signin.dart';
import 'package:spotify/presentation/auth/pages/signup.dart';

class SignUpOrSigninPage extends StatelessWidget {
  const SignUpOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppBar(),
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
            child: Image.asset(
              AppImages.authBg,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 190),
              child: Column(
                children: [
                  SvgPicture.asset(AppVectors.logo),
                  const SizedBox(height: 45),
                  const Text(
                    'Enjoy Listening Music',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Spotify is a proprietary Swedish audio streaming and media services provider',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: AppColors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BasicAppButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          ),
                          tittle: "Register",
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                              )),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
