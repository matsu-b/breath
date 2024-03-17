// // 現状
// // 途中までしか記入できていない状態

// // 次やること
// // ログイン画面をトップページに持ってくる
// // ログイン画面を作成する
// // データベースに登録できるようにする

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:test3_app/firebase_options.dart';
// import 'package:test3_app/model/memo.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

// void main() {
//   runApp(Breath());
// }

// void checkUserStatus() {
//   FirebaseAuth.instance.userChanges().listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });
// }

// class Breath extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Breath',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Breath(
//         //ここに記述を書いていく
//       ), // ここでLoginPageをトップページに設定します
//     );
//   }
// }