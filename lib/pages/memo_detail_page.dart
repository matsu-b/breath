import 'package:flutter/material.dart';
import 'package:test3_app/model/memo.dart';

class MemoDetailPage extends StatelessWidget {
  final Memo memo;
  const MemoDetailPage(this.memo, {super.key}); //ここで画面遷移する際にメモの情報を送って来てねということが記述できている

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(memo.title), //変数の代入をする際はconstを使えない
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('メモ詳細', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold),),
              Text(memo.detail, style: const TextStyle(fontSize: 18),),
            ],
          ),
        ));
  }
}
