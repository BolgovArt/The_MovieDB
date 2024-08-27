import 'package:vk/domain/data_providers/session_data_provider.dart';

class MyAppModel {
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async { // при async await функции присваивается само значение Future, без async await присваивался бы сам объект Future, который делал бессмысленной его проверку на null
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId != null && sessionId.isNotEmpty) {
      _isAuth = true;
    }
  }
}