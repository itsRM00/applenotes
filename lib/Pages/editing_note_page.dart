import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../Model/note.dart';
import '../Model/note_data.dart';

class EditingNotePage extends StatefulWidget {
  final Note note;
  final bool isNewNote;
  const EditingNotePage(
      {super.key, required this.note, required this.isNewNote});

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }

  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
          document: doc, selection: TextSelection.collapsed(offset: 0));
    });
  }
  void addNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).addNewNote(Note(id: id,text: text,));
  }
  void updateNote() {
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.isNewNote && !_controller.document.isEmpty()) {
              addNewNote();
            } else {
              updateNote();
            }
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          QuillSimpleToolbar(
            controller: _controller,
            configurations: QuillSimpleToolbarConfigurations(
              showAlignmentButtons: false,
              showBackgroundColorButton: false,
              showBoldButton: false,
              showCenterAlignment: false,
              showClearFormat: false,
              showClipboardCopy: false,
              showClipboardCut: false,
              showClipboardPaste: false,
              showCodeBlock: false,
              showColorButton: false,
              showDirection: false,
              showDividers: false,
              showFontFamily: false,
              showFontSize: false,
              showHeaderStyle: false,
              showIndent: false,
              showInlineCode: false,
              showItalicButton: false,
              showJustifyAlignment: false,
              showLeftAlignment: false,
              showLineHeightButton: false,
              showLink: false,
              showListBullets: false,
              showListCheck: false,
              showListNumbers: false,
              showQuote: false,
              showRedo: true,
              showRightAlignment: false,
              showSearchButton: false,
              showSmallButton: false,
              showStrikeThrough: false,
              showSubscript: false,
              showSuperscript: false,
              showUnderLineButton: false,
              showUndo: true,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                child: QuillEditor.basic(
                  controller: _controller,
                  configurations:
                  const QuillEditorConfigurations(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
