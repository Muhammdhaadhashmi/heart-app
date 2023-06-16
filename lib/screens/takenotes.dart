

import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<String> notes = [];

  TextEditingController _noteController = TextEditingController();
  bool isSidebarOpen = false;
  String selectedNote = '';

  void _addNote() {
    setState(() {
      String note = _noteController.text.trim();
      if (note.isNotEmpty) {
        notes.add(note);
        _noteController.clear();
      }
    });
  }

  void toggleSidebar() {
    setState(() {
      isSidebarOpen = !isSidebarOpen;
    });
  }

  void selectNote(String note) {
    setState(() {
      selectedNote = note;
    });
  }

  void deleteNote() {
    setState(() {
      notes.remove(selectedNote);
      selectedNote = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [
    hexStringToColor("4cb4d5"),
    hexStringToColor("52afff"),
    hexStringToColor("3282d4"),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    ),
    ),
    child: Stack(
    children: [
    Positioned(
    left: isSidebarOpen ? 0 : -200,
    top: 0,
    bottom: 0,
    width: 200,
    child: Container(
    color: Colors.white,
    child: Column(
    children: [
    Container(
    padding: EdgeInsets.all(16),
    child: Text(
    'Notes',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
    ),
    ),
    Expanded(
    child: ListView.builder(
    itemCount: notes.length,
    itemBuilder: (context, index) {
    return ListTile(
    title: Text(notes[index]),
    onTap: () => selectNote(notes[index]),
    );
    },
    ),
    ),
    ],
    ),
    ),
    ),
    AnimatedPositioned(
    left: isSidebarOpen ? 200 : 0,
    top: 0,
    bottom: 0,
    right: 0,
    duration: Duration(milliseconds: 200),
    child: Container(
    padding: EdgeInsets.all(16),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    Container(
    padding: EdgeInsets.all(16),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Container(
    width: 50,
    height: 50,
    child: logoWidget("assets/images/logo2.png"),
    ),
    Text(
    'Notes',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),
    ),
    IconButton(
    icon: Icon(Icons.menu),
    onPressed: toggleSidebar,
    color: Colors.white,
    ),
    ],
    ),
    ),
    Expanded(
    child: Container(
    color: Colors.white,
    child: selectedNote.isNotEmpty
    ? SingleChildScrollView(
    child: Padding(
    padding: EdgeInsets.all(16),
    child: Text(
    selectedNote,
    style: TextStyle(fontSize: 16),
    ),
    ),
    )
        : TextField(
    controller:_noteController,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: 'Write your note',
        contentPadding: EdgeInsets.all(16),
        border: InputBorder.none,
      ),
    ),
    ),
    ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _addNote,
          child: Text('Save Note'),
        ),
        if (selectedNote.isNotEmpty) ...[
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: deleteNote,
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: Text('Delete Note'),
        ),
      ],
    ],
    ),
    ),
    ),
    ],
    ),
        ),
    );
  }

  Widget logoWidget(String imagePath) {
    return Image.asset(
      imagePath,
      fit: BoxFit.contain,
    );
  }

  Color hexStringToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
