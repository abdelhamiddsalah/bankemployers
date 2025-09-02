class CvIdModel {
  final int id;
  final String file;
  final String resultCv;
  final String? copoun;
  final double? salary;
  final String? employer;

  CvIdModel({
    required this.id,
    required this.file,
    required this.resultCv,
    this.copoun,
    this.salary,
    this.employer,
  });

  factory CvIdModel.fromJson(Map<String, dynamic> json) {
    return CvIdModel(
      id: json['id'] as int,
      file: json['file'] as String,
      resultCv: json['resultCv'] as String,
      copoun: json['copoun'] as String?, // ممكن تكون null
      salary: (json['salary'] != null) ? (json['salary'] as num).toDouble() : null,
      employer: json['employer'] as String?, // ممكن تكون null
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
