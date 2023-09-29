import 'package:english_dictionary/app/data/models/register_model.dart';

import '../../models/session_model.dart';
import 'auth_data_source.dart';

class AuthDataSourceMockImp implements AuthDataSource {
  @override
  Future<SessionModel> signin(String email, String password) {
    return Future.delayed(const Duration(seconds: 2), () {
      return _sessionMock;
    });
  }

  @override
  Future<SessionModel> signup(RegisterModel registerInfo) {
    return Future.delayed(const Duration(seconds: 2), () {
      return _sessionMock;
    });
  }

  final _sessionMock = SessionModel(
    name: 'Test User',
    email: 'test123@gmail.com',
    photoUrl:
        'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
    expirationDate: DateTime.now().add(
      const Duration(days: 7),
    ),
  );
}
