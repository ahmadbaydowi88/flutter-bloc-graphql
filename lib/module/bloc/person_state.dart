part of 'person_bloc.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object> get props => [];
}

class PersonInitial extends PersonState {}

class PersonLoading extends PersonState {}

class PersonLoaded extends PersonState {
  final List<PersonModel>? persons;
  const PersonLoaded({
    this.persons,
  });
  @override
  List<Object> get props => [];
}

class SuccessSave extends PersonState {}

class PersonError extends PersonState {
  final String? message;
  const PersonError({this.message});
}
