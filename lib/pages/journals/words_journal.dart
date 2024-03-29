import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test3_app/model/memo.dart';

class WordsJournal extends StatefulWidget {
  final Word? currentMemo;
  const WordsJournal({super.key, this.currentMemo});

  @override
  State<WordsJournal> createState() => _WordsJournalState();
}

class _WordsJournalState extends State<WordsJournal> {
  TextEditingController wordController =
      TextEditingController(); //入力された情報を管理するために必要
  TextEditingController wordReasonController =
      TextEditingController(); //入力された情報を管理するために必要
  TextEditingController wordTypeController =
      TextEditingController(); //入力された情報を管理するために必要

  String userId = ''; // ユーザーIDを保持するフィールドを追加

  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser; // Firebase Authから現在のユーザーを取得
    userId = user != null ? user.uid : ''; // ユーザーが存在すればそのIDを取得、存在しなければ空文字列を設定
  }

  Future<void> createMemo() async {
    final memoCollection =
        FirebaseFirestore.instance.collection('word_journals');
    await memoCollection.add({
      'word': wordController.text,
      'wordReason': wordReasonController.text,
      'wordType': wordTypeController.text,
      'createdDate': Timestamp.now(),
      'userid': userId, // ユーザーID
    });
  }

  //プルダウンメニューと値をDBに受け渡すための処理ここから
  List<String> dropdownItems = [
    '勇気づけられる',
    '励まされる',
    '困難を乗り越える',
    '希望を与える',
    '感動する',
    '幸せを感じる',
    '心温まる',
    '癒やしてくれる',
    '悲しみを和らげる',
    '不安を和らげる',
    '座右の銘',
    'その他',
  ];
  String? selectedDropdownItem;
  //プルダウンメニューと値をDBに受け渡すための処理ここまで

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
          title: const Text('言葉\nwords'),
        ),
        body: Container(
          color: Color(0xFFF2F2F2), // 背景色を設定
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                //セクション1️⃣ここから
                const Text('印象に残ったことばを書いてください。',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8, //幅を80%にする
                    child: TextField(
                      controller: wordController,
                      maxLines: null, // Enable multiline input
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Start writting...',
                          contentPadding: EdgeInsets.only(left: 10)),
                    )),
                //セクション1️⃣ここまで

                const SizedBox(height: 60),

                //セクション2️⃣ここから
                const Text('なぜ、その言葉が印象に残ったのですか？',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8, //幅を80%にする
                    child: TextField(
                      controller: wordReasonController,
                      maxLines: null, // Enable multiline input
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Start writting...',
                          contentPadding: EdgeInsets.only(left: 10)),
                    )),
                //セクション2️⃣ここまで

                const SizedBox(height: 60),

                //セクション3️⃣ここから
                const Text('その言葉は自分にとってどんな言葉ですか？',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8, //幅を80%にする
                  child: DropdownButton<String>(
                    value: selectedDropdownItem,
                    isExpanded: true,
                    hint: const Text('Select an option'),
                    items: dropdownItems.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDropdownItem = newValue;
                        wordTypeController.text = newValue ?? '';
                      });
                    },
                  ),
                ),
                //セクション3️⃣ここまで

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
