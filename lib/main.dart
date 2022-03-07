import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siswa_app/module/bloc/person_bloc.dart';
import 'package:siswa_app/module/view/home_page.dart';
import 'package:siswa_app/services/repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Repository repository = Repository();
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PersonBloc(repository: repository)..add(LoadPerson()),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocBuilder<PersonBloc, PersonState>(
            builder: (context, state) {
              return const Homepage();
            },
          )),
    );
  }
}
