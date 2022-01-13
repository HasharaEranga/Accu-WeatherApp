
import 'package:moor/moor.dart';

@DataClassName('User')
class Users extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text()();
  TextColumn get email => text()();
  TextColumn get mobile => text()();
  TextColumn get password => text()();

}