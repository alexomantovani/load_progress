// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:load_progress/models/user/user.dart';
import 'package:load_progress/services/user/user_service.dart';
import 'package:load_progress/views/home/home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _nameTextEditingController;
  late TextEditingController _emailTextEditingController;
  bool isLoading = false;
  User? _user;

  @override
  void initState() {
    _nameTextEditingController = TextEditingController();
    _emailTextEditingController = TextEditingController();
    super.initState();
  }

  createUser() async {
    final response = await UserService().createUser(
        _nameTextEditingController.text, _emailTextEditingController.text);

    if (response!['message'] != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(response['message']),
          backgroundColor: Colors.blue,
        ),
      );
      setState(() => isLoading = false);
      await Future.delayed(const Duration(seconds: 2))
          .whenComplete(() => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              )));
    } else {
      if (response['error'].toString().contains('uso')) {
        setState(() => isLoading = false);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(response['error']),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => isLoading = false);
      }
    }
  }

  getUser() async {
    setState(() => isLoading = true);
    final user = await UserService().getUser(_nameTextEditingController.text);
    if (user != null) {
      setState(() => isLoading = false);
      _user = user[0];
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MyHomePage(user: _user,),
        ),
      );
    } else {
      createUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const FlutterLogo(
                  size: 60.0,
                  duration: Duration(seconds: 2),
                  curve: Curves.bounceIn,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              TextField(
                controller: _nameTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Nome',
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue.shade900,
                      width: 3.0,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              TextField(
                controller: _emailTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue.shade900,
                      width: 3.0,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  if (_nameTextEditingController.text.isNotEmpty &&
                      _emailTextEditingController.text.isNotEmpty) {
                    getUser();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('Preencha os campos obritgatórios'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 140.0,
                  padding: const EdgeInsets.all(8.0),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white))
                      : const Text(
                          'Cadastrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
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
