part of avalanche_events;

class SubscriptionMixin {
  /// Список наблюдателей
  List observers = new List();

  /// Список наблюдаемых объектов
  List observables = new List();

  subscribe(SubscriptionMixin subscribedObject) {
    /// Добавление переданного объекта в
    /// список наблюдателей.
    if (!observers.contains(subscribedObject)) {
      observers.add(subscribedObject);
    }

    /// Добавление объекта (this) в список
    /// наблюдаемых объектов переданного объекта.
    if (!subscribedObject.observables.contains(this)) {
      subscribedObject.observables.add(this);
    }
  }

  unSubscribe(SubscriptionMixin subscribedObject) {
    if (observers.contains(subscribedObject)) {
      observers.remove(subscribedObject);
    }
    if (subscribedObject.observables.contains(this)) {
      subscribedObject.observables.remove(this);
    }
  }
}
