import 'package:event_bus/event_bus.dart';

class GlobalEventBus {
  static final EventBus _eventBus = EventBus();
  
  static EventBus get instance => _eventBus;
}

// Definición de eventos base
abstract class AppEvent {}

// Eventos de autenticación
class UserLoggedInEvent extends AppEvent {
  final String userId;
  UserLoggedInEvent(this.userId);
}

class UserLogoutEvent extends AppEvent {}

// Eventos de posts
class PostUpdatedEvent extends AppEvent {
  final String postId;
  PostUpdatedEvent(this.postId);
}

class PostCreatedEvent extends AppEvent {
  final String postId;
  PostCreatedEvent(this.postId);
}

class PostDeletedEvent extends AppEvent {
  final String postId;
  PostDeletedEvent(this.postId);
}

// Eventos de tema y lenguaje
class ThemeChangedEvent extends AppEvent {
  final bool isDarkMode;
  ThemeChangedEvent(this.isDarkMode);
}

class LanguageChangedEvent extends AppEvent {
  final String languageCode;
  LanguageChangedEvent(this.languageCode);
} 