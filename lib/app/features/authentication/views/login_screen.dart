import 'package:chatcord/app/common/components/widgets/common_button.dart';
import 'package:chatcord/app/common/components/widgets/common_text_field.dart';
import 'package:chatcord/app/common/dialogs/alert_dialog_model.dart';
import 'package:chatcord/app/common/dialogs/login_failure_dialog.dart';
import 'package:chatcord/app/features/authentication/repo/notifiers/auth_state_notifier.dart';
import 'package:chatcord/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({
    super.key,
    required this.toggleView,
  });

  final Function toggleView;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final loginformkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: loginformkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 80.0,
                    backgroundColor: Color(0xff2F4093),
                    child: Text(
                      'Foodie',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w600,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Login',
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '.',
                        style: TextStyle(
                            color: AppColor.secondaryColor,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  CommonTextField(
                    hintText: 'Enter your email',
                    fieldController: emailController,
                    validate: (val) {
                      if ((val!.isEmpty) ||
                          !(val.contains('@') && val.contains('.'))) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  CommonTextField(
                    hintText: 'Enter your password',
                    fieldController: passwordController,
                    isPassword: true,
                    validate: (val) {
                      if ((val!.isEmpty)) {
                        return 'Password so=hould nort be empty';
                      } else if (val.length <= 5) {
                        return 'Enter a strong password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30.0),
                  CommonButton(
                      buttonTitle: 'Login',
                      onPress: () async {
                        if (loginformkey.currentState!.validate()) {
                          final bool res = await ref
                              .read(authStateProvider.notifier)
                              .login(emailController.text.trim(),
                                  passwordController.text.trim());
                          if (res == false && mounted) {
                            await displayErrorDialog(context);
                          }
                        }
                      }),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member?',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () => widget.toggleView(),
                        child: const Text(
                          'Register now!',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff2F4093),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> displayErrorDialog(BuildContext context) {
    return const LoginFailureDialog().present(context);
  }
}
