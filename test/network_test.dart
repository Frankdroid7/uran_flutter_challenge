// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uran_flutter_challange/models/exhibit.dart';
import 'package:uran_flutter_challange/rest_exhibit_loader.dart';

import 'network_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('getExhibitList', () {
    test('returns an Exhibit list if network call was successful', () async {
      final client = MockClient();

      when(client.get(Uri.parse(
              'https://my-json-server.typicode.com/Reyst/exhibit_db/list')))
          .thenAnswer((_) async =>
              http.Response('[{"title": "iPhone 5s", "images":[""]}]', 200));

      expect(await RestExhibitsLoader().getExhibitList(client),
          isA<List<Exhibit>>());
    });
  });
}
