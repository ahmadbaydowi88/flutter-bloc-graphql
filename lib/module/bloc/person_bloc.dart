import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siswa_app/module/model/person_model.dart';
import 'package:siswa_app/services/repository.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final Repository repository;
  PersonBloc({required this.repository}) : super(PersonInitial()) {
    on<LoadPerson>(_onLoadPerson);
    on<AddPerson>(_onAddPerson);
    on<EditPerson>(_onEditPerson);
    on<DeletePerson>(_onDeletePerson);
  }

  void _onLoadPerson(LoadPerson event, Emitter<PersonState> emit) async {
    final persons = await repository.fetchAllpersons();
    emit(
      PersonLoaded(persons: persons),
    );
  }

  void _onAddPerson(AddPerson event, Emitter<PersonState> emit) async {
    final state = this.state;
    if (state is PersonLoaded) {
      emit(
        PersonLoaded(
          persons: state.persons!..addAll(event.persons!),
        ),
      );
    }
  }

  void _onEditPerson(EditPerson event, Emitter<PersonState> emit) async {}

  void _onDeletePerson(DeletePerson event, Emitter<PersonState> emit) async {}
}
