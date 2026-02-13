import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'course_detail.dart';
import 'courses.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => SystemNavigator.pop(),
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black87),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Guidance-Mate",
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.blueAccent,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                icon: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {

                String name = "User";

                if (snapshot.hasData && snapshot.data!.data() != null) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  name = data["name"] ?? "User";
                }

                return Text(
                  "Hi $name!",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                );
              },
            ),

            const SizedBox(height: 4),
            Text(
              "Let’s plan your career path today.",
              style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade400),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent.shade400, Colors.blue.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.smart_toy_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "AI Career Assistant",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Ask Guidance-Mate AI anything",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/aichat_screen');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Ask AI",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                Row(
                  children: [
                    _buildQuickCard(
                      context,
                      "AI Career\nCounseling",
                      Icons.psychology_rounded,
                      Colors.blue,
                      () => Navigator.pushNamed(
                        context,
                        '/counseling_onboarding',
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildQuickCard(
                      context,
                      "Explore\nCourses",
                      Icons.menu_book_rounded,
                      Colors.orange,
                      () => Navigator.pushNamed(context, '/courses'),
                    ),
                    const SizedBox(width: 12),
                    _buildQuickCard(
                      context,
                      "Find\nColleges",
                      Icons.school_rounded,
                      Colors.green,
                      () => Navigator.pushNamed(context, '/collages'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildQuickCard(
                      context,
                      "Scholarships\nEligibility ",
                      Icons.money_rounded,
                      Colors.red,
                      () => Navigator.pushNamed(context, '/scholarship'),
                    ),
                    const SizedBox(width: 12),
                    _buildQuickCard(
                      context,
                      "Competitive\nExam & Preps",
                      Icons.scale_rounded,
                      Colors.blueGrey,
                      () => Navigator.pushNamed(context, '/exams'),
                    ),
                    const SizedBox(width: 12),
                    _buildQuickCard(
                      context,
                      "Intership\nOpportunities",
                      Icons.work_rounded,
                      Colors.pink,
                      () => Navigator.pushNamed(context, '/internship'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

              ],
            ),

            const SizedBox(height: 35),

            _buildSectionHeader(
              "Trending Courses",
              "See all",
              onTap: () => Navigator.pushNamed(context, '/courses'),
            ),
            const SizedBox(height: 15),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('courses')
                  .where('isTrending', isEqualTo: true)
                  .limit(6)
                  .snapshots(),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 160,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const SizedBox(
                    height: 160,
                    child: Center(child: Text("No trending courses")),
                  );
                }

                final docs = snapshot.data!.docs;

                return SizedBox(
                  height: 160,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: docs.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 15),
                    itemBuilder: (context, index) {

                      final data = docs[index].data();
                      final title = data["title"]?.toString() ?? "";
                      final image = data["imageUrl"]?.toString() ?? "";

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CourseDetail(course: docs[index]),
                            ),
                          );
                        },
                        child: _dynamicCourseCard(title, image),
                      );
                    },
                  ),
                );
              },
            ),


            const SizedBox(height: 35),

            _buildSectionHeader("Explore by Stream", ""),
            const SizedBox(height: 10),
            _buildStreamCard(
              context,
              "Science",
              "PCB, PCM & more",
              Icons.biotech_rounded,
              Colors.purple,
              () => Navigator.pushNamed(context, '/science'),
            ),
            _buildStreamCard(
              context,
              "Commerce",
              "Accounts, Finance",
              Icons.account_balance_wallet_rounded,
              Colors.blue,
              () => Navigator.pushNamed(context, '/commerce'),
            ),
            _buildStreamCard(
              context,
              "Arts",
              "History, Design",
              Icons.palette_rounded,
              Colors.orange,
              () => Navigator.pushNamed(context, '/arts'),
            ),

            const SizedBox(height: 35),

            _buildSectionHeader(
              "Top Colleges",
              "See all",
              onTap: () => Navigator.pushNamed(context, '/collages'),
            ),
            const SizedBox(height: 15),
            _buildHorizontalCollegeList([
              "BITS Pilani",
              "IIT Delhi",
              "PHCET",
              "IIT Bombay",
              "IIT Madras",
              "BITS Pilani",
              "SRM University",
              "MIT",
            ]),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  Widget _dynamicCourseCard(String title, String image) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            child: image.isNotEmpty
                ? Image.network(
              image,
              height: 90,
              width: 140,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 90,
                  width: 140,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image),
                );
              },
            )
                : Container(
              height: 90,
              width: 140,
              color: Colors.grey.shade200,
              child: const Icon(Icons.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildQuickCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    String actionText, {
    VoidCallback? onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        if (actionText.isNotEmpty)
          GestureDetector(
            onTap: onTap,
            child: Text(
              actionText,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHorizontalCourseList(List<Map<String, String>> courses) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          return Container(
            width: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade50,
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.asset(
                    courses[index]["image"]!,
                    height: 90,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    courses[index]["title"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStreamCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalCollegeList(List<String> colleges) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: colleges.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return Chip(
            backgroundColor: Colors.white,
            side: BorderSide(color: Colors.grey.shade200),
            label: Text(
              colleges[index],
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          );
        },
      ),
    );
  }
}