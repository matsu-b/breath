import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test3_app/model/memo.dart';

class FreeJournal extends StatefulWidget {
  final Free? currentMemo;
  const FreeJournal({super.key, this.currentMemo});

  @override
  State<FreeJournal> createState() => _FreeJournalState();
}

class _FreeJournalState extends State<FreeJournal> {
  TextEditingController freeTitleController =
      TextEditingController(); //入力された情報を管理するために必要
  TextEditingController freeContentController =
      TextEditingController(); //入力された情報を管理するために必要

  String userId = ''; // ユーザーIDを保持するフィールドを追加

  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser; // Firebase Authから現在のユーザーを取得
    userId = user != null ? user.uid : ''; // ユーザーが存在すればそのIDを取得、存在しなければ空文字列を設定
  }

  Future<void> createMemo() async {
    final freeJournalCollection =
        FirebaseFirestore.instance.collection('free_journals');
    await freeJournalCollection.add({
      'freeTitle': freeTitleController.text,
      'freeContent': freeContentController.text,
      'createdDate': Timestamp.now(),
      'userid': userId, // ユーザーID
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          // title: Text(widget.currentMemo == null ? 'メモ追加' : 'メモ編集')
          backgroundColor: Color(0xFFF2F2F2),
          title: const Text('フリー\nfree'),
        ),
        body: Container(
          color: Color(0xFFF2F2F2), // 背景色を設定
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text('感じていることを思いのままに書いてください。',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8, //幅を80%にする
                    height: 100,
                    child: TextField(
                      controller: freeContentController,
                      maxLines: null, // Enable multiline input
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Start writting...',
                          contentPadding: EdgeInsets.only(left: 10)),
                    )),
                const SizedBox(height: 100),
                const Text('このブレスにタイトルを付けるとしたら何ですか？',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8, //幅を80%にする
                    child: TextField(
                      controller: freeTitleController,
                      maxLines: null, // Enable multiline input
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Start writting...',
                          contentPadding: EdgeInsets.only(left: 10)),
                    )),
                const SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8, //幅を80%にする
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      //メモをDBに登録する処
                      if (widget.currentMemo == null) {
                        await createMemo();
                      }
                      Navigator.pop(context); //一番上のレイヤーの画面と取り除くというような処理
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.black)), // ボタンの背景色を黒に設定
                    child: Text(widget.currentMemo == null ? '追加' : '更新',
                        style: TextStyle(color: Colors.white)), // テキストの色を白に設定
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
