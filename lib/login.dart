import 'package:flutter/material.dart';
import 'package:test_login/home.dart';
import 'package:test_login/signup.dart';
import 'package:test_login/database.dart';  // Đảm bảo rằng bạn đã import DatabaseHelper
import 'package:test_login/model/user.dart';  // Đảm bảo rằng bạn đã import model User

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    final dbHelper = DatabaseHelper(); // Khởi tạo DatabaseHelper

    Future<void> login() async {
      if (_formKey.currentState!.validate()) {
        String email = emailController.text.trim();
        String password = passwordController.text.trim();

        // Tìm người dùng trong cơ sở dữ liệu với email và mật khẩu
        final db = await dbHelper.database;
        final result = await db.query(
          'users',
          where: 'email = ? AND password = ?',
          whereArgs: [email, password],
        );

        if (result.isNotEmpty) {
          // Nếu tìm thấy người dùng, chuyển đến màn hình chính
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          // Nếu không tìm thấy, hiển thị thông báo lỗi
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email hoặc mật khẩu không đúng!')),
          );
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Đăng nhập', style: TextStyle()),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // TextField cho email
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Email không hợp lệ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                // TextField cho mật khẩu
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                // Nút Đăng nhập
                ElevatedButton(
                  onPressed: login,
                  child: Text('Đăng nhập'),
                ),
                // Nút Đăng ký
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text('Đăng ký'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
