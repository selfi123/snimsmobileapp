import 'package:flutter/material.dart';
import 'package:flutter_geolocation_test2/pages/geolocationpage.dart'; // Import GeolocationApp
import 'package:flutter_geolocation_test2/pages/userpage.dart';

class DutyTime extends StatefulWidget {
  const DutyTime({Key? key, this.initialDutyTime, this.onChanged}) : super(key: key);

  final String? initialDutyTime;
  final Function(String?)? onChanged; // Callback function type

  @override
  State<DutyTime> createState() => _DutyTimeState();
}

class _DutyTimeState extends State<DutyTime> {
  late String? _selectedDutyTime;
  final GeolocationApp geolocationApp = GeolocationApp();
  String _currentLocation="";

  @override
  void initState() {
    super.initState();
    _selectedDutyTime = widget.initialDutyTime;
  }

  Future<void> _getCurrentLocation() async {
    await geolocationApp.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: 379.4, maxHeight: double.infinity),
    child:  Scaffold(
      appBar: AppBar(
        title: const Text("Current Duty Time"),
        centerTitle: true,
        backgroundColor: Colors.red, // Change the background color
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/back1.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch, // Make children stretch horizontally
                children: [
                  const Text(
                    'Please select your duty time:',
                    style: TextStyle(fontSize: 20, color: Colors.black,
                    fontWeight: FontWeight.bold), // Change text color
                    textAlign: TextAlign.center, // Center-align the text
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _selectedDutyTime,
                    items: const [
                      DropdownMenuItem(value: 't1(6.00 am)', child: Text('t1(6.00 am)')),
                      DropdownMenuItem(value: 't2(8.00 am)', child: Text('t2(8.00 am)')),
                      DropdownMenuItem(value: 't3(9.30 am)', child: Text('t3(9.30 am)')),
                    ],

                    hint: const Text('Select Duty Time', style: TextStyle(color: Colors.white)), // Change hint text color
                    onChanged: (value) {
                      setState(() {
                        _selectedDutyTime = value;
                        widget.onChanged?.call(value); // Call callback if provided
                      });
                    },

                  ),
                  const SizedBox(height: 30),
                 /* ElevatedButton(
                    onPressed: _getCurrentLocation,
                    child: const Text("Get Current Location"),
                  ),*/
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedDutyTime == null) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Please select a duty time.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserMainPage(selectedDutyTime: _selectedDutyTime)),
                        );
                      }
                    },
                    child: const Text("Submit"),
                  ),

                ],
              ),
            ),
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
                // Handle tap on home menu item
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                // Handle tap on about menu item
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Handle tap on logout menu item
              },
            ),
          ],
        ),
      ),
    ),
    );
  }

}

