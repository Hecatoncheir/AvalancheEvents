library stream_service_mixin;

//// TODO: Возможность отписываться и отписывать от себя наблюдателей
/// Mixin for events actions.
/// Object must contains Stream stream,
/// StreamController controller.
class StreamServiceMixin {
  Stream stream;
  StreamController controller;

  /// Список наблюдателей
  List<StreamService> observers = new List();

  /// Список наблюдаемых объектов
  List<StreamService> observables = new List();

  /// Добавление объектов в списки друг друга
  observable(StreamService stream) {
    /// Добавление переданного объекта в
    /// список наблюдателей.
    if (!observers.contains(stream)) {
      observers.add(stream);
    }

    /// Добавление объекта (this) в список
    /// наблюдаемых объектов переданного объекта.
    if (!stream.observables.contains(this)) {
      stream.observables.add(this);
    }
  }

  /// For dispatch event and put in evry observable
  /// Создание события и подписи к нему
  dispatchEvent(String message, [dynamic details]) {
    Map detail = new Map(); // Детали события
    detail['message'] = message;
    detail['details'] = details;

    /// Добавление события в свой собственный поток
    controller.add(detail);

    /// Когда наблюдаемый объект создает событие
    /// наблюдатели должны его получить.
    observers.forEach((StreamService stream) {
      if (!observables.contains(stream)) {
        stream.controller.add(detail);
      }
    });
  }

  /// Подписка на событие обработчика
  on(String message, Function handler) {
    /// Нужно слушать события каждого наблюдаемого объекта
    observables.forEach((StreamService streamService) {
      streamService.stream.listen((Map data) {
        /// Проверка подписи события
        if (data['message'] == message) {
          Map details = data['details'];

          /// Передача обработчику деталей события
          handler(details);
        }
      });
    });

    /// Иногда события внутри обекта не должны
    /// обрабатываться где-нибудь кроме
    /// как самим объектом.
    /// Обработчики события подписываются
    /// на собственный поток тоже.
    stream.listen((Map data) {
      if (data['message'] == message) {
        Map details = data['details'];
        handler(details);
      }
    });
  }
}
