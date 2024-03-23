import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test3_app/main.dart';

class PreciousJournal extends StatefulWidget {
  const PreciousJournal({super.key});

  @override
  State<PreciousJournal> createState() => _PreciousJournalState();
}

class _PreciousJournalState extends State<PreciousJournal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //AppBarは画面上部のバーを作成するウィジェット
        backgroundColor: Color(0xFFF2F2F2),
        title: const Text('大切なこと\nprecious'),
      ),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Enter your xxx...',
          ),
        ),
      ),
    );
  }
}
