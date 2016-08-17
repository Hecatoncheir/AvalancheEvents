part of avalanche_events;

class ObservableMixin {
  /// Список наблюдателей
  List observers = new List();

  /// Список наблюдаемых объектов
  List observables = new List();

  /// Добавление объектов в списки друг друга
  observable(ObservableMixin observableObject) {
    /// Добавление переданного объекта в
    /// список наблюдателей.
    if (!observers.contains(observableObject)) {
      observers.add(observableObject);
    }

    /// Добавление объекта (this) в список
    /// наблюдаемых объектов переданного объекта.
    if (!observableObject.observables.contains(this)) {
      observableObject.observables.add(this);
    }
  }

  /// Удаление наблюдателя за объектом эмитирующим события
  removeObserver(ObservableMixin observerObject) {
    if (observers.contains(observerObject)) {
      observers.remove(observerObject);
    }
    if (observerObject.observables.contains(this)) {
      observerObject.observables.remove(this);
    }
  }

  /// Отписка от событий наблюдаемого объекта
  removeObservable(ObservableMixin observableObject) {
    if (observables.contains(observableObject)) {
      observables.remove(observableObject);
    }
    if (observableObject.observers.contains(this)) {
      observableObject.observers.remove(this);
    }
  }
}
