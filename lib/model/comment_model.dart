class CommentModel {
  String? comment;
  double ratingCharity = 0.0;
  String? time;

  CommentModel({
    this.comment,
    this.ratingCharity = 0.0,
    this.time,
  });

  CommentModel.fromJson(Map<String, dynamic> data) {
    Map<String, dynamic> json = data;
    comment = json['comment'];
    ratingCharity = json['ratingCharity'];
    time = json['time'];
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'ratingCharity': ratingCharity,
      'time': time,
    };
  }
}
