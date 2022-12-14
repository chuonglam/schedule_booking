import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/models/login_params.dart';
import 'package:schedule_booking/screens/auth/auth_controller.dart';
import 'package:schedule_booking/screens/auth/signup_screen.dart';
import 'package:schedule_booking/screens/main/main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.topCenter,
        child: const _LoginForm(),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  TextEditingController? _usernameController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 350),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      Get.offNamedUntil('/$MainScreen', (route) => true);
                    },
                  ),
                ),
              ),
              Text(
                "Login",
                style: AppStyles.bold.copyWith(fontSize: 24),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "Welcome back, please enter your details",
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: "Username",
                prefixIcon: Icon(Icons.abc),
              ),
            ),
          ),
          GetBuilder<AuthController>(builder: (authController) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.password),
                ),
                onSubmitted: (value) {
                  _onLoginPressed(authController);
                },
                obscureText: true,
                obscuringCharacter: '*',
              ),
            );
          }),
          const SizedBox(height: 16),
          Row(
            children: [
              const Spacer(),
              GetX<AuthController>(builder: (authController) {
                return ElevatedButton(
                  onPressed: authController.isLoading
                      ? null
                      : () {
                          _onLoginPressed(authController);
                        },
                  child: const Text("Login"),
                );
              }),
              Expanded(
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed('/$SignupScreen');
                    },
                    child: const Text("Sign up"),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GetX<AuthController>(
            builder: (authController) {
              if (authController.error != null) {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    authController.error!,
                    textAlign: TextAlign.center,
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
        ],
      ),
    );
  }

  void _onLoginPressed(AuthController authController) async {
    final params = LoginParams(
      username: _usernameController?.text ?? '',
      password: _passwordController?.text ?? '',
    );
    final bool isFormValid = authController.isFormValid(params);
    if (!isFormValid) {
      return;
    }
    final bool success = await authController.login(
      username: params.username!,
      password: params.password!,
    );
    if (!success) {
      return;
    }
    Get.offNamedUntil('/$MainScreen', (route) => true);
  }
}
