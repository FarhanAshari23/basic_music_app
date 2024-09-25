import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/widgets/appbar/basic_appbar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/presentation/auth/bloc/password_cubit.dart';
import 'package:spotify/presentation/auth/pages/signup.dart';

import '../../../domain/usecases/auth/signin.dart';
import '../../../service_locator.dart';
import '../../home/pages/home.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signInText(context),
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            children: [
              _registerText(),
              const SizedBox(height: 20),
              _emailTextField(context),
              const SizedBox(height: 20),
              _passwordTextField(context),
              const SizedBox(height: 30),
              BasicAppButton(
                onPressed: () async {
                  var result = await sl<SignInUseCase>().call(
                    params: SignInUserReq(
                      email: _emailC.text.toString(),
                      passwword: _passC.text.toString(),
                    ),
                  );
                  return result.fold(
                    (error) {
                      var snackbar = SnackBar(content: Text(error));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                    (r) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false,
                      );
                    },
                  );
                },
                tittle: "Sign In",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailTextField(BuildContext context) {
    return TextField(
      controller: _emailC,
      decoration: const InputDecoration(
        hintText: "Enter Username or Email",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordTextField(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordCubit(),
      child: BlocBuilder<PasswordCubit, bool>(
        builder: (context, isPasswordHidden) {
          return TextField(
            obscureText: isPasswordHidden,
            controller: _passC,
            decoration: InputDecoration(
              hintText: "Password",
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<PasswordCubit>().togglePasswordVisibility();
                },
                icon: Icon(
                  isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ).applyDefaults(
              Theme.of(context).inputDecorationTheme,
            ),
          );
        },
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not an Member?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpPage(),
              ),
            ),
            child: const Text(
              'Register Now',
            ),
          )
        ],
      ),
    );
  }
}
