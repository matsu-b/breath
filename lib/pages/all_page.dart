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
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Business Page'),
    Text('School Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  //ナビゲーションを表示させるための実装ここまで

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Scaffoldは画面の基本となるウィジェット
      appBar: AppBar(
        //AppBarは画面上部のバーを作成するウィジェット
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
          child: StreamBuilder<QuerySnapshot>(
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
         ),
      //ナビゲーションを表示させるための実装ここから 
        Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        //ナビゲーションを表示させるための実装ここまで
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      //ナビゲーションを表示させるための実装ここまで
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
