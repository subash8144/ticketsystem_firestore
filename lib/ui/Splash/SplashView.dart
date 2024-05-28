import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ticketSystem/config/routes.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {



  @override
  void initState() {
    Timer(
        const Duration(seconds: 1),
            () => Navigator.pushReplacementNamed(context, AppRoutes.dashboard));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                        radius: 40.0,
                        child: Icon(
                          Icons.check_rounded,
                          color: Color(0xFF18D191),
                          size: 60.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        "Ticketing App",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      //CircularProgressIndicator(backgroundColor: Colors.grey),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Text(
                        "Thiran Technologies",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17.0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 60.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
