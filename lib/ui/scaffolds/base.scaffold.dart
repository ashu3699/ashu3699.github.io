import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;

  const BaseScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    if (size.width > 600) {
      return websiteView(context);
    } else {
      return mobileView(context);
    }
  }

  static const TextStyle textStyle =
      TextStyle(color: Colors.white, fontSize: 24);

  Widget mobileView(BuildContext context) {
    return BackdropScaffold(
      appBar: BackdropAppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        shadowColor: Colors.black,
        title: const Text('My Portfolio'),
        automaticallyImplyLeading: false,
        actions: [BackdropToggleButton(icon: AnimatedIcons.list_view)],
      ),
      frontLayerScrim: Colors.black,
      backLayerBackgroundColor: Colors.black,
      frontLayerBackgroundColor: Colors.black,
      stickyFrontLayer: true,
      frontLayer: child,
      backLayer: BackdropNavigationBackLayer(
        items: [
          ListTile(
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () => context.go('/'),
          ),
          ListTile(
            title: const Text('About', style: TextStyle(color: Colors.white)),
            onTap: () => context.go(MainRoutes.about.path),
          ),
          ListTile(
            title:
                const Text('Experience', style: TextStyle(color: Colors.white)),
            onTap: () => context.go(MainRoutes.experience.path),
          ),
          ListTile(
            title:
                const Text('Projects', style: TextStyle(color: Colors.white)),
            onTap: () => context.go(MainRoutes.projects.path),
          ),
          ListTile(
            title: const Text('Contact', style: TextStyle(color: Colors.white)),
            onTap: () => context.go(MainRoutes.contact.path),
          ),
        ],
      ),
    );
  }

  Widget websiteView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        shadowColor: Colors.black,
        title: const Text(
          'Ashutosh Kumar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.go('/'),
            child: const Text('Home', style: textStyle),
          ),
          TextButton(
            onPressed: () => context.go(MainRoutes.about.path),
            child: const Text('About', style: textStyle),
          ),
          TextButton(
            onPressed: () => context.go(MainRoutes.experience.path),
            child: const Text('Experience', style: textStyle),
          ),
          TextButton(
            onPressed: () => context.go(MainRoutes.projects.path),
            child: const Text('Projects', style: textStyle),
          ),
          TextButton(
            onPressed: () => context.go(MainRoutes.contact.path),
            child: const Text('Contact', style: textStyle),
          ),
        ],
      ),
      body: child,
    );
  }
}
