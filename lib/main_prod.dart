import 'package:JWTAuthApp/environment.dart';

import 'main.dart' as App;

void main() {
  // set config to prod
  App.main(env: Environment.prod);
}
