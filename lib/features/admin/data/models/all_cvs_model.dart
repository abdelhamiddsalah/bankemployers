class AllCvSModel {
  final int id;
  final String file;
  final String resultCv;
  final String copoun;
  final double salary;
  final String? employer;

  AllCvSModel({
    required this.id,
    required this.file,
    required this.resultCv,
   required this.copoun,
   required this.salary,
  required  this.employer,
  });

  factory AllCvSModel.fromJson(Map<String, dynamic> json) {
      String filePath = json['file'] ?? '';
    String fileUrl = filePath.replaceFirst('static/', ''); // يشيل static/
    fileUrl = "http://localhost:8080/$fileUrl"; // يضيف baseUrl
    return AllCvSModel(
      id: json['id'] as int,
      file: fileUrl,
      resultCv: json['resultCv'] as String,
      copoun: json['copoun'] ??"",
      salary: (json['salary'] != null) ? (json['salary'] as num).toDouble() : 0.0,
      employer: json['employer'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file': file,
      'resultCv': resultCv,
      'copoun': copoun,
      'salary': salary,
      'employer': employer,
    };
  }
}
