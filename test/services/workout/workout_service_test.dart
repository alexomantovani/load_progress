import 'package:flutter_test/flutter_test.dart';
import 'package:load_progress/services/workout/workout_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late WorkoutService service;

  setUp(() {
    client = MockClient();
    service = WorkoutService(client: client);
    registerFallbackValue(Uri());
  });

  group('createWorkout', () {
    test(
        'should complete unsuccessfully when the status code is 400 throw an Exception',
        () async {
      when(
        () => client.post(any(),
            body: any(named: 'body'), headers: any(named: 'headers')),
      ).thenAnswer(
        (_) async => http.Response(
          'Nome de usuário, tipo de treino e exercícios são obrigatórios. O campo exercicios deve ser um array com pelo menos um elemento.',
          400,
        ),
      );

      final result = service.createWorkout(
        email: 'dummy@email.com',
        tipoTreino: 'dummyTipoTreino',
        exercicios: [],
      );

      verify(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
