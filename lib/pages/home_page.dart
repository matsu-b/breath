import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test3_app/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //ナビゲーションを表示させるための実装ここから
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    //indexが番号が同じ場合はページ遷移をさせない処理
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    
    //indexが番号が同じでない場合は特定のページに遷移させる処理
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/journey');
        break;
      }
    }
  }
  //ナビゲーションを表示させるための実装ここまで

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(//AppBarは画面上部のバーを作成するウィジェット
        backgroundColor: Colors.white,
        title: const Text('どんなブレス😮‍💨をしますか？'),
        automaticallyImplyLeading: false, //戻るボタンを非表示にする
      ),
      body: Container(
        color: Colors.white,
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
                child: const Text("感情\nfeelings"),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: const Text('言葉\nwords'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: const Text('大切なこと\nprecious'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: const Text('フリー\nfree text'),
            ),
          ],
        ),
      ),  
      bottomNavigationBar: CustomNavigationBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
      ),
    );
  }
}