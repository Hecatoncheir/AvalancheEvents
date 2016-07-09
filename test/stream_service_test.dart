library stream_service_test;

import 'dart:async';
import 'package:test/test.dart';

import 'package:stream_service/stream_service.dart';

class TestStreamService extends StreamService {}

main() async {
  group('StreamService', () {
    test('can be extendable', () {
      TestStreamService firstTestObject = new TestStreamService();
      TestStreamService secondTestObject = new TestStreamService();
      StreamService firstStreamService = firstTestObject.streamService;

      expect(
          firstTestObject.streamService.hashCode !=
              secondTestObject.streamService.hashCode,
          isTrue);

      expect(
          firstTestObject.stream.hashCode != secondTestObject.stream.hashCode,
          isTrue);

      expect(firstTestObject.hashCode != secondTestObject.hashCode, isTrue);

      expect(firstStreamService, isNotNull);
    });

    test('can be observable', () async {
      TestStreamService firstTestObject = new TestStreamService();
      TestStreamService secondTestObject = new TestStreamService();

      firstTestObject.observable(secondTestObject);
      expect(firstTestObject.observers.contains(secondTestObject), isTrue);
      expect(secondTestObject.observables.contains(firstTestObject), isTrue);

      secondTestObject.observable(firstTestObject);
      expect(secondTestObject.observers.contains(firstTestObject), isTrue);
      expect(firstTestObject.observables.contains(secondTestObject), isTrue);
    });

    test('can dispatch and get event', () async {
      TestStreamService firstTestObject = new TestStreamService();
      TestStreamService secondTestObject = new TestStreamService();

      firstTestObject.observable(secondTestObject);

      secondTestObject.on(
          'testEventFromFirstTestObject',
          expectAsync((Map data) {
            expect(data['details'], isTrue);
          }, count: 2));

      expect(
          secondTestObject.treatmentEvents
              .contains('testEventFromFirstTestObject'),
          isTrue);

      firstTestObject
          .dispatchEvent('testEventFromFirstTestObject', {'details': true});

      expect(
          firstTestObject.generatedEvents
              .contains('testEventFromFirstTestObject'),
          isTrue);

      secondTestObject.observable(firstTestObject);

      firstTestObject.on('testEventFromSecondTestObject',
          expectAsync((Map data) {
        expect(data['details'], isTrue);
      }));

      expect(
          firstTestObject.treatmentEvents
              .contains('testEventFromSecondTestObject'),
          isTrue);

      secondTestObject
          .dispatchEvent('testEventFromSecondTestObject', {'details': true});

      expect(
          secondTestObject.generatedEvents
              .contains('testEventFromSecondTestObject'),
          isTrue);
    });
  });
}
