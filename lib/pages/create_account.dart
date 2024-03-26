import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test3_app/pages/login.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  //入力されたメールアドレスを入れるデータ
  String newUserEmail = '';
  //入力されたパスワードを入れるデータ
  String newUserPassword = '';
  // 登録・ログインに関する情報を表示するデータ
  String infoText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: const Text('Sign Up'),
        automaticallyImplyLeading: false, //戻るボタンを非表示にする
      ),
      body: Center(
        child: Container(
          color: Color(0xFFF2F2F2), // 背景色を設定
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              //Emailアドレスを入力するテキストラベルを作成する
              TextField(
                decoration: const InputDecoration(labelText: "Email"),
                onChanged: (value) {
                  setState(() {
                    newUserEmail = value;
                  });
                },
              ),
              //スペースを空ける
              const SizedBox(height: 8),
              //パスワードを入力するテキストラベルを作成する
              TextField(
                decoration: const InputDecoration(labelText: "Password"),
                //パスワードが見えないように設定する
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    newUserPassword = value;
                  });
                },
              ),
              //スペースを空ける
              const SizedBox(height: 8),
              //このボタンを押すとfirebaseにユーザー情報が登録される
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black), // ボタンの背景色を黒に設定
                ),
                onPressed: () async {
                  try {
                    // メール/パスワードでユーザー登録
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result =
                        await auth.createUserWithEmailAndPassword(
                      email: newUserEmail,
                      password: newUserPassword,
                    );
                    // 登録したユーザー情報
                    final User user = result.user!;
                    setState(() {
                      // infoText = "登録OK：${user.email}";
                        Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()),
                  );
                    });
                  } catch (e) {
                    // 登録に失敗した場合
                    setState(() {
                      infoText = "登録NG：${e.toString()}";
                    });
                  }
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white, // テキストの色を白に設定
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //スペースを空ける
              const SizedBox(height: 8),
              // 登録・ログインに関する情報を表示
              Text(infoText),
              //スペースを空ける
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()),
                  );
                },
                child: const Text(
                  '既にアカウントをお持ちの方はこちら',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}