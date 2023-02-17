import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './modules/movie/screens/moviesList_screen.dart';
import './modules/auth/screens/auth_screen.dart';
import './modules/auth/auth_provider.dart';
import './screens/splash_screen.dart';
import 'config/storage/app_storage.dart' show AppStorage;
import 'config/routes/routes.dart' show Routes;
import 'config/config.dart' as config;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppStorage.providers,
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          localizationsDelegates:
              config.AppLocalizations.localizationsDelegates,
          supportedLocales: config.AppLocalizations.supportedLocales,
          locale: const Locale('fa'),
          title: 'myMovies',
          theme: config.DefaultTheme.theme,
          home: auth.isAuth
              ? MoviesListScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: Routes.routes,
        ),
      ),
    );
  }
}
