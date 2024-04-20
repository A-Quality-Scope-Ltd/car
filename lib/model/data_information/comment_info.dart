class CommentInfo {
  String? comment;
  double rating = 0.0;

  CommentInfo({
    this.comment,
    this.rating = 0.0,
  });

  CommentInfo.fromJson(data) {
   var json = data;
    comment = json['comment']??'';
    rating =  double.parse(json['rating'].toString()) ;
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'rating': rating,
    };
  }
}
