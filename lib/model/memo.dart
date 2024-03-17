import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  // test用に追加
  String id;
  String title;
  String detail; 
  Timestamp createdDate;
  Timestamp? updateDate;

  Memo({
    required this.id,
    required this.title,
    required this.detail,
    required this.createdDate,
    this.updateDate,
  });
}

// //Breath用に追加
// class User {
//   String username;
//   String password;
    
//   User({
//     required this.username,
//     required this.password,

//   });
// }

// このように、モデルクラスを作成することで、データの構造を定義し、データの取得や保存を行う際に、型安全なコードを書くことができます。
// また、このようにモデルクラスを作成することで、データの構造が変更された場合に、変更箇所を一箇所にまとめることができます。
// これにより、データの構造が変更された場合に、変更箇所を一箇所にまとめることができます。