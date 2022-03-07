import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siswa_app/module/bloc/person_bloc.dart';
import 'package:siswa_app/module/model/person_model.dart';
import 'package:siswa_app/module/widget/card_list.dart';
import 'package:siswa_app/module/widget/form_add.dart';
import 'package:siswa_app/module/widget/person_add_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFF),
      appBar: AppBar(
        title: const Text(
          'Daftar Siswa',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
      ),
      body: _builListPerson(),
      floatingActionButton: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PersonAddPage(),
              ));
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Tambah Siswa',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _addPerson(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        FormAddperson formAddPerson = const FormAddperson();
        return formAddPerson;
      },
    );
  }

  Widget _builListPerson() {
    return BlocBuilder<PersonBloc, PersonState>(
      builder: (context, state) {
        if (state is PersonInitial) {
          return buildLoading();
        } else if (state is PersonLoading) {
          return buildLoading();
        } else if (state is PersonLoaded) {
          return ListView.builder(
            itemCount: state.persons!.length,
            itemBuilder: (context, index) {
              return CardList(
                id: state.persons![index].id!,
                nama: state.persons![index].name!,
                lastName: state.persons![index].lastName!,
              );
            },
          );
        } else if (state is PersonError) {
          return const Text("Something went Wrong!!");
        } else {
          return const Text("Something went Wrong!!");
        }
      },
    );
  }
}

Widget buildLoading() => const Center(
      child: CircularProgressIndicator(),
    );
