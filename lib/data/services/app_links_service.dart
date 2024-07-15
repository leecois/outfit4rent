import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

class AppLinksService {
  late AppLinks _appLinks;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle links while app is running
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      debugPrint('onAppLink: $uri');
      openAppLink(uri);
    }, onError: (err) {
      debugPrint('Failed to receive uri link: $err');
    });
  }

  void openAppLink(Uri uri) {
    // Handle deep link and navigate
    _navigatorKey.currentState?.pushNamed(uri.path, arguments: uri.queryParameters);
  }

  void dispose() {
    _linkSubscription?.cancel();
  }

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}

final appLinksService = AppLinksService();
