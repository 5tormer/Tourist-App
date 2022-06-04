import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourist_app/screens/login_screen.dart';
import 'package:tourist_app/screens/main_screen.dart';
import 'package:tourist_app/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Регистрация',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: "Введите почту",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: visibility,
              controller: passwordController,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onLongPressUp: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                    onLongPressDown: (details) {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                    child: visibility
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: 'Введите пароль'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 320,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: const BorderSide(color: Colors.blue),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  elevation: MaterialStateProperty.all(0),
                ),
                onPressed: () async {
                  var _result = await context.read<AuthService>().signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                  _result
                      ? Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                          (_) => false,
                        )
                      : null;
                },
                child: const Text("Зарегистрироваться"),
              ),
            ),
            TextButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                child: const Text('Уже есть аккаунт? Войти'))
          ],
        ),
      ),
    );
  }
}
