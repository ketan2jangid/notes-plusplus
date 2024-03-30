import 'dart:developer';

import 'package:app/common/app_colors.dart';
import 'package:app/common/loader.dart';
import 'package:app/common/new_note_sheet.dart';
import 'package:app/common/note_card.dart';
import 'package:app/common/notify_user.dart';
import 'package:app/features/authentication/presentation/login_screen.dart';
import 'package:app/features/notes/presentation/notes_controller.dart';
import 'package:app/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List? notes;
  int selectedNote = -1;

  @override
  void initState() {
    super.initState();

    log("home screen");
    getData();
  }

  getData() async {
    notes = await NotesController().getAllNotes();

    log("got notes");
    log(notes.toString());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                  await LocalStorage.clearData();

                  hideLoader(context);

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false);
                },
                leading: Icon(
                  Icons.logout,
                  color: Colors.red.shade700,
                ),
                title: Text(
                  'logout',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: appBackgroundColor,
        onPressed: selectedNote == -1
            ? () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: NoteEditSheet(),
                        ));
              }
            : () => setState(() {
                  selectedNote = -1;
                }),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.grey.shade700)),
        child: Icon(
          selectedNote == -1 ? Icons.add : Icons.close,
          color: buttonWhite,
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
            SliverToBoxAdapter(
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
                    itemCount: notes?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (selectedNote != index)
                            ? () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: NoteEditSheet(
                                            id: notes![index]['_id'],
                                            title: notes![index]['title'],
                                            body: notes![index]['body'],
                                          ),
                                        ));
                              }
                            : () async {
                                showLoader(context);
                                // log('note will be deleted ' + notes![index]['title']);

                                final res = await NotesController()
                                    .deleteNote(noteId: notes![index]['_id']);

                                hideLoader(context);

                                setState(() {
                                  selectedNote = -1;
                                });

                                notifyUser(context, res);
                              },
                        onLongPress: () {
                          setState(() {
                            selectedNote = (selectedNote == index) ? -1 : index;
                          });
                        },
                        child: NoteCard(
                          title: notes?[index]['title'] ?? "title",
                          body: notes?[index]['body'] ?? "body",
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
