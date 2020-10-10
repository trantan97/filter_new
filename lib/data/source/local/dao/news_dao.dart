import 'package:filter_news/data/model/news.dart';
import 'package:floor/floor.dart';

@dao
abstract class NewsDao {
  @Query("SELECT * FROM $TABLE_NEWS")
  Stream<List<News>> getNewsAsStream();

  @delete
  Future<int> deleteNews(News news);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> addNews(News news);

  @Query("SELECT * FROM $TABLE_NEWS WHERE isFavorite = 1")
  Stream<List<News>> getFavoriteNewsAsStream();

  @update
  Future<int> updateNews(News news);
}
