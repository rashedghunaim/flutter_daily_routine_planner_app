import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/assets/icons/v_v_icons.dart';
import 'package:todo/models/note_model.dart';
import 'package:todo/providers/add_new_list_provider.dart';
import 'package:todo/screens/add_edit_new_list_note_screen.dart';
import 'package:todo/widgets/note_item.dart';
import 'package:todo/widgets/notes_expansion_panel.dart';

class UserNewListNotesScreen extends StatelessWidget {
  final String noteListName;

  UserNewListNotesScreen(this.noteListName);

  static const String routeName = './userNewListNoteScreen';

  @override
  Widget build(BuildContext context) {
    Note note = Note(
      noteDescription: '',
      noteID: DateTime.now().toString(),
      noteTitle: '',
      noteCategoryList: 'noteCategoryList',
    );
    final _addNewListProvider = Provider.of<AddNewListProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: NotesExpantionPanel(
          notes: _addNewListProvider
              .getUserLists[_addNewListProvider.getRouteKey]!.listOfNotes,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final futureNote = await Navigator.pushNamed(
            context,
            AddEditNewListNoteScreen.routeName,
            arguments: {noteListName: null},
          );

          if (futureNote != null) {
            _addNewListProvider.addNewNote(futureNote as Note);
          }
        },
        child: Icon(VV.mode_edit),
      ),
    );
  }
}
