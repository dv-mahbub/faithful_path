import 'package:faithful_path/model/surah_view_model.dart';
import 'package:http/http.dart' as http;

class GetSurahDetails {
  Future<SurahViewModel?> getSurahDetails(String url) async {
    var client = http.Client();
    var uri = Uri.parse(url);
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return surahViewModelFromJson(json); // Assuming this returns List<SurahListModel>
    } else {
      return null;
    }
  }
}