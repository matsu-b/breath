import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test3_app/model/memo.dart';

class AddEditMemoPage extends StatefulWidget {
  final Memo? currentMemo;
  const AddEditMemoPage({super.key, this.currentMemo});
  


  @override
  State<AddEditMemoPage> createState() => _AddEditMemoPageState();
}

class _AddEditMemoPageState extends State<AddEditMemoPage> {
  TextEditingController titleController =
      TextEditingController(); //入力された情報を管理するために必要
  TextEditingController detailController =
      TextEditingController(); //入力された情報を管理するために必要

  Future<void> createMemo() async {
    final memoCollection = FirebaseFirestore.instance.collection('memo');
    await memoCollection.add({
      'title': titleController.text,
      'detail': detailController.text,
      'createdDate': Timestamp.now()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.currentMemo == null ? 'メモ追加' : 'メモ編集')
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text('タイトル'),
            const SizedBox(height: 20),
            Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                width: MediaQuery.of(context).size.width * 0.8, //幅を80%にする
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10)),
                )),
            const SizedBox(height: 40),
            const Text('詳細'),
            const SizedBox(height: 20),
            Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                width: MediaQuery.of(context).size.width * 0.8, //幅を80%にする
                child: TextField(
                  controller: detailController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10)),
                )),
            const SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width * 0.8, //幅を80%にする
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  //メモをDBに登録する処
                  await createMemo();
                  Navigator.pop(context); //一番上のレイヤーの画面と取り除くというような処理
                },
                child: Text(widget.currentMemo == null ?'追加' : '更新'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
