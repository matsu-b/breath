import 'package:cloud_firestore/cloud_firestore.dart';
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
  late CollectionReference memoCollection;
  late CollectionReference freeJournalCollection;
  late CollectionReference valueJournalCollection;
  late CollectionReference wordJournalCollection;
  late CollectionReference feelJournalCollection;

  @override
  void initState() {
    super.initState();

    memoCollection = FirebaseFirestore.instance.collection('memo');
    freeJournalCollection =
        FirebaseFirestore.instance.collection('free_journals');
    valueJournalCollection =
        FirebaseFirestore.instance.collection('value_journals');
    wordJournalCollection =
        FirebaseFirestore.instance.collection('word_journals');
    feelJournalCollection =
        FirebaseFirestore.instance.collection('feel_journals');
    combinedStream = StreamZip<QuerySnapshot>([
      memoCollection.snapshots(),
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
      }
    }
  }
  //ナビゲーションを表示させるための実装ここまで

  //ジャーナル一覧画面の実装ここから
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text(widget.title),
      ),
      body: Container(
        color: Color(0xFFF2F2F2), // 背景色を設定
        child: StreamBuilder<List<QuerySnapshot>>(
          stream: combinedStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('データがありません'));
            }

            final memoDocs = snapshot.data![0].docs;
            final freeJournalDocs = snapshot.data![1].docs;
            final valueJournalDocs = snapshot.data![2].docs;
            final wordJournalDocs = snapshot.data![3].docs;
            final feelJournalDocs = snapshot.data![4].docs;

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 📝 メモのセクションここから
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text('メモ｜memo',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                      itemCount: memoDocs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data =
                            memoDocs[index].data() as Map<String, dynamic>;

                        final Memo fetchMemo = Memo(
                          // common
                          id: memoDocs[index].id,
                          title: data['title'],
                          detail: data['detail'],
                          createdDate: data['createdDate'] ?? Timestamp.now(),
                          updateDate: data['updateDate'],
                        );

                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここから
                        return ListTile(
                          title: Text(fetchMemo.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(fetchMemo.detail),
                              Text(DateFormat('yyyy/MM/dd HH:mm')
                                  .format(fetchMemo.createdDate.toDate()))
                            ],
                          ),
                        );
                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここまで
                      }),
                  // 📝 メモのセクションここまで

                  // 🏎 フリーのセクションここから
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 50.0),
                    child: Text('フリー｜precious',
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
                          freeTitle: data['freeTitle'],
                          freeContent: data['freeContent'],
                          createdDate: data['createdDate'] ?? Timestamp.now(),
                          updateDate: data['updateDate'],
                        );

                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここから
                        return ListTile(
                          title: Text(fetchMemo.freeTitle),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(fetchMemo.freeContent),
                              Text(DateFormat('yyyy/MM/dd HH:mm')
                                  .format(fetchMemo.createdDate.toDate()))
                            ],
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
                        Map<String, dynamic> data =
                            valueJournalDocs[index].data() as Map<String, dynamic>;

                        final Value fetchMemo = Value(
                          // common
                          id: valueJournalDocs[index].id,
                          valueContent: data['valueContent'],
                          valueReason: data['valueReason'],
                          valueSubject: data['valueSubject'],
                          createdDate: data['createdDate'] ?? Timestamp.now(),
                          updateDate: data['updateDate'],
                        );

                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここから
                        return ListTile(
                          title: Text(fetchMemo.valueContent),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(fetchMemo.valueReason),
                              Text(fetchMemo.valueSubject),
                              Text(DateFormat('yyyy/MM/dd HH:mm')
                                  .format(fetchMemo.createdDate.toDate()))
                            ],
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
                        Map<String, dynamic> data =
                            wordJournalDocs[index].data() as Map<String, dynamic>;

                        final Word fetchMemo = Word(
                          // common
                          id: wordJournalDocs[index].id,
                          word: data['word'],
                          wordReason: data['wordReason'],
                          wordType: data['wordType'],
                          createdDate: data['createdDate'] ?? Timestamp.now(),
                          updateDate: data['updateDate'],
                        );

                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここから
                        return ListTile(
                          title: Text(fetchMemo.word),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(fetchMemo.wordReason),
                              Text(fetchMemo.wordType),
                              Text(DateFormat('yyyy/MM/dd HH:mm')
                                  .format(fetchMemo.createdDate.toDate()))
                            ],
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
                        Map<String, dynamic> data =
                            feelJournalDocs[index].data() as Map<String, dynamic>;

                        final Feel fetchMemo = Feel(
                          // common
                          id: feelJournalDocs[index].id,
                          feelType: data['feelType'],
                          feelReason: data['feelReason'],
                          feelAdvice: data['feelAdvice'],
                          createdDate: data['createdDate'] ?? Timestamp.now(),
                          updateDate: data['updateDate'],
                        );

                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここから
                        return ListTile(
                          title: Text(fetchMemo.feelType),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(fetchMemo.feelReason),
                              Text(fetchMemo.feelAdvice),
                              Text(DateFormat('yyyy/MM/dd HH:mm')
                                  .format(fetchMemo.createdDate.toDate()))
                            ],
                          ),
                        );
                        //メモのタイトルを一覧で表示＆編集画面への遷移を実装ここまで
                      }),
                  // 💚 感情のセクションここまで


                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
  //ジャーナル一覧画面の実装ここまで
}


// // value_journal
                          // // ⭐後でそれぞれのデータを取得するように変更する
                          // valueContent: data['valueContent'],
                          // valueReason: data['valueReason'],
                          // valueSubject: data['valueSubject'],