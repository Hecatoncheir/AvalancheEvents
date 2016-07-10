part of stream_service;

class ObservableMixin {
  Stream stream;
  StreamController controller;

  /// Список наблюдателей
  List<StreamService> observers = new List();

  /// Список наблюдаемых объектов
  List<StreamService> observables = new List();

  /// Ссылка на сам объект со свойствами observers и observables
  StreamService streamService;

  /// Добавление объектов в списки друг друга
  observable(ObservableMixin observableObject) {
    /// Добавление переданного объекта в
    /// список наблюдателей.
    if (!observers.contains(observableObject)) {
      observers.add(observableObject);
    }

    /// Добавление объекта (this) в список
    /// наблюдаемых объектов переданного объекта.
    if (!observableObject.observables.contains(streamService)) {
      observableObject.observables.add(streamService);
    }
  }

  /// Удаление наблюдателя за объектом эмитирующим события
  removeObserver(ObservableMixin observerObject) {
    if (observers.contains(observerObject)) {
      observers.remove(observerObject);
    }
    if (observerObject.observables.contains(streamService)) {
      observerObject.observables.remove(streamService);
    }
  }

  /// Отписка от событий наблюдаемого объекта
  removeObservable(ObservableMixin observableObject) {
    if (observables.contains(observableObject)) {
      observables.remove(observableObject);
    }
    if (observableObject.observers.contains(streamService)) {
      observableObject.observers.remove(streamService);
    }
  }
}
