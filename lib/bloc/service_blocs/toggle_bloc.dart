import 'package:flutter_bloc/flutter_bloc.dart';

enum ColorEvent {event_left, event_right}

class ToggleBloc extends Bloc<ColorEvent, bool> {
  bool _bool;

  ToggleBloc(this._bool) : super(false);

  @override
  Stream<bool> mapEventToState(ColorEvent event) async* {
    if (event == ColorEvent.event_left) {
      _bool = true;
      yield _bool;
    } else {
      _bool = false;
      yield _bool;
    }

  }

}