import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'environment.dart';

class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal() {}

  Map<String, dynamic> appConfig = Map<String, dynamic>();
  dynamic get(String key) => appConfig[key];

  Future<AppConfig> forEnvironment(String env) async {
    // set default to dev if nothing was passed
    env = env ?? Environment.dev;

    appConfig['environment'] = env;

    // load the json file
    final contents = await rootBundle.loadString(
      'config/$env.json',
    );

    // decode our json
    Map<String, dynamic> configAsMap = json.decode(contents);

    // internal config
    Color primaryColor;
    switch (env) {
      case Environment.dev:
        primaryColor = Colors.blue;
        break;
      case Environment.prod:
        primaryColor = Colors.red;
        break;
    }
    configAsMap['primaryColor'] = primaryColor;
    appConfig.addAll(configAsMap);

    return _instance;
  }
}
