import 'package:fullstack_socialmedia/app/data/Constants/constants.dart';
import 'package:fullstack_socialmedia/app/modules/home/Models/get_all_posts_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetAllPostsProvider extends GetConnect {
  Future<GetAllPosts?> getAllPosts() async {
    try {
      final response = await get(
        '${Constants.baseUrl}/api/posts/',
        headers: {'auth': await GetStorage().read(Constants.tokenKey)},
      );
      if (response.body != null) {
        if (response.status.isOk) {
          return getAllPostsFromJson(response.bodyString!);
        } else if (response.status.isServerError) {
          throw 'Server is not reachable\nPlease try again later';
        } else if (response.status.isNotFound) {
          throw 'Not Found!';
        } else if (response.status.isForbidden) {
          throw 'Bad request\nCheck data and try again...';
        } else {
          throw response.body['message'] ??
              response.bodyString ??
              'Unknown error';
        }
      } else {
        throw 'Something went wrong!\nPlease try again later';
      }
    } catch (e) {
      rethrow;
    }
  }
}
