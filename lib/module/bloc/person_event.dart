part of 'person_bloc.dart';

abstract class PersonEvent extends Equatable {
  const PersonEvent();

  @override
  List<Object> get props => [];
}

class LoadPerson extends PersonEvent {}

class AddPerson extends PersonEvent {
  final List<PersonModel>? persons;
  // final String id;
  // final String name;
  // final String lastName;
  // final int age;
  const AddPerson({required this.persons
      // required this.id,
      // required this.name,
      // required this.lastName,
      // required this.age,
      });
  @override
  List<Object> get props => [persons!];
}

class EditPerson extends PersonEvent {}

class DeletePerson extends PersonEvent {}
