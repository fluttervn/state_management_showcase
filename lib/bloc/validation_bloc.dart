import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class ValidationEvent extends Equatable {
  const ValidationEvent();

  @override
  List<Object> get props => [];
}

abstract class StartValidationEvent extends ValidationEvent {}

class ValidationBloc extends Bloc<ValidationEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(ValidationEvent event) async* {
    switch (event) {
      /*case ValidationEvent.decrement:
        yield state - 1;
        break;*/
      default:
        break;
    }
  }
}
