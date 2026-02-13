import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'course_detail.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  String searchText = "";

  /// string -> icon
  IconData _getIcon(String name) {
    switch (name) {
      case "computer":
        return Icons.computer_rounded;
      case "analytics":
        return Icons.analytics_rounded;
      case "business":
        return Icons.business_center_rounded;
      case "marketing":
        return Icons.ads_click_rounded;
      case "design":
        return Icons.brush_rounded;
      case "psychology":
        return Icons.psychology_rounded;
      default:
        return Icons.school;
    }
  }

  /// string -> color
  Color _getColor(String name) {
    switch (name) {
      case "blue":
        return Colors.blue;
      case "orange":
        return Colors.orange;
      case "green":
        return Colors.green;
      case "purple":
        return Colors.purple;
      case "pink":
        return Colors.pink;
      case "teal":
        return Colors.teal;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.black87, size: 20),
        ),
        title: const Text(
          "Explore Courses",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [
            /// search
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: TextField(
                onChanged: (val) =>
                    setState(() => searchText = val.toLowerCase()),
                decoration: InputDecoration(
                  hintText: "Search courses...",
                  prefixIcon:
                  const Icon(Icons.search_rounded, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            /// dynamic list
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('courses')
                    .where('isActive', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;

                  final filtered = docs.where((doc) {
                    final title =
                    doc['title'].toString().toLowerCase();
                    return title.contains(searchText);
                  }).toList();

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 5),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final course = filtered[index];

                      return _buildCourseCard(
                        context,
                        course,
                        course["title"],
                        course["subtitle"],
                        _getIcon(course["icon"]),
                        _getColor(course["color"]),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// SAME UI CARD
  Widget _buildCourseCard(
      BuildContext context,
      QueryDocumentSnapshot course,
      String title,
      String subtitle,
      IconData icon,
      Color color,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),

          /// 🔥 pass whole document
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CourseDetail(course: course),
              ),
            );
          },

          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(subtitle,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600)),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 16, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
