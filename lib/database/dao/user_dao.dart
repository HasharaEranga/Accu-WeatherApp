
import 'package:moor_flutter/moor_flutter.dart';
import 'package:weather_app/database/database.dart';
import 'package:weather_app/database/models/user.dart';
part 'user_dao.g.dart';

@UseDao(tables: [Users])
class UserDao extends DatabaseAccessor<WeatherAppDatabase> with _$UserDaoMixin{
  UserDao(WeatherAppDatabase db): super(db);

  Future<int> insertUser(User u){
    return into(users).insert(u);
  }

  Future<List<User>> getUser(String username){
    return (select(users)..where((tbl) => tbl.username.equals(username))).get();
  }

  Future<int> getUserCount() async {
    var use = await select(users).get();
    return use.length;
  }

}