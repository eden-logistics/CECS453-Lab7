import 'package:get_it/get_it.dart';
import 'package:lab7/repository/note_repository.dart';

final getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => NoteRepository());
}
