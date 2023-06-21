import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gezi_uygulamam/rota/routa.dart';
import 'package:gezi_uygulamam/sayfalar/planPage/data/local_storage.dart';
import 'package:gezi_uygulamam/sayfalar/planPage/model/task_model.dart';
import 'package:gezi_uygulamam/servis/bulucu.dart';
import 'package:gezi_uygulamam/view_modeller/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<LocalStorage>(HiveLocalStorge());
}

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  // ignore: unused_local_variable
  var taskBox = await Hive.openBox<Task>('tasks');
  
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setuoLocator();
   await setupHive();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        title: 'Gezdim Gördüm',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.purple),
        initialRoute: '/',
        onGenerateRoute: MyRouter.generateRoute,
      ),
    );
  }
}
