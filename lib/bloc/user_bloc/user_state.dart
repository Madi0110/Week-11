abstract class UserState {}

class UserEmptyState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {}

class UserErrorState extends UserState {}

class UserChangedProfileState extends UserState {
  String message;
  UserChangedProfileState({required this.message});
}
