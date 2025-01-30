import 'event_list.dart';
import 'event_register.dart';

class Ticket {
  final Event event;
  final RegistrationData registration;

  Ticket({
    required this.event,
    required this.registration,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        event: Event.fromJson(json['event']),
        registration: RegistrationData.fromJson(json['registration']),
      );
}
