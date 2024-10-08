import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/app_navigator.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/auth/pages/signup_or_signin.dart';
import 'package:spotify/presentation/choose%20mode/bloc/choose_mode_cubit.dart';
import 'package:spotify/presentation/choose%20mode/bloc/choose_mode_state.dart';
import 'package:spotify/presentation/choose%20mode/bloc/theme_cubit.dart';
import 'package:spotify/presentation/home/pages/home.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.chooseModeBg),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.15),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVectors.logo),
                ),
                const Spacer(),
                const Text(
                  "Choose Mode",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                BlocProvider(
                  create: (_) => ChooseModeCubit()..appStarted(),
                  child: BlocBuilder<ChooseModeCubit, ChooseModeState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<ThemeCubit>()
                                      .updateTheme(ThemeMode.light);
                                  if (state is ChooseModeUnAuthenticated) {
                                    AppNavigator.push(
                                      context,
                                      const SignUpOrSigninPage(),
                                    );
                                  }
                                  if (state is ChooseModeAuthenticated) {
                                    AppNavigator.push(
                                      context,
                                      const HomePage(),
                                    );
                                  }
                                },
                                child: ClipOval(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff30393C)
                                              .withOpacity(0.5),
                                          shape: BoxShape.circle),
                                      child: SvgPicture.asset(
                                        AppVectors.sun,
                                        fit: BoxFit.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                'Light Mode',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(width: 40),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<ThemeCubit>()
                                      .updateTheme(ThemeMode.dark);
                                  if (state is ChooseModeUnAuthenticated) {
                                    AppNavigator.push(
                                      context,
                                      const SignUpOrSigninPage(),
                                    );
                                  }
                                  if (state is ChooseModeAuthenticated) {
                                    AppNavigator.push(
                                      context,
                                      const HomePage(),
                                    );
                                  }
                                },
                                child: ClipOval(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff30393C)
                                            .withOpacity(0.5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        AppVectors.moon,
                                        fit: BoxFit.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                'Dark Mode',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey,
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
