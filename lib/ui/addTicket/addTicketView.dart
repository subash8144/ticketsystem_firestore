import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ticketSystem/config/routes.dart';
import 'package:ticketSystem/ui/addTicket/addTicketViewModel.dart';
import 'package:ticketSystem/ui/dashBoard/DashBoardModel.dart';

class AddTicketView extends ConsumerStatefulWidget {
  const AddTicketView({super.key});

  @override
  ConsumerState<AddTicketView> createState() => _AddTicketViewState();
}

class _AddTicketViewState extends ConsumerState<AddTicketView> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController attachmentsController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final List<String> priorities = ['Low', 'Medium', 'High'];
  String priority = 'Low';

  @override
  void initState() {
    super.initState();
    dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      dateController.text = _dateFormatter.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        leading: IconButton(
         icon: const Icon(
         Icons.arrow_back_ios,
         color: Colors.black,
        ),
        onPressed: () => Navigator.pushNamed(context, AppRoutes.dashboard)),
        title: const Text(
          'Add Task',
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 18.0),
                          controller: titleController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: const TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (input) => input!.trim().isEmpty
                              ? 'Please enter a task title'
                              : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: dateController,
                          style: const TextStyle(fontSize: 18.0),
                          onTap: _handleDatePicker,
                          decoration: InputDecoration(
                            labelText: 'Date',
                            labelStyle: const TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 18.0),
                          controller: locationController,
                          decoration: InputDecoration(
                            labelText: 'Location',
                            labelStyle: const TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (input) => input!.trim().isEmpty
                              ? 'Please enter location'
                              : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 18.0),
                          controller: attachmentsController,
                          decoration: InputDecoration(
                            labelText: 'Attachments',
                            labelStyle: const TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (input) => input!.trim().isEmpty
                              ? 'Please enter attachment details'
                              : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: DropdownButtonFormField(
                          isDense: true,
                          icon: const Icon(Icons.arrow_drop_down_circle),
                          iconSize: 22.0,
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: priorities.map((String priority) {
                            return DropdownMenuItem(
                              value: priority,
                              child: Text(
                                priority,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            );
                          }).toList(),
                          style: const TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            labelText: 'Priority',
                            labelStyle: const TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              priority = value!;
                            });
                          },
                          value: priority,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        // ignore: deprecated_member_use
                        child: ElevatedButton(
                          onPressed: (){
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Ticket task = Ticket(
                                title: titleController.text,
                                date: Timestamp.fromDate(_date),
                                priority: priority,
                                attachments: attachmentsController.text,
                                location: locationController.text,
                                id: DateTime.now().millisecondsSinceEpoch,
                                status: 0,
                              );
                              ref.read(addTicketProvider).addTicket(task);
                              Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                            }
                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      /*Container(
                        margin: const EdgeInsets.symmetric(vertical: 0.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        // ignore: deprecated_member_use
                        child: ElevatedButton(
                          onPressed: _delete,
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
