import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/note_model.dart';
import 'package:todo/providers/add_new_list_provider.dart';

class AddEditNewListNoteScreen extends StatefulWidget {
  static const String routeName = './AddingNewListNote';

  @override
  State<AddEditNewListNoteScreen> createState() =>
      _AddEditNewListNoteScreenState();
}

class _AddEditNewListNoteScreenState extends State<AddEditNewListNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> noteMap = {};
  bool isDidChangeActive = true;
  Map<String, String> _initialVal = {
    'title': '',
    'description': '',
  };
  Note _userNote = Note(
    noteDescription: '',
    noteID: DateTime.now().toString(),
    noteTitle: '',
    noteCategoryList: '',
  );

  @override
  void didChangeDependencies() {
    if (isDidChangeActive) {
      noteMap =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      if (noteMap.values.first == null) {
        // adding note
        _userNote = Note(
          noteDescription: '',
          noteID: DateTime.now().toString(),
          noteTitle: '',
          noteCategoryList: noteMap.keys.first,
        );
      } else {
        // editing note
        Note fetchedNote =
            Provider.of<AddNewListProvider>(context, listen: false)
                .getNoteByID(noteMap.keys.first , noteMap.values.first );

        _userNote = Note(
          noteDescription: '',
          noteID: fetchedNote.noteID,
          noteTitle: '',
          noteCategoryList: noteMap.keys.first,
        );
        _initialVal = {
          'title': fetchedNote.noteTitle,
          'description': fetchedNote.noteDescription,
        };
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text(
          noteMap.keys.first,
          style: Theme.of(context).appBarTheme.toolbarTextStyle,
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _formKey.currentState!.save();
            if (_userNote.noteTitle.isEmpty &&
                _userNote.noteDescription.isEmpty) {
              Navigator.of(context).pop(null);
            } else {
              Navigator.of(context).pop(_userNote);
            }
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                cursorHeight: 20,
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                style: TextStyle(color: Colors.white70, fontSize: 20),
                initialValue: _initialVal['title'],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: Theme.of(context).textTheme.headline5,
                ),
                onSaved: (value) {
                  _userNote.noteTitle = value as String;
                },
              ),
              TextFormField(
                cursorHeight: 17,
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                style: TextStyle(color: Colors.white70, fontSize: 17),
                initialValue: _initialVal['description'],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write down you\'r  ideas ',
                  hintStyle: Theme.of(context).textTheme.headline4,
                ),
                onSaved: (value) {
                  _userNote.noteDescription = value as String;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
