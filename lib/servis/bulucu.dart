import 'package:get_it/get_it.dart';
import 'package:gezi_uygulamam/depo/user_repository.dart';
import 'package:gezi_uygulamam/servis/fake_auth_servis.dart';
import 'package:gezi_uygulamam/servis/firebase_auth_servis.dart';
import 'package:gezi_uygulamam/servis/firestore_DB_servis.dart';

GetIt locator = GetIt.I; 

void setuoLocator(){
  locator.registerLazySingleton(() => FirebaseAuthServis());
  locator.registerLazySingleton(() => FakeAuthServis());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirestoreDBServis());




}