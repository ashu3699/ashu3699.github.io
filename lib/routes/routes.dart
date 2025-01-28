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
  asteroids;

  String get path => '/projects/${toString().split('.').last}';
}
