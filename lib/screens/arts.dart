import 'package:flutter/material.dart';

class Arts extends StatelessWidget {
  const Arts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.black87, size: 20),
        ),
        title: const Text(
          "Arts & Humanities",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Illustration/Icon Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade400, Colors.orangeAccent.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.palette_rounded, size: 80, color: Colors.white),
                  const SizedBox(height: 16),
                  const Text(
                    "Master the Art of Human Expression",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // What is Arts?
            _buildSectionTitle("What is Arts Stream?"),
            const SizedBox(height: 12),
            _buildDescription(
              "The Arts and Humanities stream is a vast field focusing on human society, culture, and creativity. It encourages deep critical thinking and a profound understanding of world history, languages, and social dynamics. It's the ideal choice for those who love to question, create, and lead change in society.",
            ),
            const SizedBox(height: 12),
            _buildDescription(
              "Key subjects include History, Geography, Political Science, Psychology, Sociology, and Literature.",
            ),

            const SizedBox(height: 32),

            // Why Choose Arts?
            _buildSectionTitle("Why choose Arts?"),
            const SizedBox(height: 12),
            _buildDescription(
              "Choosing Arts isn't just about theory; it's about developing empathy, communication skills, and leadership. In the age of AI, human-centric skills like emotional intelligence and creative problem solving are more valuable than ever.",
            ),

            const SizedBox(height: 32),

            // Scope & Careers
            _buildSectionTitle("Scope After 12th"),
            const SizedBox(height: 12),
            _buildDescription(
              "Arts leads to some of the most influential and rewarding careers. From policy-making to creative direction, the possibilities are endless.",
            ),
            const SizedBox(height: 20),

            _buildExpandableInfoCard(
              context,
              "Law & Justice",
              "Ensuring legal order and defending rights. A highly prestigious field with great social impact.",
              Icons.gavel_rounded,
              Colors.brown,
              ["Corporate Lawyer", "Legal Advisor", "Civil Judge", "Public Prosecutor"],
            ),
            _buildExpandableInfoCard(
              context,
              "Creative Arts & Design",
              "For the innovators. Shapes the visual and structural world we live in.",
              Icons.brush_rounded,
              Colors.pink,
              ["Graphic Designer", "Fashion Designer", "Animator", "Product Designer"],
            ),
            _buildExpandableInfoCard(
              context,
              "Media & Journalism",
              "The voice of society. Managing information flow in the digital world.",
              Icons.record_voice_over_rounded,
              Colors.purple,
              ["Journalist", "Content Strategist", "Public Relations Manager", "Editor"],
            ),
            _buildExpandableInfoCard(
              context,
              "Civil Services (UPSC)",
              "The administrative backbone of the country. Highly respected and powerful.",
              Icons.stars_rounded,
              Colors.blue,
              ["IAS Officer", "IPS Officer", "IFS Officer", "IRS Officer"],
            ),

            const SizedBox(height: 32),

            // Competitive Exams
            _buildSectionTitle("Major Entrance Exams"),
            const SizedBox(height: 12),
            _buildExamCard(
              "CLAT",
              "Common Law Admission Test for entrance into India's top National Law Universities (NLUs).",
              "Law",
            ),
            _buildExamCard(
              "NID DAT / UCEED",
              "The gateway to premier design institutes like NID and IITs.",
              "Design",
            ),
            _buildExamCard(
              "CUET",
              "Common University Entrance Test for B.A. and Liberal Arts in top central universities.",
              "University",
            ),
            _buildExamCard(
              "NCHMCT JEE",
              "Entrance for top Hotel Management and Hospitality programs.",
              "Hospitality",
            ),

            const SizedBox(height: 32),

            // Popular Courses
            _buildSectionTitle("Popular Degree Courses"),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTag("B.A. (Hons)"),
                _buildTag("LL.B (Integrated)"),
                _buildTag("B.Des (Design)"),
                _buildTag("B.FA (Fine Arts)"),
                _buildTag("BJMC (Journalism)"),
                _buildTag("BHM (Hospitality)"),
                _buildTag("Liberal Arts"),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildDescription(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade700,
        height: 1.6,
      ),
    );
  }

  Widget _buildExpandableInfoCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    List<String> careers,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(72, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: careers
                  .map((career) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline,
                                size: 14, color: Colors.green),
                            const SizedBox(width: 8),
                            Text(career, style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildExamCard(String title, String desc, String category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.orange.shade100),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.orange.shade700,
        ),
      ),
    );
  }
}
