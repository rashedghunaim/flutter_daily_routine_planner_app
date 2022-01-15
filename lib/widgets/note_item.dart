import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/note_model.dart';
import 'package:todo/providers/add_new_list_provider.dart';
import 'package:todo/screens/add_edit_new_list_note_screen.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  NoteItem({required this.note});

  @override
  Widget build(BuildContext context) {
    final _addNewListProvider = Provider.of<AddNewListProvider>(context);
    return InkWell(
      onTap: () async {
        final futureEditedNote = await Navigator.pushNamed(
          context,
          AddEditNewListNoteScreen.routeName,
          arguments: {note.noteCategoryList: note},
        );
        _addNewListProvider.updateNote(futureEditedNote as Note);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onError,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Text(
            note.noteTitle,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
