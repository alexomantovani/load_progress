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
    test('should complete successfully when the status code is 200 or 201',
        () async {
      final response = {'Success': 'Workout sucessfully created', 'statusCode': '201'};

      when(
        () => client.post(any(),
            body: any(named: 'body'), headers: any(named: 'headers')),
      ).thenAnswer(
        (_) async => http.Response(
          'Workout sucessfully created',
          201,
        ),
      );

      final result = await service.createWorkout(
        email: 'teste@teste.com',
        tipoTreino: 'B',
        exercicios: [{}],
      );

      expect(
        result,
        equals(response),
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

    test(
        'should complete unsuccessfully when the status code is 400 and throw an [FormatException]',
        () async {
      when(
        () => client.post(any(),
            body: any(named: 'body'), headers: any(named: 'headers')),
      ).thenAnswer(
        (_) async => http.Response(
          'FormatException',
          400,
        ),
      );

      final result = service.createWorkout(
        email: 'dummyemail@dummyemail.com',
        tipoTreino: 'dummyTipoTreino',
        exercicios: [],
      );

      expect(result, throwsFormatException);

      verify(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
    test(
        'should complete unsuccessfully when the status code is 404 and throw an [FormatException]',
        () async {
      when(
        () => client.post(any(),
            body: any(named: 'body'), headers: any(named: 'headers')),
      ).thenAnswer(
        (_) async => http.Response(
          'Email not found',
          404,
        ),
      );

      final result = service.createWorkout(
        email: 'dummyemail@dummyemail.com',
        tipoTreino: 'A',
        exercicios: [{}],
      );

      expect(result, throwsFormatException);

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

  group('updateWorkout', () {
    
  });
}
