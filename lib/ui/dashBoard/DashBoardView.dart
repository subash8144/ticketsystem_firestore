import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ticketSystem/config/routes.dart';
import 'package:ticketSystem/ui/dashBoard/DashBoardViewModel.dart';

class DashBoardView extends ConsumerWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickets = ref.watch(ticketStreamProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: const Icon(Icons.add_outlined),
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.addTicket),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        automaticallyImplyLeading: false,
        title: const Text(
          "Thiran Ticket system",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
            letterSpacing: -1.2,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: tickets.when(
        data: (ticketList) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            itemCount: ticketList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: <Widget>[
                    if (ticketList[index].status == 0)
                      ListTile(
                        title: Text(
                          ticketList[index].title,
                          style: TextStyle(
                            fontSize: 18.0,
                            decoration: ticketList[index].status == 0
                                ? TextDecoration.none
                                : TextDecoration.lineThrough,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat('yyyy-MM-dd HH:mm').format(ticketList[index].date.toDate()),
                          style: TextStyle(
                            fontSize: 15.0,
                            decoration: ticketList[index].status == 0
                                ? TextDecoration.none
                                : TextDecoration.lineThrough,
                          ),
                        ),
                        trailing: Checkbox(
                          onChanged: (value) {
                            ticketList[index].status = value! ? 1 : 0;
                          },
                          activeColor: Theme.of(context).primaryColor,
                          value: ticketList[index].status == 1 ? true : false,
                        ),
                        onTap: () {},
                      ),
                    //Divider(),
                  ],
                ),
              );
            },
          );
        },
        error: (err, s) => Center(
          child: Text(
            err.toString(),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
