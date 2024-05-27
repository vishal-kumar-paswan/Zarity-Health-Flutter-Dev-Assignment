import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "Main Navigator");
}
