class ToDoViewModel {
  int? id;
  bool? isCompleted;
  bool? isPublic;
  String? title;
  String? createdAt;

  ToDoViewModel(
      {this.id, this.isCompleted, this.isPublic, this.title, this.createdAt});

  ToDoViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isCompleted = json['is_completed'];
    isPublic = json['is_public'];
    title = json['title'];
    createdAt = json['created_at'];
  }
}