library stream_service_test;

import 'package:test/test.dart';

import 'package:stream_service/stream_service.dart';

class TestStreamService extends StreamService {} // Содержит все миксины

class TestObservable extends Object with ObservableMixin {}

class TestNotify extends Object with NotifyMixin {}

main() async {
  group('Observable mixin', () {
    test('can add observers', () {
      TestObservable testObservable = new TestObservable();
      TestStreamService firstTestObject = new TestStreamService();
      expect(testObservable.observers, isNotNull);

      testObservable.observable(firstTestObject);
      expect(testObservable.observers.contains(firstTestObject), isTrue);
      expect(firstTestObject.observables.contains(testObservable), isTrue);
    });

    test('can remove observers', () {
      TestObservable testObservable = new TestObservable();
      TestStreamService firstTestObject = new TestStreamService();

      testObservable.observable(firstTestObject);
      expect(testObservable.observers.contains(firstTestObject), isTrue);
      expect(firstTestObject.observables.contains(testObservable), isTrue);

      testObservable.removeObserver(firstTestObject);
      expect(!testObservable.observers.contains(firstTestObject), isTrue);
      expect(!firstTestObject.observables.contains(testObservable), isTrue);
    });

    test('can remove observables', () {
      TestObservable testObservable = new TestObservable();
      TestStreamService firstTestObject = new TestStreamService();

      testObservable.observable(firstTestObject);
      expect(testObservable.observers.contains(firstTestObject), isTrue);
      expect(firstTestObject.observables.contains(testObservable), isTrue);

      firstTestObject.removeObservable(testObservable);
      expect(!testObservable.observers.contains(firstTestObject), isTrue);
      expect(!firstTestObject.observables.contains(testObservable), isTrue);
    });
  });

  group('Notify mixin', () {
    test('can dispatch and register event in generatedEvents list', () {
      TestNotify testNotify = new TestNotify();
      testNotify.dispatchEvent('testEvent');
      expect(testNotify.generatedEvents.contains('testEvent'), isTrue);
    });

    test(
        'can set handler for event and register event message in treatmentEvents list',
        () {
      TestNotify testNotify = new TestNotify();
      testNotify.on('testEvent', () {});
      expect(testNotify.treatmentEvents.contains('testEvent'), isTrue);
    });

    test('can listen event', () {
      TestNotify testNotify = new TestNotify();
      testNotify.on(
          'testEvent',
          expectAsync((Map data) {
            expect(data['message'], equals('testEvent'));
          }, count: 1));
      testNotify.dispatchEvent('testEvent');
    });

    test('can dispatch any object in details', () {
      TestNotify testNotify = new TestNotify();
      testNotify.on(
          'testEvent',
          expectAsync((details) {
            expect(details, isTrue);
          }, count: 1));
      testNotify.dispatchEvent('testEvent', true);
    });
  });

  group('StreamService', () {
    test('can be extendable', () {
      TestStreamService firstTestObject = new TestStreamService();
      TestStreamService secondTestObject = new TestStreamService();

      expect(firstTestObject.hashCode != secondTestObject.hashCode, isTrue);

      expect(
          firstTestObject.stream.hashCode != secondTestObject.stream.hashCode,
          isTrue);

      expect(firstTestObject.hashCode != secondTestObject.hashCode, isTrue);
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
          }, count: 1));

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

      firstTestObject.on(
          'testEventFromSecondTestObject',
          expectAsync((Map data) {
            expect(data['details'], isTrue);
          }, count: 1));

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
