

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Ticket ticketFromJson(String str) => Ticket.fromJson(json.decode(str));

String ticketToJson(Ticket data) => json.encode(data.toJson());

class Ticket {
  int id;
  String title;
  Timestamp date;
  String priority;
  String location;
  String attachments;
  int status;

  Ticket({required this.attachments,
      required this.location,
      required this.id,
      required this.title,
      required this.date,
      required this.priority,
      required this.status});

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    priority: json["priority"],
    location: json["location"],
    attachments: json["attachments"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date,
    "priority": priority,
    "location": location,
    "attachments": attachments,
    "status": status,
  };
}
