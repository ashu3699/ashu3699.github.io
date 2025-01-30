import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../models/ticket_list.dart';
import '../provider/indicator_provider.dart';
import '../services/api_service.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/ticket_widget.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  String? token;
  PageController? controller = PageController();

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);

    _requestPermission();
  }

  _requestPermission() async {
    await Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IndicatorProvider(),
      child: Scaffold(
        backgroundColor: const Color(0xffe4e4e4),
        appBar: customAppBar(context),
        body: FutureBuilder<List<Ticket>>(
          future: ApiService.getAllTickets(token),
          builder: (context, snapshot) {
            final tickets = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(child: Text('Loading...'));
                } else if (tickets!.isEmpty) {
                  return const Center(
                    child: Text(
                      "You haven't registered on any events\nRegister to display tickets",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
                return Column(
                  children: [
                    Consumer<IndicatorProvider>(
                      builder: (context, indicator, child) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 50,
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  for (int i = 0; i < tickets.length; i++)
                                    Container(
                                      width: 18,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: i == indicator.index
                                            ? getColor(tickets[i])
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: getColor(tickets[i]),
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          height: 700,
                          child: PageView.builder(
                            controller: controller,
                            onPageChanged: (index) {
                              Provider.of<IndicatorProvider>(context,
                                      listen: false)
                                  .setIndex(index);
                            },
                            physics: const BouncingScrollPhysics(),
                            itemCount: tickets.length,
                            itemBuilder: (context, index) {
                              Ticket ticket = tickets[index];
                              return ticketWidget(context, ticket);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }

  Color getColor(Ticket ticket) {
    switch (ticket.registration.status) {
      case 'pending':
        return const Color(0xffff9900);
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'refunded':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
