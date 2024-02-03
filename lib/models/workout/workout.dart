// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Workout extends Equatable {
  final String treinoId;
  final String tipoTreino;
  final String usuarioId;
  final List<Exercicios> exercicios;
  const Workout({
    required this.treinoId,
    required this.tipoTreino,
    required this.usuarioId,
    required this.exercicios,
  });

  Workout.empty()
      : this(
          treinoId: '_empty.treinoId',
          tipoTreino: '_empty.tipoTreino',
          usuarioId: '_empty.usuarioId',
          exercicios: List.empty(),
        );

  Workout copyWith({
    String? treinoId,
    String? tipoTreino,
    String? usuarioId,
    List<Exercicios>? exercicios,
  }) {
    return Workout(
      treinoId: treinoId ?? this.treinoId,
      tipoTreino: tipoTreino ?? this.tipoTreino,
      usuarioId: usuarioId ?? this.usuarioId,
      exercicios: exercicios ?? this.exercicios,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'treinoId': treinoId,
      'tipoTreino': tipoTreino,
      'usuarioId': usuarioId,
      'exercicios': exercicios.map((x) => x.toMap()).toList(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      treinoId: map['treinoId'] as String,
      tipoTreino: map['tipoTreino'] as String,
      usuarioId: map['usuarioId'] as String,
      exercicios: List<Exercicios>.from(
        (map['exercicios'] as List<dynamic>).map<Exercicios>(
          (x) => Exercicios.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Workout.fromJson(String source) =>
      Workout.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [treinoId, tipoTreino, usuarioId, exercicios];
}

class Exercicios extends Equatable {
  final String nome;
  final String tempo;
  final String repeticoes;
  final String grupoMuscularAlvo;
  final List<dynamic> carga;
  const Exercicios({
    required this.nome,
    required this.tempo,
    required this.repeticoes,
    required this.grupoMuscularAlvo,
    required this.carga,
  });

  Exercicios.empty()
      : this(
          nome: '_empty.name',
          tempo: '_empty.tempo',
          repeticoes: '_empty.usuarioId',
          grupoMuscularAlvo: '_empty_grupoMuscularAlvo',
          carga: List.empty(),
        );

  Exercicios copyWith({
    String? nome,
    String? tempo,
    String? repeticoes,
    String? grupoMuscularAlvo,
    List<dynamic>? carga,
  }) {
    return Exercicios(
      nome: nome ?? this.nome,
      tempo: tempo ?? this.tempo,
      repeticoes: repeticoes ?? this.repeticoes,
      grupoMuscularAlvo: grupoMuscularAlvo ?? this.grupoMuscularAlvo,
      carga: carga ?? this.carga,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'tempo': tempo,
      'repeticoes': repeticoes,
      'grupoMuscularAlvo': grupoMuscularAlvo,
      'carga': carga,
    };
  }

  factory Exercicios.fromMap(Map<String, dynamic> map) {
    return Exercicios(
      nome: map['nome'] ?? '',
      tempo: map['tempo'] ?? '',
      repeticoes: map['repeticoes'] ?? '',
      grupoMuscularAlvo: map['grupoMuscularAlvo'] ?? '',
      carga: map['carga'] != null
          ? List<dynamic>.from(
              (map['carga'] as List<dynamic>),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Exercicios.fromJson(String source) =>
      Exercicios.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      nome,
      tempo,
      repeticoes,
      grupoMuscularAlvo,
      carga,
    ];
  }
}
