import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RateController extends GetxController {
  var rates = <Map<String, dynamic>>[].obs;
  Timer? _timer;

  final String apiUrl =
      'https://mocki.io/v1/cecbfe8b-7758-48b7-94b4-bde6e4cfdf3d';

  Future<void> fetchRates() async {
    try {
      final uri = Uri.parse(apiUrl);
      final response = await http.get(uri).timeout(const Duration(seconds: 8));

      print("API called: $apiUrl");
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['rates'] is List) {
          rates.value = List<Map<String, dynamic>>.from(data['rates']);
          print("Fetched rates: ${rates.length}");
        }
      } else {
        print("API returned error code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching rates: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchRates();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => fetchRates());
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
