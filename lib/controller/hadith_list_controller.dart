import 'package:faithful_path/model/hadith_list_model.dart';
import 'package:http/http.dart' as http;


class GetHadithList {
  Future<List<HadithListModel>?> getHadithList(String url) async {
    var client = http.Client();
    var uri = Uri.parse(url);
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return hadithListModelFromJson(json); // Assuming this returns List<HadithListModel>
    } else {
      return null;
    }
  }

  Future<List<HadithListModel>?> getCombinedHadithList() async {
    var url1 = 'https://alquranbd.com/api/hadith/bukhari/1/1';
    var url2 = 'https://alquranbd.com/api/hadith/bukhari/2/1';

    var hadithList1 = await getHadithList(url1);
    var hadithList2 = await getHadithList(url2);

    if (hadithList1 != null && hadithList2 != null) {
      return [...hadithList1, ...hadithList2];
    } else {
      return null;
    }
  }
}
