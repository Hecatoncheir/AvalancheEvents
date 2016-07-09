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
  observable(StreamService observableObjectStream) {
    /// Добавление переданного объекта в
    /// список наблюдателей.
    if (!observers.contains(observableObjectStream)) {
      observers.add(observableObjectStream);
    }

    /// Добавление объекта (this) в список
    /// наблюдаемых объектов переданного объекта.
    if (!observableObjectStream.observables.contains(streamService)) {
      observableObjectStream.observables.add(streamService);
    }
  }
}
