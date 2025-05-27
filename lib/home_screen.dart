import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool get isAnonymousUser => FirebaseAuth.instance.currentUser?.isAnonymous ?? true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главный экран'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
            tooltip: 'Выйти',
          ),
        ],
      ),
      body: Center(
        child: isAnonymousUser
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Вы используете приложение без авторизации.\nНекоторые функции ограничены.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: const Text('Войти или зарегистрироваться'),
                  ),
                ],
              )
            : const Text(
                'Добро пожаловать! У вас есть полный доступ к функционалу.',
                textAlign: TextAlign.center,
              ),
      ),
      floatingActionButton: isAnonymousUser
          ? null
          : FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Вы используете расширенный функционал!')),
                );
              },
              child: const Icon(Icons.lock_open),
              tooltip: 'Доступно только авторизованным',
            ),
    );
  }
}
