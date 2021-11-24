import 'package:flutter_7food_courier/bloc/user_bloc/user_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadOnlyBloc extends Bloc<UserEvent, bool>{
  bool _bool = true;

  ReadOnlyBloc(this._bool) : super(true);

  @override
  Stream<bool> mapEventToState(UserEvent event) async* {
    if (event is ReadOnlyEvent) {
      _bool = event.currentBool;
      yield _bool;
    }
  }

}
