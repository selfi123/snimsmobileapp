import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_geolocation_test2/pages/signinpage.dart';
import 'package:flutter_geolocation_test2/pages/message_listener.dart';

class UserMainPage extends StatefulWidget {
  final String? selectedDutyTime;

  const UserMainPage({Key? key, this.selectedDutyTime}) : super(key: key);

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  final _auth = FirebaseAuth.instance;
  String _staffId = "";
  String? _selectedDutyTime;
  String _receivedMessage = '';
  String _userid="";

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _selectedDutyTime = widget.selectedDutyTime;
  }

  Future<void> _getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _staffId = user.email.toString().split('@').first;
        _userid=user.uid;
      });
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Home - $_staffId'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to the Home Page',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 5),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Selected Duty Time: ${_selectedDutyTime ?? 'Not Selected'}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageListener(userId: _userid),
                    ),
                  );
                },
                child: Text('View Messages'),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}