import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test3_app/model/memo.dart';

class ValueJournal extends StatefulWidget {
  final Value? currentMemo;
  const ValueJournal({super.key, this.currentMemo});

  @override
  State<ValueJournal> createState() => _ValueJournalState();
}

class _ValueJournalState extends State<ValueJournal> {
  TextEditingController valueContentController =
      TextEditingController(); //入力された情報を管理するために必要
  TextEditingController valueReasonController =
      TextEditingController(); //入力された情報を管理するために必要
  TextEditingController valueSubjectController =
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
        FirebaseFirestore.instance.collection('value_journals');
    await memoCollection.add({
      'valueContent': valueContentController.text,
      'valueReason': valueReasonController.text,
      'valueSubject': valueSubjectController.text,
      'createdDate': Timestamp.now(),
      'userid': userId, // ユーザーID
    });
  }

  List<String> dropdownItems = [
    '自分',
    '生活',
    '友達',
    '家族',
    'ペット',
    '仕事',
    '勉強',
    'お金',
    '恋愛',
    '家事',
    '健康',
    '転職/就職',
    '食',
    '本',
    '音楽',
    '旅行',
    '美容',
    'スポーツ',
    'お酒',
    '学校',
    'その他',
  ];
  String? selectedDropdownItem;

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
          title: const Text('大切なこと\nprecious'),
        ),
        body: Container(
          color: Color(0xFFF2F2F2), // 背景色を設定
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                //セクション1️⃣ここから
                const Text('自分にとって大切なことはなんですか？',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8, //幅を80%にする
                    child: TextField(
                      controller: valueContentController,
                      maxLines: null, // Enable multiline input
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Start writting...',
                          contentPadding: EdgeInsets.only(left: 10)),
                    )),
                //セクション1️⃣ここまで

                const SizedBox(height: 60),

                //セクション2️⃣ここから
                const Text('なぜ自分はそれを大切にしたいのですか？',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8, //幅を80%にする
                    child: TextField(
                      controller: valueReasonController,
                      maxLines: null, // Enable multiline input
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Start writting...',
                          contentPadding: EdgeInsets.only(left: 10)),
                    )),
                //セクション2️⃣ここまで

                const SizedBox(height: 60),

                //セクション3️⃣ここから
                const Text('その内容は何と関係していますか？',
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
                        valueSubjectController.text = newValue ?? '';
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
