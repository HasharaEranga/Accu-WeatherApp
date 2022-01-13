import 'package:moor_flutter/moor_flutter.dart';
import 'package:weather_app/database/dao/user_dao.dart';
import 'models/user.dart';
part 'database.g.dart';

@UseMoor(tables: [Users],daos: [UserDao])
class WeatherAppDatabase extends _$WeatherAppDatabase {
  WeatherAppDatabase(): super(FlutterQueryExecutor.inDatabaseFolder (path: 'weatherapp.db',logStatements: true) );

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;

}