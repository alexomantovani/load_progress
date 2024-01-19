import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:load_progress/models/user/user.dart';
import 'package:load_progress/services/user/user_service.dart';
import 'package:load_progress/utils/utils.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late UserService service;

  setUp(() {
    client = MockClient();
    service = UserService(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successfully when the status code is 200 or 201',
        () async {
      // ... other setup code

      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response('user created successfully', 201),
      );

      final methodCall = service.createUser('name', 'email');

      expect(methodCall, completes);

      final capturedArguments = verify(
        () => client.post(
          captureAny(),
          body: captureAny(named: 'body'),
        ),
      ).captured;

      print('Captured URI: ${capturedArguments[0]}');
      print('Captured Body: ${capturedArguments[1]}');

      verifyNoMoreInteractions(client);
    });
  });

  group('getUser', () {
    test('should complete successfully when the status code is 200', () async {
      final expectedUri = Uri.parse(
          'https://us-central1-workouts-a5b45.cloudfunctions.net/obterUsuarioPorNome?nomeCompleto=name');

      when(() => client.get(
            expectedUri,
          )).thenAnswer(
        (_) async =>
            http.Response(jsonEncode([const User.empty().toMap()]), 200),
      );

      final methodCall = service.getUser('name');

      expect(methodCall, completes);

      verify(() => client.get(expectedUri)).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('updateUser', () {
    test('should complete successfully when the status code is 200', () async {
      when(() => client.put(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response('user updated successfully', 200),
      );

      final methodCall =
          service.updateUser('usuarioId', {"name": "name", "email": "email"});

      expect(methodCall, completes);

      verify(
        () => client.put(
          captureAny(),
          body: captureAny(named: 'body'),
        ),
      ).captured;

      verifyNoMoreInteractions(client);
    });
  });
}
