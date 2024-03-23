import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test3_app/model/memo.dart';

class FeelingJournal extends StatefulWidget {
  final Feel? currentMemo;
  const FeelingJournal({super.key, this.currentMemo});

  @override
  State<FeelingJournal> createState() => _FeelingJournalState();
}

class _FeelingJournalState extends State<FeelingJournal> {
  TextEditingController feelTypeController =
      TextEditingController(); //入力された情報を管理するために必要
  TextEditingController feelReasonController =
      TextEditingController(); //入力された情報を管理するために必要
  TextEditingController feelAdviceController =
      TextEditingController(); //入力された情報を管理するために必要

  Future<void> createMemo() async {
    final memoCollection =
        FirebaseFirestore.instance.collection('feel_journals');
    await memoCollection.add({
      'feelType': feelTypeController.text,
      'feelReason': feelReasonController.text,
      'feelAdvice': feelAdviceController.text,
      'createdDate': Timestamp.now()
    });
  }

  Future<void> updateMemo() async {
    final doc = FirebaseFirestore.instance
        .collection('feel_journals')
        .doc(widget.currentMemo!.id);
    await doc.update({
      'feelType': feelTypeController.text,
      'feelReason': feelReasonController.text,
      'feelAdvice': feelAdviceController.text,
      'createdDate': Timestamp.now()
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.currentMemo != null) {
      feelTypeController.text = widget.currentMemo!.feelType;
      feelReasonController.text = widget.currentMemo!.feelReason;
      feelAdviceController.text = widget.currentMemo!.feelAdvice;
    }
  }

  //プルダウンメニューと値をDBに受け渡すための処理ここから
  List<String> dropdownItems = [
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
  String? selectedDropdownItem;
  //プルダウンメニューと値をDBに受け渡すための処理ここまで

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    } else {
                      await updateMemo();
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
    );
  }
}
