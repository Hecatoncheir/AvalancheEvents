part of stream_service;

/// Миксин для создания события с подписью
/// и разсылки их объеектам-наблюдателям.
/// Объект может иметь список событий на которые может реагировать
/// и тогда наблюдаемые объекты перед отправкой события будут
/// проверять необходимость этого события для этого объекта.
class NotifyMixin {
  Stream stream;
  StreamController controller;

  /// Может содержать список наблюдателей
  List observers;

  /// Список ожидаемых объектом событий
  List<String> treatmentEvents = new List();

  /// Список создаваемых объектом событий
  List<String> generatedEvents = new List();

  /// Проверка stream и controller.
  /// Если поток еще не создан
  /// нужно инициализировать
  /// контроллер и его поток.
  void checkStream() {
    if (this.stream == null) {
      if (this.controller == null) {
        this.controller = new StreamController();
      }
      this.stream = controller.stream.asBroadcastStream();
    }
  }

  /// Создание события и подписи к нему.
  /// Распространение события каждому наблюдающему объекту
  /// в случае если у наблюдающего обьекта есть обработчик
  /// для этого события который отмечен в treatmentEvents списке.
  /// Так же если есть обработчик внутри объекта создавшего событие
  /// событие публикуется и в его поток.
  /// Поведение похожее на паттерн Mediator.
  dispatchEvent(String message, [dynamic details]) {
    Map detail = new Map(); // Детали события
    detail['message'] = message;
    detail['details'] = details;

    checkStream(); // Проверка потока и его контроллера

    /// Добавление подписи события в
    /// список создаваемых объектом событий.
    if (!generatedEvents.contains(message)) {
      generatedEvents.add(message);
    }

    /// Добавление события в свой собственный поток.
    /// Иногда события внутри обекта не должны
    /// обрабатываться где-нибудь кроме
    /// как самим объектом.
    if (treatmentEvents.contains(message)) {
      this.controller.add(detail);
    }

    /// Наблюдателей может не оказаться и события
    /// будут опубликованны только в свой поток.
    try {
      /// Когда наблюдаемый объект создает событие
      /// наблюдатели должны его получить.
      if (this.observers != null && this.observers is List) {
        this.observers.forEach((NotifyMixin observableObject) {
          if (observableObject.treatmentEvents.contains(message)) {
            observableObject.controller.add(detail);
          }
        });
      }
    } catch (error) {
      print("Object doesn't have observers");
    }
  }

  /// Подписка на событие обработчика
  on(String message, Function handler) {
    checkStream(); // Проверка потока и его контроллера

    /// Добавление подписи обрабатываемого события в
    /// список ожидаемых объектом событий.
    /// Нужно проверять этот список объектов
    /// наблюдателей переод отправкой события.
    if (!treatmentEvents.contains(message)) {
      treatmentEvents.add(message);
    }

    /// Обработчики события подписываются
    /// на собственный поток.
    /// Потому как сюда будут публиковаться события
    /// из наблюдаемых объектов.
    this.stream.listen((Map data) {
      if (data['message'] == message) {
        if (data['details'] != null) {
          var details = data['details'];
          handler(details);
        } else {
          handler(data);
        }
      }
    });
  }
}
