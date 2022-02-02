import 'constants/http_exception.dart';
import 'models/mon_ets_user.dart';

/// A Wrapper for all calls to MonETS API.
abstract class IMonETSAPIClient {
  /// Authenticate the basic MonETS user
  ///
  /// Throws an [HttpException] if the MonETSApi return anything
  /// else than a 200 code
  Future<MonETSUser> authenticate(
      {required String username, required String password});
}
