import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test3_app/main.dart';

class FeelingJournal extends StatefulWidget {
  const FeelingJournal({super.key});

  @override
  State<FeelingJournal> createState() => _FeelingJournalState();
}

class _FeelingJournalState extends State<FeelingJournal> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One'; // デフォルトのドロップダウンリストの値

    return Scaffold(
      appBar: AppBar(
        //AppBarは画面上部のバーを作成するウィジェット
        backgroundColor: Color(0xFFF2F2F2),
        title: const Text('感情\nFeeling'),
      ),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter your feelings...',
              ),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue ?? '';
                });
              },
              items: <String>['One', 'Two', 'Three', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}