
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/database/dao/user_dao.dart';
import 'package:weather_app/database/database.dart';
import 'package:weather_app/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ToDo: Create Data Access Object
  UserDao userDao;
  WeatherAppDatabase weatherAppDatabase;

  // ToDo: Create Text Editing Controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    weatherAppDatabase = Provider.of<WeatherAppDatabase>(context);
    userDao = weatherAppDatabase.userDao;

  }

  // ToDo: Body of the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Accu-Weather App',style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Lato',fontWeight: FontWeight.bold)),
        elevation: 0,
        automaticallyImplyLeading: false, // ToDo: Removing back icon

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('User Login..!!',textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontFamily: 'Roboto',fontWeight: FontWeight.bold, fontSize: 30),),
            SizedBox(
             height: 30,
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: 'Enter Username:',
                hintStyle: TextStyle(fontFamily: 'Lato',color: Colors.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: 'Enter Password:',
                hintStyle: TextStyle(fontFamily: 'Lato',color: Colors.black),
              ),
              maxLength: 20,
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'If You have not registered to the system',
                  style: TextStyle(
                    fontSize: 14, color: Colors.black54, fontWeight: FontWeight.bold
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' Register',
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return RegistrationScreen();
                        },),);
                      },
                      style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // ToDo: Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
              child: ElevatedButton(onPressed: () async{
                List<User> userlist = await userDao.getUser(usernameController.text);
                if(passwordController.text == userlist[0].password){
                  Navigator.pushReplacementNamed(context, 'home');
                }
                else{
                  print('Login Fail..!!');
                }
              },
                child: Text('Login'),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.teal)
                ),
              ),
              ),
          ],
        ),
      ),
    );
  }
}
