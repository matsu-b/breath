import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test3_app/main.dart';
import 'package:test3_app/model/memo.dart';
import 'package:async/async.dart';
import 'package:intl/intl.dart';

class AllPage extends StatefulWidget {
  const AllPage({super.key, required this.title});
  final String title;

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  late StreamZip<QuerySnapshot> combinedStream;
  late Query<Map<String, dynamic>> freeJournalCollection;
  late Query<Map<String, dynamic>> valueJournalCollection;
  late Query<Map<String, dynamic>> wordJournalCollection;
  late Query<Map<String, dynamic>> feelJournalCollection;

  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser;
    String userId = user != null ? user.uid : '';

    freeJournalCollection = FirebaseFirestore.instance
        .collection('free_journals')
        .where('userid', isEqualTo: userId);
    valueJournalCollection = FirebaseFirestore.instance
        .collection('value_journals')
        .where('userid', isEqualTo: userId);
    wordJournalCollection = FirebaseFirestore.instance
        .collection('word_journals')
        .where('userid', isEqualTo: userId);
    feelJournalCollection = FirebaseFirestore.instance
        .collection('feel_journals')
        .where('userid', isEqualTo: userId);

    combinedStream = StreamZip<QuerySnapshot>([
      freeJournalCollection.snapshots(),
      valueJournalCollection.snapshots(),
      wordJournalCollection.snapshots(),
      feelJournalCollection.snapshots(),
    ]);
  }

  //ナビゲーションを表示させるための実装ここから
  int _selectedIndex = 1;

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
          Navigator.pushNamed(context, '/account');
          break;
      }
    }
  }
  //ナビゲーションを表示させるための実装ここまで

  //ジャーナル一覧画面の実装ここから
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2), 
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: const Text(
          '過去のブレス😮‍💨一覧',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false, //戻るボタンを非表示にする
      ),
      body: StreamBuilder<List<QuerySnapshot>>(
        stream: combinedStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData) {
            return Container(
              color: Color(0xFFF2F2F2), // 背景色を設定
              child: const Center(child: Text('データがありません')),
            );
          }

          // 各セクションのドキュメントを取得
          final freeJournalDocs = snapshot.data![0].docs;
          final valueJournalDocs = snapshot.data![1].docs;
          final wordJournalDocs = snapshot.data![2].docs;
          final feelJournalDocs = snapshot.data![3].docs;

          return Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 🏎 フリーのセクションここから
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 50.0),
                    child: Text('フリー｜free',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: freeJournalDocs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = freeJournalDocs[index]
                            .data() as Map<String, dynamic>;

                        final Free fetchMemo = Free(
                          // common
                          id: freeJournalDocs[index].id,
                          userid: data['userid'],
                          freeTitle: data['freeTitle'],
                          freeContent: data['freeContent'],
                          createdDate: data['createdDate'] ?? Timestamp.now(),
                          updateDate: data['updateDate'],
                        );

                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここから
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text('タイトル',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(fetchMemo.freeTitle),
                                const SizedBox(height: 10),
                                const Text('内容',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(fetchMemo.freeContent),
                                const SizedBox(height: 10),
                                Text(
                                  '日付：' +
                                      DateFormat('yyyy/MM/dd HH:mm').format(
                                          fetchMemo.createdDate.toDate()),
                                ),
                              ],
                            ),
                          ),
                        );
                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここまで
                      }),
                  // 🏎 フリーのセクションここまで

                  // 🔥 価値観のセクションここから
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 50.0),
                    child: Text('大切なこと｜precious',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: valueJournalDocs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = valueJournalDocs[index]
                            .data() as Map<String, dynamic>;

                        final Value fetchMemo = Value(
                          // common
                          id: valueJournalDocs[index].id,
                          valueContent: data['valueContent'],
                          valueReason: data['valueReason'],
                          valueSubject: data['valueSubject'],
                          createdDate: data['createdDate'] ?? Timestamp.now(),
                          updateDate: data['updateDate'],
                          userid: data['userid'],
                        );

                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここから
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text('対象',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(fetchMemo.valueSubject),
                                const SizedBox(height: 10),
                                const Text('大切にしたいこと',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(fetchMemo.valueContent),
                                const SizedBox(height: 10),
                                const Text('その理由',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(fetchMemo.valueReason),
                                const SizedBox(height: 10),
                                Text(
                                  '日付：' +
                                      DateFormat('yyyy/MM/dd HH:mm').format(
                                          fetchMemo.createdDate.toDate()),
                                ),
                              ],
                            ),
                          ),
                        );
                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここまで
                      }),
                  // 🔥 価値観のセクションここまで

                  // 🗣 言葉のセクションここから
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 50.0),
                    child: Text('言葉｜words',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: wordJournalDocs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = wordJournalDocs[index]
                            .data() as Map<String, dynamic>;

                        final Word fetchMemo = Word(
                          // common
                          id: wordJournalDocs[index].id,
                          word: data['word'],
                          wordReason: data['wordReason'],
                          wordType: data['wordType'],
                          createdDate: data['createdDate'] ?? Timestamp.now(),
                          updateDate: data['updateDate'],
                          userid: data['userid'],
                        );

                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここから
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text('印象に残った言葉',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(fetchMemo.word),
                                const SizedBox(height: 10),
                                const Text('その理由',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(fetchMemo.wordReason),
                                const SizedBox(height: 10),
                                const Text('自分にとってどんな言葉か',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(fetchMemo.wordType),
                                const SizedBox(height: 10),
                                Text(
                                  '日付：' +
                                      DateFormat('yyyy/MM/dd HH:mm').format(
                                          fetchMemo.createdDate.toDate()),
                                ),
                              ],
                            ),
                          ),
                        );
                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここまで
                      }),
                  // 🗣 言葉のセクションここまで

                  // 💚 感情のセクションここから
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 50.0),
                    child: Text('感情｜feeling',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: feelJournalDocs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = feelJournalDocs[index]
                            .data() as Map<String, dynamic>;

                        final Feel fetchMemo = Feel(
                          // common
                          id: feelJournalDocs[index].id,
                          feelType: data['feelType'],
                          feelReason: data['feelReason'],
                          feelAdvice: data['feelAdvice'],
                          createdDate: data['createdDate'] ?? Timestamp.now(),
                          updateDate: data['updateDate'],
                          userid: data['userid'],
                        );

                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここから
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text('その時の感情',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(fetchMemo.feelType),
                                const SizedBox(height: 10),
                                const Text('その感情になった理由',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(fetchMemo.feelReason),
                                const SizedBox(height: 10),
                                const Text('未来の自分へのアドバイス',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(fetchMemo.feelAdvice),
                                const SizedBox(height: 10),
                                Text(DateFormat('yyyy/MM/dd HH:mm')
                                    .format(fetchMemo.createdDate.toDate()))
                              ],
                            ),
                          ),
                        );
                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここまで
                      }),
                  // 💚 感情のセクションここまで
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  } //ジャーナル一覧画面の実装ここまで
}
