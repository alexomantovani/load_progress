import 'package:flutter_test/flutter_test.dart';
import 'package:load_progress/services/user/user_service.dart';
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
}
