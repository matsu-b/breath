import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test3_app/main.dart';
import 'package:flutter/widgets.dart';
import 'package:test3_app/pages/login.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _selectedIndex = 0;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/home');
          break;
        case 1:
          Navigator.pushNamed(context, '/journey');
          break;
        case 2:
          Navigator.pushNamed(context, '/accont');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Page'),
        backgroundColor: Color(0xFFF2F2F2),
        automaticallyImplyLeading: false, //戻るボタ
      ),
      body: Container(
        color: Color(0xFFF2F2F2), // 背景色を設定
        child: Center(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            onPressed: () async {
              // onPressedを非同期にする
              await signOut(); // signOutの結果を待つ
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()),
                  );
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white, // テキストの色を白に設定
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
