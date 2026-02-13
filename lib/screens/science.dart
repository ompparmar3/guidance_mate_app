import 'package:flutter/material.dart';

class Science extends StatelessWidget {
  const Science({super.key});

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
          "Science Stream",
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
                  colors: [Colors.purple.shade400, Colors.deepPurple.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.biotech_rounded, size: 80, color: Colors.white),
                  const SizedBox(height: 16),
                  const Text(
                    "Discover the Foundations of Innovation",
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

            // Introduction
            _buildSectionTitle("What is Science Stream?"),
            const SizedBox(height: 12),
            _buildDescription(
              "The Science stream is an intellectually stimulating field that focuses on the systematic study of the natural world. It is the core of technological advancement, providing students with the analytical skills to solve complex global challenges.",
            ),
            const SizedBox(height: 16),
            _buildDescription(
              "It is broadly categorized into two main groups:\n"
              "• PCM: Physics, Chemistry, Mathematics (Perfect for Engineering & Tech)\n"
              "• PCB: Physics, Chemistry, Biology (Perfect for Medical & Healthcare)\n"
              "• PCMB: A comprehensive blend for students wanting all options open.",
            ),

            const SizedBox(height: 32),

            // Scope & Future
            _buildSectionTitle("Scope After 12th"),
            const SizedBox(height: 12),
            _buildDescription(
              "Science graduates lead the way in fields like Space Exploration, Artificial Intelligence, Medical Research, and Environmental Sustainability.",
            ),
            const SizedBox(height: 20),

            _buildExpandableInfoCard(
              context,
              "Engineering & Technology",
              "Applying mathematical and scientific principles to build the future.",
              Icons.engineering_rounded,
              Colors.blue,
              ["Software Engineer", "AI & ML Specialist", "Aerospace Engineer", "Civil Engineer"],
            ),
            _buildExpandableInfoCard(
              context,
              "Medical & healthcare",
              "Dedicated to human well-being and life-saving research.",
              Icons.medical_services_rounded,
              Colors.red,
              ["MBBS Doctor", "Dentist (BDS)", "Pharmacist", "Biomedical Researcher"],
            ),
            _buildExpandableInfoCard(
              context,
              "Pure Sciences & Research",
              "Exploring the 'why' behind the universe through deep study.",
              Icons.science_rounded,
              Colors.green,
              ["Astrophysicist", "Microbiologist", "Quantum Physicist", "Geologist"],
            ),

            const SizedBox(height: 32),

            // Competitive Exams
            _buildSectionTitle("Major Entrance Exams"),
            const SizedBox(height: 12),
            _buildExamCard(
              "JEE Main & Advanced",
              "The gateway to premier engineering institutes like IITs and NITs.",
              "PCM",
            ),
            _buildExamCard(
              "NEET",
              "The single mandatory exam for all Medical & Dental courses in India.",
              "PCB",
            ),
            _buildExamCard(
              "BITSAT",
              "Entrance for the prestigious Birla Institute of Technology and Science.",
              "PCM",
            ),
            _buildExamCard(
              "CUET",
              "Common test for Science & Research courses in top central universities.",
              "General",
            ),

            const SizedBox(height: 32),

            // Popular Courses
            _buildSectionTitle("Popular Undergraduate Courses"),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTag("B.Tech / B.E"),
                _buildTag("MBBS"),
                _buildTag("B.Sc Research"),
                _buildTag("B.Arch"),
                _buildTag("B.Pharma"),
                _buildTag("BCA"),
                _buildTag("Biotechnology"),
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
              color: Colors.deepPurple.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
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
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.deepPurple.shade100),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.deepPurple.shade700,
        ),
      ),
    );
  }
}
