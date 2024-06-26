import 'dart:developer';

import 'package:app/common/app_colors.dart';
import 'package:app/common/block_button.dart';
import 'package:app/common/common_input_field.dart';
import 'package:app/common/loader.dart';
import 'package:app/common/notify_user.dart';
import 'package:app/features/notes/presentation/notes_controller.dart';
import 'package:app/state_management/notes/notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'alerts.dart';
import 'check_internet.dart';

class NoteEditSheet extends StatefulWidget {
  String? title;
  String? body;
  String? id;

  NoteEditSheet({super.key, this.id, this.title, this.body});

  @override
  State<NoteEditSheet> createState() => _NoteEditSheetState();
}

class _NoteEditSheetState extends State<NoteEditSheet> {
  bool isUpdated = false;
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController();
    _bodyController = TextEditingController();

    if (widget.id != null) {
      _titleController.text = widget.title!;
      _bodyController.text = widget.body!;
    }
  }

  @override
  void dispose() {
    super.dispose();

    _titleController.dispose();
    _bodyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: appBackgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          CommonInputField(controller: _titleController, type: FieldType.title),
          Gap(12),
          ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 180),
              child: CommonInputField(
                  controller: _bodyController, type: FieldType.body)),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: BlockButton(
              onPressed: () async {
                if (((widget.title != null &&
                        widget.title == _titleController.text.trim())) &&
                    (widget.body != null &&
                        widget.body == _bodyController.text.trim())) {
                  Navigator.pop(context);

                  return;
                }

                final bool con = await isConnected();
                log("Connected: $con");

                if (!con) {
                  return showDialog(
                      context: context,
                      builder: (context) => noConnectionDialog());
                }

                showLoader(context);

                final ({String result, bool success}) res;
                if (widget.id == null) {
                  res = await context.read<NotesCubit>().addNote(
                        title: _titleController.text.trim(),
                        body: _bodyController.text.trim(),
                      );
                } else {
                  res = await context.read<NotesCubit>().updateNote(
                        noteId: widget.id!,
                        title: _titleController.text.trim(),
                        body: _bodyController.text.trim(),
                      );
                }
                hideLoader(context);
                Navigator.pop(context);

                if (res.success == true) {
                  notifyUser(context, res.result);
                } else {
                  notifyUser(context, "Err:" + res.result);
                }

                setState(() {});
              },
              text: 'Save',
            ),
          )
        ],
      ),
    );
  }
}
