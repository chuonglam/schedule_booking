import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:common/src/constants.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/models/signup_params.dart';
import 'package:schedule_booking/screens/auth/login_screen.dart';
import 'package:schedule_booking/screens/auth/signup_controller.dart';
import 'package:schedule_booking/screens/main/main_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.topCenter,
        child: _SignupForm(),
      ),
    );
  }
}

class _SignupForm extends StatefulWidget {
  @override
  State<_SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<_SignupForm> {
  GlobalKey<FormState>? _formKey;
  TextEditingController? _usernameController;
  TextEditingController? _displayNameController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _usernameController = TextEditingController();
    _displayNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController?.dispose();
    _displayNameController?.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    _confirmPasswordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Get.offNamedUntil('/$LoginScreen', (route) => false);
                      },
                    ),
                  ),
                ),
                Text(
                  "Create an account",
                  style: AppStyles.bold.copyWith(fontSize: 24),
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      Get.offNamedUntil('/$MainScreen', (route) => true);
                    },
                  ),
                )),
              ],
            ),
            Text(
              "Welcome, please enter your details",
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: "Username",
                  prefixIcon: Icon(Icons.abc),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _displayNameController,
                decoration: const InputDecoration(
                  hintText: "Display name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.password),
                ),
                obscureText: true,
                obscuringCharacter: "*",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  hintText: "Confirm password",
                  prefixIcon: Icon(Icons.password),
                ),
                obscureText: true,
                obscuringCharacter: "*",
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetX<SignUpController>(
                  builder: (signUpController) {
                    return ElevatedButton(
                      onPressed: signUpController.isLoading
                          ? null
                          : () => _onSignUpPressed(signUpController),
                      child: const Text("Sign up"),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetX<SignUpController>(
                  builder: (signUpController) {
                    if (signUpController.error != null) {
                      return Text(
                        signUpController.error!,
                        textAlign: TextAlign.center,
                        style: AppStyles.medium.copyWith(
                          color: kErrorColor,
                          fontSize: 12,
                          height: 1.2,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSignUpPressed(SignUpController signUpController) async {
    final SignUpParams params = SignUpParams(
      username: _usernameController?.text.trim(),
      password: _passwordController?.text.trim(),
      confirmPassword: _confirmPasswordController?.text.trim(),
      displayName: _displayNameController?.text.trim(),
      email: _emailController?.text.trim(),
    );
    final bool isFormValid = signUpController.isFormValid(params);
    if (!isFormValid) {
      return;
    }
    final success = await signUpController.signUp(
      username: params.username!,
      password: params.password!,
      displayName: params.displayName!,
      email: params.email!,
    );
    if (!success) {
      return;
    }
    Get.offNamedUntil('/$LoginScreen', (route) => false);
  }
}
