import 'dart:developer';

import 'package:app/common/app_colors.dart';
import 'package:app/common/block_button.dart';
import 'package:app/common/loader.dart';
import 'package:app/common/new_note_sheet.dart';
import 'package:app/common/note_card.dart';
import 'package:app/common/notify_user.dart';
import 'package:app/features/profile/presentation/otp_sheet.dart';
import 'package:app/features/authentication/presentation/login_screen.dart';
import 'package:app/features/notes/presentation/notes_controller.dart';
import 'package:app/features/profile/presentation/profile_controller.dart';
import 'package:app/state_management/notes/notes_cubit.dart';
import 'package:app/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../domain/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List? notes;
  int selectedNote = -1;
  final ProfileController _profileController = ProfileController();

  @override
  void initState() {
    super.initState();

    log("home screen");
    getData();
  }

  getData() async {
    // notes = await NotesController().getAllNotes();
    if (LocalStorage.isUserVerified != true) return;

    final res = await context.read<NotesCubit>().getAllNotes();

    if (res.success) {
      log("got notes");
      setState(() {});
    } else {
      notifyUser(context, "Err:" + res.result);
    }

    // log(notes.toString());
  }

  @override
  Widget build(BuildContext context) {
    // final notesCubit = BlocProvider.of<NotesCubit>(context);
    final notesCubit = context.watch<NotesCubit>();

    // TODO: Add README.md file in root
    return Scaffold(
      key: scaffoldKey,
      endDrawer: NavigationDrawer(
        backgroundColor: appBackgroundColor,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey.shade400,
                    size: 64,
                  ),
                ),
                Text(
                  LocalStorage.userEmail!,
                  style: GoogleFonts.jost(
                    color: buttonWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            indent: 8,
            endIndent: 8,
          ),
          Column(
            children: [
              ListTile(
                onTap: () async {
                  showLoader(context);

                  notifyUser(context, "Logout successfully");

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false);

                  await Future.delayed(
                    Duration(milliseconds: 500),
                  );

                  await LocalStorage.clearData();
                  notesCubit.clear();

                  // hideLoader(context);
                },
                leading: Icon(
                  Icons.logout,
                  color: Colors.red.shade700,
                ),
                title: Text(
                  'Logout',
                  style: GoogleFonts.jost(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: LocalStorage.isUserVerified == false
          ? null
          : FloatingActionButton(
              backgroundColor: appBackgroundColor,
              onPressed: selectedNote == -1
                  ? () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: NoteEditSheet(),
                              ));
                    }
                  : () async {
                      showLoader(context);

                      final res = await context.read<NotesCubit>().deleteNote(
                          noteId: notesCubit.state[selectedNote].id!);

                      hideLoader(context);

                      setState(() {
                        selectedNote = -1;
                      });

                      notifyUser(context, res.result);
                    },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color: selectedNote == -1
                      ? Colors.grey.shade700
                      : Colors.red.shade700,
                ),
              ),
              child: Icon(
                selectedNote == -1 ? Icons.add : Icons.delete,
                color: selectedNote == -1 ? buttonWhite : Colors.red.shade700,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: appBackgroundColor,
              foregroundColor: appBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Notes++',
                  style: GoogleFonts.jost(
                    color: buttonWhite,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                titlePadding: const EdgeInsets.all(12),
                centerTitle: false,
              ),
              expandedHeight: 240,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () async {
                    scaffoldKey.currentState!.openEndDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            LocalStorage.isUserVerified == false
                ? SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock,
                            color: Colors.grey.shade400,
                            size: 64,
                          ),
                          Gap(12),
                          Text(
                            'Verify your email to use Notes++',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Gap(18),
                          BlockButton(
                            onPressed: () async {
                              showLoader(context);
                              final res = await _profileController
                                  .sendVerificationEmail();

                              hideLoader(context);
                              if (res.success == true) {
                                showModalBottomSheet(
                                  isDismissible: false,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: OtpVerifySheet(),
                                  ),
                                );
                              } else {
                                notifyUser(context, "Err:" + res.result);
                              }
                            },
                            text: 'Verify Email',
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.0,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 8 / 11),
                          itemCount: notesCubit.state.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (selectedNote == -1)
                                  // open sheet for editing
                                  ? () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => Padding(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: NoteEditSheet(
                                                  id: notesCubit
                                                      .state[index].id,
                                                  title: notesCubit
                                                      .state[index].title,
                                                  body: notesCubit
                                                      .state[index].body,
                                                ),
                                              ));
                                    }
                                  // deselect note
                                  : (selectedNote == index)
                                      ? () => setState(() {
                                            selectedNote = -1;
                                          })
                                      // select the taped note
                                      : () => setState(() {
                                            selectedNote = index;
                                          }),
                              onLongPress: () {
                                setState(() {
                                  selectedNote =
                                      (selectedNote == index) ? -1 : index;
                                });
                              },
                              child: NoteCard(
                                title: notesCubit.state[index].title!,
                                body: notesCubit.state[index].body!,
                                isSelected: (selectedNote == index),
                                counter: 0,
                              ),
                            );
                          }),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

// TODO: Load todos only for verified profile
// TODO: Keys for res body
