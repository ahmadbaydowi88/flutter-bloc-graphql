import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:siswa_app/module/model/person_model.dart';
import 'package:siswa_app/services/graphql_service.dart';
import 'package:siswa_app/services/query_mutation.dart';

class Repository {
  final GraphQLClient _client = clientToQuery();

  Future<List<PersonModel>?> fetchAllpersons() async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(
          QueryMutation().getAll(),
        ),
      ),
    );
    if (!result.hasException) {
      List data = result.data!['persons'];
      List<PersonModel> persons = [];
      for (var e in data) {
        persons.add(
          PersonModel(
            id: e['id'],
            name: e['name'],
            lastName: e['lastName'],
            age: e['age'],
          ),
        );
      }
      return persons;
    }
  }

  Future<List<PersonModel>?> fetchAddpersons(
      {required String id,
      required String name,
      required String lastName,
      required int age}) async {
    List<PersonModel> persons = [];
    await _client.mutate(
      MutationOptions(
        document: gql(
          QueryMutation().addPerson(id, name, lastName, age),
        ),
        onCompleted: (data) {
          print(data['addPerson']['name']);
          // List<PersonModel> persons = [];
          persons.add(
            PersonModel(
              id: data['addPerson']['id'],
              name: data['addPerson']['name'],
              lastName: data['addPerson']['lastName'],
              age: data['addPerson']['age'],
            ),
          );
          print(persons);
        },
        onError: (error) => const Text("Samething wrong!!"),
      ),
    );
    return persons;
  }

  Future<List<PersonModel>?> fetchDeletePersons(
      {required String id,
      required String name,
      required String lastName,
      required int age}) async {
    await _client.mutate(
      MutationOptions(
        document: gql(
          QueryMutation().addPerson(id, name, lastName, age),
        ),
        onCompleted: (data) {
          print("data berhasil dihapus");
        },
        onError: (error) => const Text("Samething wrong!!"),
      ),
    );
  }
}
