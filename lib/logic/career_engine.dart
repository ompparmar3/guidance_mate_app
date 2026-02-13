import '../models/counseling_data.dart';

class CareerEngine {
  static List<String> getCareers(CounselingData d) {
    Map<String, int> score = {};

    void add(String career, int value) {
      score[career] = (score[career] ?? 0) + value;
    }

    if (d.interests.contains("Technology")) add("Software Engineer", 5);
    if (d.interests.contains("Business")) add("Business Analyst", 5);
    if (d.interests.contains("Creativity")) add("Designer", 5);
    if (d.interests.contains("Helping People")) add("Doctor/Nurse", 5);
    if (d.interests.contains("Government Jobs")) add("UPSC/Govt Services", 5);

    if (d.stream == "Science") add("Engineering", 3);
    if (d.stream == "Commerce") add("CA/MBA", 3);
    if (d.stream == "Arts") add("Psychology/Law", 3);

    final sorted = score.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sorted.map((e) => e.key).take(5).toList();
  }
}
