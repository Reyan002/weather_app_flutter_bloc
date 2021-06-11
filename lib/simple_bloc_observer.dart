
import 'package:bloc/bloc.dart';
class SimpleBlocObserver extends BlocObserver{

  @override
  void onEvent(Bloc bloc, Object event) {

    super.onEvent(bloc, event);
    print('On Event $event');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {

    print('On Error :$error');
    super.onError(bloc, error, stackTrace);

  }

  @override
  void onTransition(Bloc bloc, Transition transition) {

    super.onTransition(bloc, transition);
    print('On Transition $transition');
  }
}