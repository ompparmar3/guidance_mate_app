import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseDetail extends StatelessWidget {
  final QueryDocumentSnapshot course;

  const CourseDetail({super.key, required this.course});

  /// convert color string → Color
  Color _getColor(String name) {
    switch (name) {
      case "blue":
        return Colors.blueAccent;
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
        return Colors.blueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// SAFE FIRESTORE READ
    final data = course.data() as Map<String, dynamic>;

    final title = data['title']?.toString() ?? 'Course';
    final subtitle = data['subtitle']?.toString() ?? '';
    final description =
        data['description']?.toString() ?? 'No description available';
    final rating = data['rating']?.toString() ?? 'N/A';
    final duration = data['duration']?.toString() ?? 'N/A';
    final students = data['students']?.toString() ?? '0';
    final mentor = data['mentor']?.toString() ?? 'Not Assigned';
    final colorName = data['color']?.toString() ?? 'blue';
    final imageUrl = data['imageUrl']?.toString();

    final themeColor = _getColor(colorName);

    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      /// BODY
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HERO IMAGE (FINAL FIXED)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: themeColor.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: (imageUrl != null && imageUrl.isNotEmpty)
                      ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) {
                      return _noImageWidget();
                    },
                  )
                      : _noImageWidget(),
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// DETAILS
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  /// TAGS
                  Row(
                    children: [
                      _buildTag("Popular", Colors.orange),
                      const SizedBox(width: 10),
                      _buildTag(subtitle, themeColor),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// TITLE
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// INFO TILES
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoTile(Icons.star_rounded,
                          rating, "Rating", Colors.orange),
                      _buildInfoTile(Icons.timer_rounded,
                          duration, "Duration", Colors.blue),
                      _buildInfoTile(Icons.people_rounded,
                          students, "Enrolled", Colors.purple),
                    ],
                  ),

                  const SizedBox(height: 32),

                  /// DESCRIPTION
                  const Text(
                    "About Course",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 32),

                  /// MENTOR
                  const Text(
                    "Course Mentor",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage:
                        AssetImage('assets/images/img4.jpg'),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        mentor,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),

      /// ENROLL BUTTON
      bottomSheet: SafeArea(
        child: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SizedBox(
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                "Enroll Now",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// NO IMAGE WIDGET
  Widget _noImageWidget() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Text(
          "No Image Available",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// HELPERS

  Widget _buildTag(String text, Color color) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text,
          style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12)),
    );
  }

  Widget _buildInfoTile(
      IconData icon, String val, String label, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(val,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
          Text(label,
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 11)),
        ],
      ),
    );
  }
}
