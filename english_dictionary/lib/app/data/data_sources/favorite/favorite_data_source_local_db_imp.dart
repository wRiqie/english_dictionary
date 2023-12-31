import 'favorite_data_source.dart';
import '../../models/word_model.dart';
import '../../models/paginable_model.dart';
import '../../models/favorite_model.dart';
import '../../services/local_db_service.dart';

class FavoriteDataSourceLocalDbImp implements FavoriteDataSource {
  final LocalDbService _localDbService;

  FavoriteDataSourceLocalDbImp(this._localDbService);

  @override
  Future<void> saveFavorite(FavoriteModel favorite) {
    return _localDbService.saveFavorite(favorite);
  }

  @override
  Future<void> deleteFavoriteByWordIdAndUserId(int wordId, String userId) {
    return _localDbService.deleteFavorite(wordId, userId);
  }

  @override
  Future<PaginableModel<WordModel>> getFavorites(
      String query, int? limit, int? offset, String userId) {
    return _localDbService.getWords(query, limit, offset, true, userId);
  }
}
