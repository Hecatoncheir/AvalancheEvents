library stream_service_test;

import 'package:test/test.dart';

import 'package:avalanche_events/avalanche_events.dart';

class TestStreamService extends AvalancheEvents {}

main() async {
  TestStreamService firstTestObject;
  TestStreamService secondTestObject;

  setUpAll(() {
    firstTestObject = new TestStreamService();
    secondTestObject = new TestStreamService();
  });

  group('Avalanche events', () {
    test('class can be extendable', () {
      expect(firstTestObject.hashCode != secondTestObject.hashCode, isTrue);

      expect(
          firstTestObject.stream.hashCode != secondTestObject.stream.hashCode,
          isTrue);

      expect(firstTestObject.hashCode != secondTestObject.hashCode, isTrue);
    });

    test('object can be observable', () {
      firstTestObject.observable(secondTestObject);
      expect(firstTestObject.observers.contains(secondTestObject), isTrue);
      expect(secondTestObject.observables.contains(firstTestObject), isTrue);

      secondTestObject.observable(firstTestObject);
      expect(secondTestObject.observers.contains(firstTestObject), isTrue);
      expect(firstTestObject.observables.contains(secondTestObject), isTrue);
    });

    test('object can subscribe', () {
      secondTestObject.subscribe(firstTestObject);
      expect(firstTestObject.observers.contains(secondTestObject), isTrue);
      expect(secondTestObject.observables.contains(firstTestObject), isTrue);

      firstTestObject.subscribe(secondTestObject);
      expect(secondTestObject.observers.contains(firstTestObject), isTrue);
      expect(firstTestObject.observables.contains(secondTestObject), isTrue);
    });

    test('object can dispatch and get event', () {
      firstTestObject.observable(secondTestObject);

      secondTestObject.stream.listen(expectAsync((event) {
        expect(
            secondTestObject.treatmentEvents
                .contains('testEventFromFirstTestObject'),
            isTrue);
      }, count: 1));

      firstTestObject.stream.listen(expectAsync((event) {
        expect(
            firstTestObject.generatedEvents
                .contains('testEventFromFirstTestObject'),
            isTrue);
      }, count: 1));

      secondTestObject.on(
          'testEventFromFirstTestObject',
          expectAsync((Map data) {
            expect(data['details'], isTrue);
          }, count: 1));

      firstTestObject
          .dispatchEvent('testEventFromFirstTestObject', {'details': true});

      firstTestObject.subscribe(secondTestObject);

      firstTestObject.on(
          'testEventFromSecondTestObject',
          expectAsync((Map data) {
            expect(data['details'], isTrue);
          }, count: 1));

      firstTestObject.stream.listen(expectAsync((event) {
        expect(
            firstTestObject.treatmentEvents
                .contains('testEventFromSecondTestObject'),
            isTrue);
      }));

      secondTestObject.stream.listen(expectAsync((event) {
        expect(
            secondTestObject.generatedEvents
                .contains('testEventFromSecondTestObject'),
            isTrue);
      }));

      secondTestObject
          .dispatchEvent('testEventFromSecondTestObject', {'details': true});
    });
  });
}
