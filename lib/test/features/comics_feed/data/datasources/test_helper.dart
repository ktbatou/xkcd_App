import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

//mock for the HTTP library so that it can simulate requests to the API during testing.
@GenerateMocks([], customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
