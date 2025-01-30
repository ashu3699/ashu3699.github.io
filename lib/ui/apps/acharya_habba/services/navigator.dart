import 'package:flutter/material.dart';
// import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';

import '../models/event_list.dart';
import '../pages/dev_page.dart';
import '../pages/event_category_page.dart';
import '../pages/event_date_list.dart';
import '../pages/event_page.dart';
import '../pages/home_page.dart';
import '../pages/instagram_page.dart';
import '../pages/profile_page.dart';
import '../pages/sign_in.dart';
import '../pages/sign_up.dart';
import '../pages/ticket_page.dart';
import '../pages/verify_email.dart';
import '../provider/indicator_provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomePage());
      case '/sign_in':
        return MaterialPageRoute(builder: (context) => const SignInPage());
      case '/sign_up':
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case '/profile':
        return MaterialPageRoute(builder: (context) => const ProfilePage());
      case '/dev':
        return MaterialPageRoute(builder: (context) => const DevelopersPage());
      // case '/forgot_password':
      //   return MaterialPageRoute(
      //       builder: (context) => const ForgotPasswordScreen());
      case '/verify_email':
        return MaterialPageRoute(builder: (context) => const VerifyEmailPage());
      case '/event_list':
        return MaterialPageRoute(builder: (context) => const EventListPage());
      case '/event_category':
        return MaterialPageRoute(
            builder: (context) => const EventCategoryListPage());
      case '/event_page':
        return MaterialPageRoute(
            builder: (context) =>
                EventPage(event: settings.arguments as Event));
      case '/my_events':
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => IndicatorProvider(),
            child: const TicketPage(),
          ),
        );
      case '/instagram':
        return MaterialPageRoute(builder: (context) => const InstagramPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('404 PAGE NOT FOUND'),
        ),
      );
    });
  }
}
