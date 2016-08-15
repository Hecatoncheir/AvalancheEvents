library observable_test;

import 'package:test/test.dart';

import 'package:avalanche_events/avalanche_events.dart';

class TestNotify extends Object with NotifyMixin {}

main() async {
  TestNotify testObject;
  setUp(() {
    testObject = new TestNotify();
  });

  group('Notify mixin', () {
    test('can dispatch and register event in generatedEvents list', () {
      testObject.dispatchEvent('testEvent');
      expect(testObject.generatedEvents.contains('testEvent'), isTrue);
    });

    test(
        'can set handler for event and register event message in treatmentEvents list',
        () {
      testObject.on('testEvent', () {});
      expect(testObject.treatmentEvents.contains('testEvent'), isTrue);
    });

    test('can listen event', () {
      testObject.on(
          'testEvent',
          expectAsync((Map data) {
            expect(data['message'], equals('testEvent'));
          }, count: 1));
      testObject.dispatchEvent('testEvent');
    });

    test('can dispatch any object in details', () {
      testObject.on(
          'testEvent',
          expectAsync((details) {
            expect(details, isTrue);
          }, count: 1));
      testObject.dispatchEvent('testEvent', true);
    });
  });
}
