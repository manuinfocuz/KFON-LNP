import '../data_model/auth/remembered_login_model.dart';
import '../helper/remembered_login_db.dart';

class RememberedLoginRepository {
  final RememberedLoginDb _db = RememberedLoginDb.instance;

  /// Saves the login, or replaces the password when the username exists.
  Future<void> save(String username, String password) =>
      _db.upsert(username, password);

  /// Refreshes the password only when the username is already remembered.
  Future<void> refreshIfRemembered(String username, String password) =>
      _db.updateIfExists(username, password);

  Future<List<RememberedLogin>> getAll() => _db.getAll();

  Future<void> remove(String username) => _db.delete(username);
}
