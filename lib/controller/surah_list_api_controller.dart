import 'package:faithful_path/model/surah_list_model.dart';
import 'package:http/http.dart' as http;

class GetSurahList {
  Future<SurahListModel?> getSurahList(String url) async {
    var client = http.Client();
    var uri = Uri.parse(url);
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return surahListModelFromJson(json); // Assuming this returns List<SurahListModel>
    } else {
      return null;
    }
  }
}