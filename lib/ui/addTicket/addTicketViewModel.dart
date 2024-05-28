import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticketSystem/ui/dashBoard/DashBoardModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;



class AddTicketController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String token = '';

  Future<void> addTicket(Ticket ticket) async {
    try {
      await _firestore.collection('tickets').add({
        'id': ticket.id,
        'title': ticket.title,
        'date': ticket.date,
        'priority': ticket.priority,
        'location': ticket.location,
        'attachments': ticket.attachments,
        'status': ticket.status,
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error adding ticket: $e');
      }
    }
  }

  getDeviceToken() async{
    await FirebaseMessaging.instance.getToken().then((value) {
      token = value!;
    });
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body = json.encode({
      "to": token,
      "notification": {
        "title": "Your Ticket has been created successfully",
        "content_available": true,
        "sound": "default"
      },
      "data": {},
      "android": {
        "priority": "high"
      },
      "apns": {
        "headers": {
          "apns-priority": "10"
        }
      }
    });
    request.headers.addAll(headers);
    await Future.delayed(const Duration(minutes: 1));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
}

final addTicketProvider = Provider((ref) => AddTicketController());