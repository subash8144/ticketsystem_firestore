import 'package:flutter/material.dart';
import 'package:ticketSystem/config/routes.dart';

class TicketSystemApp extends StatelessWidget {
  const TicketSystemApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: NavigationManager.routes,
    );
  }
}