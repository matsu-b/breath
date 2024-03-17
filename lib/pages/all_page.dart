import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test3_app/main.dart';
import 'package:test3_app/model/memo.dart';
import 'package:test3_app/pages/add_edit_memo_page.dart';
import 'package:test3_app/pages/memo_detail_page.dart';

class AllPage extends StatefulWidget {
  const AllPage({super.key, required this.title});

  final String title;

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  final memoCollection = FirebaseFirestore.instance.collection('memo');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Scaffoldは画面の基本となるウィジェット
      appBar: AppBar(//AppBarは画面上部のバーを作成するウィジェット
        backgroundColor: Colors.white,
        title: Text(widget.title),
        automaticallyImplyLeading: false, //戻るボタンを非表示にする
      ),
      body:StreamBuilder<QuerySnapshot>(
          //bodyには画面の中身を記述する
          stream: memoCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('データがありません'));
            }

            final docs = snapshot.data!.docs;
            return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;

                  final Memo fetchMemo = Memo(
                      id: docs[index].id,
                      title: data['title'],
                      detail: data['detail'],
                      createdDate: data['createdDate'] ?? Timestamp.now(),
                      updateDate: data['updateDate']);

                  return ListTile(
                    title: Text(fetchMemo.title),
                    trailing: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SafeArea(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddEditMemoPage(
                                                          currentMemo:
                                                              fetchMemo)));
                                        },
                                        leading: const Icon(Icons.edit),
                                        title: const Text('編集'),
                                      ),
                                      const ListTile(
                                        leading: Icon(Icons.delete),
                                        title: Text('削除'),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        icon: const Icon(Icons.edit)),
                    onTap: () {
                      //確認画面に遷移する記述を書く
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MemoDetailPage(fetchMemo)));
                    },
                  );
                });
          }),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddEditMemoPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
