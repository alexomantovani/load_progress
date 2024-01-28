// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_progress/views/home/home_page.dart';
import 'package:load_progress/views/signup/bloc/getUser/get_user_bloc.dart';
import 'package:load_progress/views/signup/bloc/signup/sign_up_bloc.dart';

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
    BlocProvider.of<SignUpBloc>(context).add(
      SignUpUserEvent(
        name: _nameTextEditingController.text,
        email: _emailTextEditingController.text,
      ),
    );
  }

  getUser() async {
    BlocProvider.of<GetUserBloc>(context).add(
      GetUserRemoteSourceEvent(name: _nameTextEditingController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<GetUserBloc, GetUserState>(
        listener: (context, state) {
          if (state is GetUserFailureState) {
            createUser();
          }
        },
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 2),
                  content: Text(state.message),
                  backgroundColor: Colors.blue,
                ),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              );
            } else if (state is SignUpFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 2),
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: SafeArea(
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
                    child: BlocBuilder<GetUserBloc, GetUserState>(
                      builder: (context, state) {
                        if (state is GetUserLoadingState) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            width: 140.0,
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                          );
                        } else if (state is GetUserInitialState) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            width: 140.0,
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Cadastrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        } else if (state is GetUserLoadedState) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            width: 140.0,
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Cadastrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        } else {
                          return BlocBuilder<SignUpBloc, SignUpState>(
                            builder: (context, state) {
                              if (state is SignUpInitialState &&
                                  state is SignUpLoadingState) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  width: 140.0,
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  ),
                                );
                              } else {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  width: 140.0,
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'Cadastrar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
