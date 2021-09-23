abstract class SQLCrud {
  Future<void> createEntry<T>(T entry);
  Future<void> deleteEntry(String entryID);
  Future<void> updateEntry<T>(T entry);
  Future<List<T>> fetchEntries<T>();
}
