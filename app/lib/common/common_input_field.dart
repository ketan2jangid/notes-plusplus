import 'package:app/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum FieldType { email, password, title, body }

class CommonInputField extends StatefulWidget {
  final FieldType type;
  final TextEditingController? controller;
  final Function()? onEditingComplete;
  final FocusNode? focusNode;
  bool isPassword;

  CommonInputField(
      {super.key,
      this.isPassword = false,
      this.controller,
      required this.type,
      this.onEditingComplete,
      this.focusNode});

  @override
  State<CommonInputField> createState() => _CommonInputFieldState();
}

class _CommonInputFieldState extends State<CommonInputField> {
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      // email
      case FieldType.email:
        return TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          obscureText: widget.isPassword,
          cursorColor: buttonWhite,
          cursorErrorColor: Colors.red.shade700,
          validator: (val) {
            //  TODO: Add email validation
            if (val == null || val.isEmpty) {
              return "Email can't be empty";
            }

            return null;
          },
          onEditingComplete: widget.onEditingComplete,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            enabledBorder: formEnabledBorder,
            focusedBorder: formFocusBorder,
            disabledBorder: formEnabledBorder,
            focusedErrorBorder: formErrorBorder,
            errorBorder: formErrorBorder,
            errorStyle: GoogleFonts.spaceMono(
              color: Colors.red.shade700,
              fontSize: 12,
            ),
          ),
        );

      // password
      case FieldType.password:
        return TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          obscureText: widget.isPassword,
          cursorColor: buttonWhite,
          cursorErrorColor: Colors.red.shade700,
          validator: (val) {
            if (widget.isPassword && (val == null || val.length < 6)) {
              return "Password must be atleast 6 characters long";
            }

            return null;
          },
          onEditingComplete: widget.onEditingComplete,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  widget.isPassword = !widget.isPassword;
                });
              },
              icon: widget.isPassword
                  ? Icon(
                      Icons.remove_red_eye_outlined,
                      color: infoGrey,
                    )
                  : Icon(
                      Icons.remove_red_eye,
                      color: infoGrey,
                    ),
            ),
            enabledBorder: formEnabledBorder,
            focusedBorder: formFocusBorder,
            disabledBorder: formEnabledBorder,
            focusedErrorBorder: formErrorBorder,
            errorBorder: formErrorBorder,
            errorStyle: GoogleFonts.spaceMono(
              color: Colors.red.shade700,
              fontSize: 12,
            ),
          ),
        );

      // notes title
      case FieldType.title:
        return TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          obscureText: widget.isPassword,
          cursorColor: buttonWhite,
          cursorErrorColor: Colors.red.shade700,
          validator: (val) {
            return null;
          },
          onEditingComplete: widget.onEditingComplete,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              enabledBorder: inputEnabledBorder,
              focusedBorder: inputFocusBorder,
              errorBorder: inputErrorBorder,
              errorStyle: GoogleFonts.spaceMono(
                color: Colors.red.shade700,
                fontSize: 12,
              ),
              hintText: 'Note title'),
        );

      // notes body
      case FieldType.body:
        return TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          obscureText: widget.isPassword,
          cursorColor: buttonWhite,
          cursorErrorColor: Colors.red.shade700,
          validator: (val) {
            return null;
          },
          onEditingComplete: widget.onEditingComplete,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              enabledBorder: inputEnabledBorder,
              focusedBorder: inputFocusBorder,
              errorBorder: inputErrorBorder,
              errorStyle: GoogleFonts.spaceMono(
                color: Colors.red.shade700,
                fontSize: 12,
              ),
              hintText: 'Note body'),
          minLines: 3,
          maxLines: 10,
        );
    }
  }
}

// signin/signup styles

final formEnabledBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey.shade700,
    width: 2.0,
  ),
  borderRadius: BorderRadius.circular(8),
);

final formFocusBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey.shade400,
    width: 2.0,
  ),
  borderRadius: BorderRadius.circular(8),
);

final formErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.red.shade700,
    width: 2.0,
  ),
  borderRadius: BorderRadius.circular(8),
);

// notes edit styles

final inputEnabledBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey.shade800,
    width: 2.0,
  ),
  borderRadius: BorderRadius.circular(8),
);

final inputFocusBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey.shade800,
    width: 2.0,
  ),
  borderRadius: BorderRadius.circular(8),
);

final inputErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.red.shade700,
    width: 2.0,
  ),
  borderRadius: BorderRadius.circular(8),
);
