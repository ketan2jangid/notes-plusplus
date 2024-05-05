import 'dart:developer';

import 'package:app/common/app_colors.dart';
import 'package:app/common/block_button.dart';
import 'package:app/common/common_input_field.dart';
import 'package:app/common/labels.dart';
import 'package:app/common/loader.dart';
import 'package:app/common/notify_user.dart';
import 'package:app/features/authentication/presentation/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                Colors.pink.shade900.withOpacity(0.7),
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
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Label(text: 'Email'),
                            const Gap(6),
                            CommonInputField(
                              controller: _emailController,
                              type: FieldType.email,
                            ),
                            const Gap(12),
                            const Label(text: 'Password'),
                            const Gap(6),
                            CommonInputField(
                              controller: _passwordController,
                              isPassword: true,
                              type: FieldType.password,
                            ),
                            const Gap(12),
                            Center(
                              child: BlockButton(
                                onPressed: () async {
                                  log("button pressed");

                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }

                                  showLoader(context);

                                  // await Future.delayed(Duration(seconds: 2));

                                  final res = await AuthController()
                                      .registerUser(
                                          email: _emailController.text,
                                          password: _passwordController.text);

                                  notifyUser(context, res);

                                  hideLoader(context);
                                },
                                text: 'Register',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(12),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Already have an account? ",
                            style: GoogleFonts.jost(
                              color: buttonWhite,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                              text: "Login",
                              style: GoogleFonts.jost(
                                color: buttonWhite,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pop(context)),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
