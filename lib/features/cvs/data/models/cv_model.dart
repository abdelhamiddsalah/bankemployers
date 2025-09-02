class CVModel {
  final int id;
  final String cv; // ممكن يكون رابط PDF أو Base64

  CVModel({
    required this.id,
    required this.cv,
  });

  factory CVModel.fromJson(Map<String, dynamic> json) {
    return CVModel(
      id: json['id'] as int,
      cv: json['cv'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cv': cv,
    };
  }
}
