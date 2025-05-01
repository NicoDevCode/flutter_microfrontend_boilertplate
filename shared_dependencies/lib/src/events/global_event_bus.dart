import 'package:event_bus/event_bus.dart';

/// Bus de eventos global para comunicación entre módulos
class GlobalEventBus {
  /// Instancia singleton del bus de eventos
  static final GlobalEventBus instance = GlobalEventBus._();
  
  /// EventBus subyacente
  final EventBus _eventBus = EventBus();
  
  GlobalEventBus._();
  
  /// Emite un evento para todos los oyentes
  void fire(event) {
    _eventBus.fire(event);
  }
  
  /// Registra un oyente para un tipo específico de evento
  Stream<T> on<T>() {
    return _eventBus.on<T>();
  }
} 