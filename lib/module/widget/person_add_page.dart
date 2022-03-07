import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siswa_app/module/bloc/person_bloc.dart';
import 'package:siswa_app/module/model/person_model.dart';
import 'package:siswa_app/module/view/home_page.dart';
import 'package:siswa_app/services/repository.dart';

class PersonAddPage extends StatefulWidget {
  const PersonAddPage({Key? key}) : super(key: key);

  @override
  State<PersonAddPage> createState() => _PersonAddPageState();
}

class _PersonAddPageState extends State<PersonAddPage> {
  Repository repository = Repository();

  TextEditingController txtId = TextEditingController();

  TextEditingController txtName = TextEditingController();

  TextEditingController txtLastName = TextEditingController();

  TextEditingController txtAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Tambah Data Siswa',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Stack(
              children: <Widget>[
                TextField(
                  maxLength: 5,
                  controller: txtId,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.perm_identity),
                    labelText: "ID",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: TextField(
                    maxLength: 40,
                    controller: txtName,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.text_format),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 160.0),
                  child: TextField(
                    maxLength: 40,
                    controller: txtLastName,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.text_rotate_vertical),
                      labelText: "Last name",
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 240.0),
                  child: TextField(
                    maxLength: 2,
                    controller: txtAge,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Age', icon: Icon(Icons.calendar_today)),
                  ),
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 320.0),
                      child: BlocBuilder<PersonBloc, PersonState>(
                        builder: (context, state) {
                          if (state is PersonInitial) {
                            return buildLoading();
                          } else if (state is PersonLoading) {
                            return buildLoading();
                          } else if (state is PersonLoaded) {
                            return ElevatedButton(
                              onPressed: () async {
                                final persons =
                                    await repository.fetchAddpersons(
                                  id: txtId.text.trim(),
                                  name: txtName.text.trim(),
                                  lastName: txtLastName.text.trim(),
                                  age: int.parse(txtAge.text.trim()),
                                );
                                List<PersonModel> personModel = persons!;
                                print(personModel);
                                context.read<PersonBloc>().add(
                                      AddPerson(persons: persons),
                                    );
                                clearForm();
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("data ditambahkan"),
                                  ),
                                );
                              },
                              child: const Text("Tambah Data Siswa"),
                            );
                          } else if (state is PersonError) {
                            return const Text("Something went Wrong!!");
                          } else {
                            return const Text("Something went Wrong!!");
                          }
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearForm() {
    txtId.text = "";
    txtName.text = "";
    txtLastName.text = "";
    txtAge.text = "";
  }
}
