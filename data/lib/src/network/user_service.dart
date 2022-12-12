// ignore_for_file: invalid_use_of_protected_member

import 'package:data/data.dart';
import 'package:data/src/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

@Singleton()
class UserService {
  Future<UserModel?> currentUser() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user == null) {
      return null;
    }
    return UserModel.fromJson(user.toJson());
  }

  Future<List<UserModel>> getUsersList({
    required int durationInMins,
    required DateTime fromDateTime,
    required DateTime toDateTime,
    String? nameSearch,
    required String sorting,
  }) async {
    final func = ParseCloudFunction("getUsers");
    final Map<String, dynamic> params = {
      'fromDate': fromDateTime.toUtc().toString(),
      'toDate': toDateTime.toUtc().toString(),
      'durationInMins': durationInMins,
      'sorting': sorting,
    };
    if (nameSearch != null && nameSearch.isNotEmpty) {
      params['nameSearch'] = nameSearch;
    }
    final res = await func.executeObjectFunction(parameters: params);
    if (res.success) {
      return (res.result['result'] as List<dynamic>)
          .map((e) => UserModel.fromJson((e as ParseUser).toJson(full: true)))
          .toList();
    }
    throw DefaultError(res.error?.message ?? 'something went wrong');
  }
}
