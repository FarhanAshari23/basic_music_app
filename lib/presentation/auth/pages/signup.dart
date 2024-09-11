import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/widgets/appbar/basic_appbar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';
import 'package:spotify/presentation/auth/pages/signin.dart';
import 'package:spotify/presentation/home/pages/home.dart';
import 'package:spotify/service_locator.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Column(
              children: [
                _registerText(),
                const SizedBox(height: 50),
                _nameTextField(context),
                const SizedBox(height: 20),
                _emailTextField(context),
                const SizedBox(height: 20),
                _passwordTextField(context),
                const SizedBox(height: 30),
                BasicAppButton(
                  onPressed: () async {
                    var result = await sl<SignUpUseCase>().call(
                      params: CreateUserReq(
                        fullName: _fullName.text.toString(),
                        email: _email.text.toString(),
                        passwword: _password.text.toString(),
                      ),
                    );
                    return result.fold(
                      (l) {
                        var snackbar = SnackBar(content: Text(l));
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
                  tittle: "Create Account",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _nameTextField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(
        hintText: "Full Name",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailTextField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: "Enter Email",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordTextField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
        hintText: "Password",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Already Have an Account?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignInPage(),
              ),
            ),
            child: const Text(
              'Sign In',
            ),
          )
        ],
      ),
    );
  }
}
