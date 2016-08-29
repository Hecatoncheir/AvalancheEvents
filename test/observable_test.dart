library observable_test;

import 'package:test/test.dart';

import 'package:avalanche_events/avalanche_events.dart';

class TestObservable extends Object with ObservableMixin {}

main() async {
  TestObservable firstTestObject;
  TestObservable secondTestObject;
  setUpAll(() {
    firstTestObject = new TestObservable();
    secondTestObject = new TestObservable();
  });

  group('Observable mixin', () {
    test('can add observers', () async {
      expect(secondTestObject.observers, isNotNull);

      secondTestObject.observable(firstTestObject);
      expect(secondTestObject.observers.contains(firstTestObject), isTrue);
      expect(firstTestObject.observables.contains(secondTestObject), isTrue);
    });

    test('can remove observers', () async {
      secondTestObject.observable(firstTestObject);
      expect(secondTestObject.observers.contains(firstTestObject), isTrue);
      expect(firstTestObject.observables.contains(secondTestObject), isTrue);

      secondTestObject.removeObserver(firstTestObject);
      expect(!secondTestObject.observers.contains(firstTestObject), isTrue);
      expect(!firstTestObject.observables.contains(secondTestObject), isTrue);
    });

    test('can remove observables', () async {
      TestObservable testObservable = new TestObservable();

      testObservable.observable(firstTestObject);
      expect(testObservable.observers.contains(firstTestObject), isTrue);
      expect(firstTestObject.observables.contains(testObservable), isTrue);

      firstTestObject.removeObservable(testObservable);
      expect(!testObservable.observers.contains(firstTestObject), isTrue);
      expect(!firstTestObject.observables.contains(testObservable), isTrue);
    });
  });
}
