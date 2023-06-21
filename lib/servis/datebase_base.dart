
import 'package:gezi_uygulamam/model/user_model.dart';

abstract class DBbase {
  Future<bool> saveUser(MyUser user);
  Future<MyUser?> readUser(String userID);
  Future<bool> updateUserName(String userID, String yeniUserName);
}
