import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<BottomIndexEvent, int> {
  int _index;

  NavigationBloc(this._index) : super(0);

  @override
  Stream<int> mapEventToState(BottomIndexEvent event) async* {
    if (event is IndexEvent) {
      _index = event.index;
      yield _index;
    }
  }
}

abstract class BottomIndexEvent {}

class IndexEvent extends BottomIndexEvent {
  final int index;
  IndexEvent({required this.index});
}