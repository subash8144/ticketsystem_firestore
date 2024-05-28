import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticketSystem/ui/dashBoard/DashBoardModel.dart';

final ticketStreamProvider = StreamProvider<List<Ticket>>((ref) {
  return FirebaseFirestore.instance.collection('tickets').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Ticket.fromJson(doc.data())).toList();
  });
});