class GroupByModel<T> {
  GroupByModel({required this.title, required this.data,required this.exerciseID});
  final String exerciseID;
  final String title;
  final List<T> data;
}
