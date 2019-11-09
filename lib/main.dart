import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:coffee_flutter_app/auth/auth_repo.dart';
import 'package:coffee_flutter_app/cabinet/cabinet.dart';
import 'package:coffee_flutter_app/di/app_module.dart';
import 'package:coffee_flutter_app/lang/translator.dart';
import 'package:coffee_flutter_app/splash.dart';
import 'package:coffee_flutter_app/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'auth/auth_bloc.dart';
import 'auth/auth_event.dart';
import 'auth/auth_state.dart';

void main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  GetIt getIt = GetIt.instance;
  registerAppModule();

  runApp(
    BlocProvider<AuthBloc>(
      builder: (context) {
        return AuthBloc(authRepository: getIt.get<AuthRepository>())
          ..add(AppStarted());
      },
      child: CoffeeApp(),
    ),
  );
}

class CoffeeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "RoboCoffee",
        theme: appTheme,
        supportedLocales: [
          Locale('ru', 'RU'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: [
          Translator.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          //На ios в симуляторе баг с локалями
          if (Platform.isAndroid) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale?.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }
          }

          return supportedLocales.first;
        },
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthUninitialized) {
              return SplashScreen();
            }

            if (state is AuthLoading) {
              return LoadingIndicator();
            }

            return CabinetScreen(title: "RoboCoffee");
          },
        ));
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(),
      );
}
