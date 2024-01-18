// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String usuarioId;
  const User({
    required this.name,
    required this.email,
    required this.usuarioId,
  });

  const User.empty()
      : this(
          name: '_empty.name',
          email: '_empty.email',
          usuarioId: '_empty.usuarioId',
        );

  User copyWith({
    String? name,
    String? email,
    String? usuarioId,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'usuarioId': usuarioId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      usuarioId: map['usuarioId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, email, usuarioId];
}
