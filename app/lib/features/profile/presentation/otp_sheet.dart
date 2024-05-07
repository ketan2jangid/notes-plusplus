import 'package:app/common/app_colors.dart';
import 'package:app/common/block_button.dart';
import 'package:app/common/common_input_field.dart';
import 'package:app/common/labels.dart';
import 'package:app/common/loader.dart';
import 'package:app/common/notify_user.dart';
import 'package:app/features/profile/presentation/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OtpVerifySheet extends StatefulWidget {
  const OtpVerifySheet({super.key});

  @override
  State<OtpVerifySheet> createState() => _OtpVerifySheetState();
}

class _OtpVerifySheetState extends State<OtpVerifySheet> {
  final ProfileController _profileController = ProfileController();
  late final TextEditingController _otpController;

  @override
  void initState() {
    super.initState();

    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 80),
      decoration: BoxDecoration(
        color: appBackgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Label(text: "Enter OTP below"),
          Text(
            "(Check your email, you should have received an email with OTP)",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade700,
            ),
          ),
          Gap(12),
          CommonInputField(controller: _otpController, type: FieldType.otp),
          Gap(16),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: BlockButton(
              onPressed: () async {
                showLoader(context);
                // TODO: Add state management for user profile

                final res =
                    await _profileController.verifyOtp(_otpController.text);
                // setState(() {});

                hideLoader(context);

                if (res.success) {
                  Navigator.pop(context);

                  notifyUser(context, "Email verified");
                  setState(() {});
                } else {
                  notifyUser(context, "Err:" + res.result);
                }

                // notifyUser(context, res.result);
              },
              text: 'Save',
            ),
          )
        ],
      ),
    );
  }
}
