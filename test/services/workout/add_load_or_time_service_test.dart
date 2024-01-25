import 'package:flutter_test/flutter_test.dart';
import 'package:load_progress/services/workout/add_load_or_time_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockAddLoadOrTimeService extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AddLoadOrTimeService service;

  setUp(() {
    client = MockAddLoadOrTimeService();
    service = AddLoadOrTimeService(client: client);
    registerFallbackValue(Uri());
  });

  group('updateWorkout', () {
    test('should complete successfully when the status code is 200', () async {
      final expectedUri =
          Uri.parse('https://us-central1-workouts-a5b45.cloudfunctions.net/adicionarCargaOuTempo');

      when(() => client.put(expectedUri, body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response('exercices updated successfully', 200),
      );

      final result = service.updateExercises(treinoId: 'treinoId', nome: 'nome');

      expect(result, completes);

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
