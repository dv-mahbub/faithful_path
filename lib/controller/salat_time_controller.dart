import 'package:faithful_path/model/salat_time_model.dart';
import 'package:http/http.dart' as http;

class GetSalatTime {
  Future<SalatTimeModel?> getSalatTime(String url) async {
    var client = http.Client();
    print(url);
    var uri = Uri.parse(url);
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return salatTimeModelFromJson(json); // Assuming this returns List<SurahListModel>
    } else {
      return null;
    }
  }
}