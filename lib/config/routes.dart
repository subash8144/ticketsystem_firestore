import 'package:flutter/material.dart';
import 'package:ticketSystem/ui/Splash/SplashView.dart';
import 'package:ticketSystem/ui/addTicket/addTicketView.dart';
import 'package:ticketSystem/ui/dashBoard/DashBoardView.dart';

class AppRoutes {
  static const String initial = '/';
  static const String dashboard = '/dashboard';
  static const String addTicket = '/addTicket';
}

class NavigationManager {
  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.initial: (context) => const SplashView(),
    AppRoutes.dashboard: (context) => const DashBoardView(),
    AppRoutes.addTicket: (context) => const AddTicketView(),
  };
}