class LikeModel {
  bool? like;
  String? id;
  String? postid;
  LikeModel.fromJson(Map<String, dynamic>json){
    like = json['like'];
    id = json['id'];
    postid =json['postid'];
  }
}

