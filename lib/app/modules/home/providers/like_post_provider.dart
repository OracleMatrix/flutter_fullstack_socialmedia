import 'package:fullstack_socialmedia/app/data/Constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LikePostProvider extends GetConnect {
  Future likePost(Map<String, dynamic> data) async {
    try {
      final response = await post(
        '${Constants.baseUrl}/api/likes/',
        data,
        headers: {'auth': GetStorage().read(Constants.tokenKey)},
      );
      if (response.body != null) {
        if (response.status.isOk) {
          return response.body;
        } else if (response.status.isServerError) {
          throw 'Server is not reachable\nPlease try again later';
        } else if (response.status.isNotFound) {
          throw 'Not Found!';
        } else if (response.status.isForbidden) {
          throw 'Bad request\nCheck data and try again...';
        } else {
          throw response.body['message'] ?? response.bodyString;
        }
      } else {
        throw 'Something went wrong!\nPlease try again later';
      }
    } catch (e) {
      rethrow;
    }
  }
}
