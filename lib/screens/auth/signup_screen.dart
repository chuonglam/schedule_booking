import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/constants.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/screens/auth/auth_controller.dart';

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
                        Get.back();
                      },
                    ),
                  ),
                ),
                Text(
                  "Create an account",
                  style: AppStyles.bold.copyWith(fontSize: 24),
                ),
                const Spacer(),
              ],
            ),
            Text(
              "Welcome back, please enter your details",
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 16),
            GetX<AuthController>(
              builder: (authController) {
                if (authController.error != null) {
                  return Center(
                    child: Text(
                      authController.error!,
                      style: AppStyles.medium.copyWith(
                        color: kErrorColor,
                        fontSize: 12,
                        height: 1.2,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: "Username",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _displayNameController,
                decoration: const InputDecoration(
                  hintText: "Display name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
                obscureText: true,
                obscuringCharacter: "*",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Confirm password",
                ),
                obscureText: true,
                obscuringCharacter: "*",
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetX<AuthController>(
                  builder: (authController) {
                    return ElevatedButton(
                      child: authController.isLoading
                          ? const CupertinoActivityIndicator()
                          : const Text("Sign up"),
                      onPressed: () => _onSignUpPressed(authController),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSignUpPressed(AuthController authController) async {
    final String? username = _usernameController?.text.trim();
    final String? password = _passwordController?.text.trim();
    final String? confirmPassword = _confirmPasswordController?.text.trim();
    final String? displayName = _displayNameController?.text.trim();
    final String? email = _emailController?.text.trim();
    final bool isFormValid = authController.isFormValid(
      username: username,
      password: password,
      confirm: confirmPassword,
      displayName: displayName,
      email: email,
    );
    if (!isFormValid) {
      return;
    }
    await authController.signUp(
      username: username!,
      password: password!,
      displayName: displayName!,
      email: email!,
    );
    //todo: navigate if success
    // Get.offNamedUntil('$MainScreen', (route) => true);
  }
}
