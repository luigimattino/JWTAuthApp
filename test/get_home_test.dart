import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  test("HTTP HOME request", () async {
    //final result = await get(Uri.http("localhost:3000", "/"));
    final result = await get("http://127.0.0.1:3000/");
    expect(result.statusCode, 200);
  });
}
