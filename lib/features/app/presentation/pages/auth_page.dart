import 'package:clinic/common/extensions/build_context_extensions.dart';
import 'package:clinic/features/app/domain/repositories/database.dart';
import 'package:flutter/material.dart';

import 'admin_overview_page.dart';
import 'user_overview_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late TextEditingController _controllerLogin;
  late TextEditingController _controllerPassword;
  String _role = 'Пациент';

  @override
  void initState() {
    super.initState();
    _controllerLogin = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  @override
  void dispose() {
    _controllerLogin.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 350.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Авторизация',
              style: context.textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: _controllerLogin,
              decoration: const InputDecoration(
                hintText: 'Логин',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _controllerPassword,
              decoration: const InputDecoration(
                hintText: 'Пароль',
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 40,
            ),
            DropdownButton<String>(
              value: _role,
              onChanged: (value) {
                setState(() {
                  _role = value!;
                });
              },
              items: <String>['Пациент', 'Врач', 'Админ'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_controllerPassword.text.length < 8) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Длина пароля должна быть не меньше 8 символов.'),
                    ),
                  );
                  return;
                }
                if (_controllerLogin.text == 'admin' &&
                    _controllerPassword.text == 'Admin123' && _role == 'Админ') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminOverviewPage()),
                  );
                } else if (_role == 'Пациент' || _role == 'Врач') {
                  bool login = await Database().login(
                      _controllerLogin.text, _controllerPassword.text, _role);
                  if (login) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserOverviewPage(
                          login: _controllerLogin.text,
                          role: _role,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Неправильные данные. Попробуйте снова.'),
                      ),
                    );
                  }
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Неправильные данные. Попробуйте снова.'),
                    ),
                  );
                }
              },
              child: const Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
