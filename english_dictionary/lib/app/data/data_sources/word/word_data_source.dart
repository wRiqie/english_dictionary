import 'package:english_dictionary/app/data/models/paginable_model.dart';
import 'package:english_dictionary/app/data/models/word_model.dart';

abstract class WordDataSource {
  // Future<void> updateWord(WordModel word);

  Future<PaginableModel<WordModel>> getWords(
      String query, int? limit, int? offset, String userId);
}
