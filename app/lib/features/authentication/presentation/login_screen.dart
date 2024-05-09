import 'dart:developer';

import 'package:app/common/app_colors.dart';
import 'package:app/common/block_button.dart';
import 'package:app/common/common_input_field.dart';
import 'package:app/common/labels.dart';
import 'package:app/common/loader.dart';
import 'package:app/common/notify_user.dart';
import 'package:app/features/authentication/presentation/auth_controller.dart';
import 'package:app/features/authentication/presentation/registration_screen.dart';
import 'package:app/features/notes/presentation/home_screen.dart';
import 'package:app/state_management/notes/notes_cubit.dart';
import 'package:app/storage/local_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
                Colors.cyan.shade900.withOpacity(0.7),
                Colors.black,
              ],
            ),
          ),
          child: Column(
            children: [
              Flexible(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Notes++',
                    style: GoogleFonts.jost(
                      color: buttonWhite,
                      fontSize: 48,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Label(text: 'Email'),
                          Gap(6),
                          CommonInputField(
                            controller: _emailController,
                            type: FieldType.email,
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          Gap(12),
                          Label(text: 'Password'),
                          Gap(6),
                          CommonInputField(
                            controller: _passwordController,
                            isPassword: true,
                            type: FieldType.password,
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          Gap(12),
                          Center(
                            child: BlockButton(
                              onPressed: () async {
                                // log("button pressed");

                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                showLoader(context);

                                final res = await AuthController().loginUser(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );

                                // log("***** " + res + " *****");

                                hideLoader(context);
                                if (res.success == true) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                      (route) => false);

                                  notifyUser(context, "Login successful");
                                } else {
                                  notifyUser(context, "Err:" + res.result);
                                }
                              },
                              text: 'Login',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(12),
                    Center(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: GoogleFonts.jost(
                              color: buttonWhite,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: "Register",
                            style: GoogleFonts.jost(
                              color: buttonWhite,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(),
                                    ),
                                  ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
