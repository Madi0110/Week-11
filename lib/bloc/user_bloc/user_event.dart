abstract class UserEvent {}

class UserLoadEvent extends UserEvent {}

class UserChangeProfileEvent extends UserEvent {
  final String name;
  final String phone;

  UserChangeProfileEvent({required this.name, required this.phone});
}

class ReadOnlyEvent extends UserEvent {
  final bool currentBool;

  ReadOnlyEvent({required this.currentBool});
}

class ConfirmChangeEvent extends UserEvent {
  final bool currentBool;

  ConfirmChangeEvent({required this.currentBool});
}