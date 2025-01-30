enum MainRoutes {
  home,
  about,
  experience,
  projects,
  contact;

  String get path => '/${toString().split('.').last}';
}

enum ProjectRoutes {
  home,
  calculator,
  acharyahabba,
  asteroids;

  String get path => '/projects/${toString().split('.').last}';

  String get mainPath => '/${toString().split('.').last}';
}
