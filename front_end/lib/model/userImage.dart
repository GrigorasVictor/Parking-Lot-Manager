class UserImage {
  final int userId;
  final String imageData;

  const UserImage({
    required this.userId,
    required this.imageData,
  });

  factory UserImage.fromJson(Map<String, dynamic> json){
    return UserImage(userId: json['user_id'] as int, 
    imageData: json['image'] as String);

  }

  Map<String, dynamic> toJson(){
    return {
      'user_id': userId,
      'image': imageData,
    };
  }
}