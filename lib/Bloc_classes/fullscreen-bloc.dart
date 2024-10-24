import 'package:flutter_bloc/flutter_bloc.dart';

// Define Events
abstract class FullScreenEvent {}

class EnterFullScreen extends FullScreenEvent {}

class ExitFullScreen extends FullScreenEvent {}

// Define States
class FullScreenState {
  final bool isFullScreen;

  FullScreenState({required this.isFullScreen});
}

// Create the Bloc
class FullScreenBloc extends Bloc<FullScreenEvent, FullScreenState> {
  FullScreenBloc() : super(FullScreenState(isFullScreen: false));

  @override
  Stream<FullScreenState> mapEventToState(FullScreenEvent event) async* {
    if (event is EnterFullScreen) {
      yield FullScreenState(isFullScreen: true);
    } else if (event is ExitFullScreen) {
      yield FullScreenState(isFullScreen: false);
    }
  }
}
