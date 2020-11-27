import 'dart:convert';
import 'package:JWTAuthApp/models/auth_error.dart';
import 'package:JWTAuthApp/models/resource_response.dart';

import '../../app_config.dart';
import 'package:http/http.dart';

class ResourceService {
  String apiUrl = "";
  final String _resourcesPath = '/resources';

  ResourceService({this.apiUrl});

  Map<String, String> headers = {
    "Accept": "application/json",
    "Connection": "keep-alive",
    "Content-type": "application/x-www-form-urlencoded",
  };

  Future<dynamic> doResources(String accessToken) async {
    String url = apiUrl ?? AppConfig().get('apiUrl');
    url += _resourcesPath;
    headers["Authorization"] = 'Bearer $accessToken';
    Response res = await get(url, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> bodyRes = jsonDecode(res.body);
      ResourcesResponse resources = ResourcesResponse.fromJson(bodyRes);
      return resources;
    } else if (res.statusCode == 401 || res.statusCode == 403) {
      Map<String, dynamic> bodyRes = jsonDecode(res.body);
      AuthError error = AuthError.fromJson(bodyRes);
      return error;
    } else {
      throw "resources fails!";
    }
  }
}
