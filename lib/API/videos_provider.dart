import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:youtubemultivideos/Models/video_model.dart';

import '../Utils/connectivity_utils.dart';

class VideosProvider {

   static Future<List<VideoModel>?> fetchVideos({
    required String url,
    int retries = 3,
    Function()? onLoading,
    Function(String)? onDone,
    Function(String)? onError,
    Function()? onNoInternetConnection,
  }) async {



    if (!await ConnectivityUtils.checkInternetConnection()) {
      onNoInternetConnection?.call();
      return null;
    }

    onLoading?.call();

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == "OK" && jsonResponse.containsKey('data')) {
          List<VideoModel> mediaList = (jsonResponse['data']['media'] as List)
              .map((newsJson) => VideoModel.fromJson(newsJson))
              .toList();

          for(VideoModel v in mediaList)
            dev.log("showVids:: $v");

          onDone?.call(jsonResponse['info']);
          return mediaList;
        } else {
          onError?.call(jsonResponse['info']);
          return null;
        }
      } else {
        onError?.call("Error fetching news: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // if (retries > 0) {
      //   await Future.delayed(Duration(seconds: 2));
      //   return fetchVideos(
      //     url: url,
      //     lang: lang,
      //     retries: retries - 1,
      //     onLoading: onLoading,
      //     onDone: onDone,
      //     onError: onError,
      //     onNoInternetConnection: onNoInternetConnection,
      //   );
      // }
      dev.log("VideosTryCatchErro:: ${e.toString()}");
      onError?.call("Something went wrong, try again");
      return null;
    }
  }
}
