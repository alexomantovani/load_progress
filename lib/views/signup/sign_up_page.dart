import 'package:flutter/material.dart';
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
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(response['message']),
          backgroundColor: Colors.blue,
        ),
      );
      await Future.delayed(const Duration(seconds: 2))
          .whenComplete(() => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyHomePage(title: 'Home'),
              )));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(response['error']),
          backgroundColor: Colors.red,
        ),
      );
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
                    createUser();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
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
