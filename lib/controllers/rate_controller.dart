import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RateController extends GetxController {
  var rates = <Map<String, dynamic>>[].obs;
  Timer? _timer;

  final String apiUrl = '';

  Future<void> fetchRates() async {
    try {
      final uri = Uri.parse(apiUrl);
      final response = await http.get(uri).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['rates'] is List) {
          rates.value = List<Map<String, dynamic>>.from(data['rates']);
        }
      } else {}
    } catch (e) {
      print("The error is ${e}");
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
