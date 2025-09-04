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
    return AllCvSModel(
      id: json['id'] as int,
      file: json['file'] as String,
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
