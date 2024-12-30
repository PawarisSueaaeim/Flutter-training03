import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_training04/tab_menu_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final url = Uri.parse('https://www.melivecode.com/api/login');
    final haeder = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': _usernameController.text,
      'password': _passwordController.text,
    });

    final response = await http.post(url, headers: haeder, body: body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      _showSnackbar(jsonResponse['message']);
      _navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (contaxt) => TabMenuPage(username: jsonResponse['user']['username'], avatarUrl: jsonResponse['user']['avatar']))
      );
    }else if(response.statusCode == 401) {
      final jsonResponse = jsonDecode(response.body);
      _showSnackbar(jsonResponse['message']);
    }
  }

  void _showSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              TextFormField(
                                controller: _usernameController,
                                decoration: const InputDecoration(
                                    labelText: 'Username'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a username...';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    labelText: 'Password'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a password...';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _login();
                                    }
                                  },
                                  child: const Text('Login')),
                            ],
                          )),
                    ),
                  ),
                ));
      },
    );
  }
}
