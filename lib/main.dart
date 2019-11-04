import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:coffee_flutter_app/auth/repo.dart';
import 'package:coffee_flutter_app/cabinet/cabinet.dart';
import 'package:coffee_flutter_app/di/app_module.dart';
import 'package:coffee_flutter_app/lang/translator.dart';
import 'package:coffee_flutter_app/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'auth/bloc.dart';
import 'auth/event.dart';
import 'auth/state.dart';

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
      child: getIt.get<CoffeeApp>(),
    ),
  );
}

class CoffeeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "RoboCoffee",
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
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
