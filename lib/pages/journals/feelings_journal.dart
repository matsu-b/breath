import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test3_app/model/memo.dart';

class FeelingJournal extends StatefulWidget {
  // StatefulWidgetを継承したFeelingJournalクラス
  final Feel? currentMemo; // 現在のメモを保持するフィールド
  const FeelingJournal({super.key, this.currentMemo}); // コンストラクタ

  @override
  State<FeelingJournal> createState() =>
      _FeelingJournalState(); // 状態を管理するStateオブジェクトを生成
}

class _FeelingJournalState extends State<FeelingJournal> {
  // Stateクラスを継承した_FeelingJournalStateクラス
  TextEditingController feelTypeController =
      TextEditingController(); // 感情の種類を入力するテキストフィールドのコントローラ
  TextEditingController feelReasonController =
      TextEditingController(); // 感情の理由を入力するテキストフィールドのコントローラ
  TextEditingController feelAdviceController =
      TextEditingController(); // アドバイスを入力するテキストフィールドのコントローラ

  String userId = ''; // ユーザーIDを保持するフィールドを追加

  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser; // Firebase Authから現在のユーザーを取得
    userId = user != null ? user.uid : ''; // ユーザーが存在すればそのIDを取得、存在しなければ空文字列を設定
  }

  Future<void> createMemo() async {
    // メモを作成する非同期関数
    final memoCollection = FirebaseFirestore.instance
        .collection('feel_journals'); // Firestoreのfeel_journalsコレクションへの参照を取得
    await memoCollection.add({
      // コレクションに新しいドキュメントを追加
      'feelType': feelTypeController.text, // 感情の種類
      'feelReason': feelReasonController.text, // 感情の理由
      'feelAdvice': feelAdviceController.text, // アドバイス
      'createdDate': Timestamp.now(), // 作成日時
      'userid': userId, // ユーザーID
    });
  }

  //プルダウンメニューと値をDBに受け渡すための処理ここから
  List<String> dropdownItems = [
    // ドロップダウンメニューの項目
    '満足',
    '感謝',
    '嬉しい',
    'ワクワク',
    '好き',
    '感心',
    '面白い',
    '楽しい',
    'スッキリ',
    'ドキドキ',
    '安心',
    '穏やか',
    '普通',
    '退屈',
    'モヤモヤ',
    '緊張',
    '不安',
    '悲しい',
    '疲れた',
    '後悔',
    '恐れ',
    'イライラ',
    '怒り',
    '嫌い',
    'その他',
  ];
  String? selectedDropdownItem; // 選択されたドロップダウンメニューの項目を保持するフィールド
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
          title: const Text('感情\nfeelings'),
        ),
        body: Container(
          color: Color(0xFFF2F2F2), // 背景色を設定
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                //セクション1️⃣ここから
                const Text('今の感情を選択してください。',
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
                        feelAdviceController.text = newValue ?? '';
                      });
                    },
                  ),
                ),
                //セクション1️⃣ここまで

                const SizedBox(height: 60),

                //セクション2️⃣ここから
                const Text('その感情が生まれたのはなぜですか？',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8, //幅を80%にする
                    child: TextField(
                      controller: feelTypeController,
                      maxLines: null, // Enable multiline input
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Start writting...',
                          contentPadding: EdgeInsets.only(left: 10)),
                    )),
                //セクション2️⃣ここまで

                const SizedBox(height: 60),

                //セクション3️⃣ここから
                const Text('過去又は未来の自分にどんなアドバイスを送りますか？',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8, //幅を80%にする
                    child: TextField(
                      controller: feelReasonController,
                      maxLines: null, // Enable multiline input
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Start writting...',
                          contentPadding: EdgeInsets.only(left: 10)),
                    )),
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
