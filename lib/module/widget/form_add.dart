import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gql/language.dart';
import 'package:siswa_app/module/bloc/person_bloc.dart';
import 'package:siswa_app/module/view/home_page.dart';
import 'package:siswa_app/services/repository.dart';

class FormAddperson extends StatefulWidget {
  const FormAddperson({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormAddperson();
}

class _FormAddperson extends State<FormAddperson> {
  Repository repository = Repository();

  TextEditingController txtId = TextEditingController();

  TextEditingController txtName = TextEditingController();

  TextEditingController txtLastName = TextEditingController();

  TextEditingController txtAge = TextEditingController();

  _FormAddperson();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add'),
      content: BlocListener<PersonBloc, PersonState>(
        listener: (context, state) {
          if (state is PersonInitial) {
            buildLoading();
          } else if (state is PersonLoading) {
            buildLoading();
          } else if (state is PersonLoaded) {
            clearForm();
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Data Di simpan'),
              ),
            );
          } else if (state is PersonError) {
            const Text("Something went Wrong!!");
          } else {
            const Text("Something went Wrong!!");
          }
        },
        child: Container(
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
                  Container(
                    height: 80,
                    width: double.infinity,
                    color: Colors.white,
                    child: TextField(
                      maxLength: 5,
                      controller: txtId,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.perm_identity),
                        labelText: "ID",
                      ),
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
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            // context.read<PersonBloc>().add(
            //       AddPerson(
            //         id: txtId.text.trim(),
            //         name: txtName.text.trim(),
            //         lastName: txtLastName.text.trim(),
            //         age: int.parse(txtAge.text.trim()),
            //       ),
            //     );

            clearForm();
          },
          child: const Text("Add Siswa"),
        )
      ],
    );
  }

  void clearForm() {
    txtId.text = "";
    txtName.text = "";
    txtLastName.text = "";
    txtAge.text = "";
  }
}
