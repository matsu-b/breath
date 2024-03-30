import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test3_app/firebase_options.dart';
import 'package:test3_app/pages/accont_page.dart';
import 'package:test3_app/pages/all_page.dart';
import 'package:test3_app/pages/home_page.dart';
import 'package:test3_app/pages/journals/feelings_journal.dart';
import 'package:test3_app/pages/journals/free_journal.dart';
import 'package:test3_app/pages/journals/value_journal.dart';
import 'package:test3_app/pages/journals/words_journal.dart';
import 'package:test3_app/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // FirebaseAuthのインスタンスを取得
  final FirebaseAuth auth = FirebaseAuth.instance;

  // 現在のユーザーを取得
  final User? currentUser = auth.currentUser;

  // ユーザーがログインしているかどうかを確認
  final Widget firstPage = currentUser != null ? HomePage() : LoginPage();
  
  runApp(MyApp(firstPage: firstPage));
}

class MyApp extends StatelessWidget {
    final Widget firstPage;

    MyApp({required this.firstPage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: firstPage,
      routes: {
        '/home': (context) => const HomePage(),
        '/journey': (context) => const AllPage(
              title: 'Allpage',
            ),
        '/account': (context) => const AccountPage(),
        '/feelingjournal': (context) => const FeelingJournal(),
        '/wordsjournal': (context) => const WordsJournal(),
        '/valuejournal': (context) => const ValueJournal(),
        '/freejournal': (context) => const FreeJournal(),
      },
    );
  }
}

//ナビゲーションバーの共通部分ここから
class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavigationBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFF2F2F2),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.text_snippet),
          label: 'Journey',
        ),
                BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.black,
      onTap: onItemTapped,
    );
  }
}
//ナビゲーションバーの共通部分ここまで