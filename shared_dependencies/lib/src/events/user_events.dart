/// Evento que se dispara cuando un usuario inicia sesión
class UserLoggedInEvent {
  final String userId;
  
  UserLoggedInEvent(this.userId);
}

/// Evento que se dispara cuando un usuario cierra sesión
class UserLogoutEvent {} 