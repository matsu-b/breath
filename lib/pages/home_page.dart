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
      appBar: AppBar(
        //AppBarは画面上部のバーを作成するウィジェット
        backgroundColor: Color(0xFFF2F2F2),
        title: const Text(
          'どんなブレス😮‍💨をしますか？',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false, //戻るボタンを非表示にする
      ),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[            
            GestureDetector(
            onTap: () {
              // タップされたときの動作をここに書く
              Navigator.pushNamed(context, '/feelingjournal');
            },
            child:Container(
              padding: EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '感情\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'feelings',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ), 
            ),
            GestureDetector(
            onTap: () {
              // タップされたときの動作をここに書く
              // 一旦jouerneyページに遷移するようにしている
              Navigator.pushNamed(context, '/wordsjournal');
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '言葉\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'words',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
            GestureDetector(
            onTap: () {
              // タップされたときの動作をここに書く
              Navigator.pushNamed(context, '/valuejournal');
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '大切なこと\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'precious',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
            GestureDetector(
            onTap: () {
              // タップされたときの動作をここに書く
              Navigator.pushNamed(context, '/freejournal');
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'フリー\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'free text',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              ),
            ),
            // 他のコンテナウィジェットを足すならここから
          ],
        ),
      ),
      //ナビゲーションバーを表示させるための実装
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
