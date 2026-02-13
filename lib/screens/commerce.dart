import 'package:flutter/material.dart';

class Commerce extends StatelessWidget {
  const Commerce({super.key});

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
          "Commerce Stream",
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
                  colors: [Colors.blue.shade600, Colors.blueAccent.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.account_balance_rounded,
                      size: 80, color: Colors.white),
                  const SizedBox(height: 16),
                  const Text(
                    "Unlock the World of Business & Finance",
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

            // What is Commerce?
            _buildSectionTitle("What is Commerce Stream?"),
            const SizedBox(height: 12),
            _buildDescription(
              "Commerce is a popular academic stream that focuses on the study of trade, business, and financial activities. It provides a foundational understanding of how economies work and how businesses are managed and sustained in a global market.",
            ),
            const SizedBox(height: 12),
            _buildDescription(
              "Key subjects include Accountancy, Business Studies, Economics, and Mathematics/Informatics Practices.",
            ),

            const SizedBox(height: 32),

            // Scope & Future
            _buildSectionTitle("Scope After 12th"),
            const SizedBox(height: 12),
            _buildDescription(
              "Commerce opens doors to the financial heart of the world. From managing billion-dollar corporations to shaping national economic policies, the scope is vast and highly rewarding.",
            ),
            const SizedBox(height: 20),

            _buildExpandableInfoCard(
              context,
              "Finance & Accounting",
              "The backbone of any business, focusing on financial management, auditing, and tax planning.",
              Icons.payments_rounded,
              Colors.green,
              [
                "Chartered Accountant (CA)",
                "Company Secretary (CS)",
                "Cost Accountant (CMA)",
                "Financial Analyst"
              ],
            ),
            _buildExpandableInfoCard(
              context,
              "Management & Business",
              "Focused on leading organizations, optimizing operations, and strategic decision-making.",
              Icons.business_center_rounded,
              Colors.orange,
              [
                "Business Manager",
                "HR Manager",
                "Supply Chain Manager",
                "Entrepreneur"
              ],
            ),
            _buildExpandableInfoCard(
              context,
              "Banking & Insurance",
              "Dealing with financial services, risk management, and investment banking.",
              Icons.account_balance_rounded,
              Colors.blue,
              [
                "Investment Banker",
                "Bank Manager",
                "Actuary",
                "Insurance Specialist"
              ],
            ),

            const SizedBox(height: 32),

            // Major Entrance Exams
            _buildSectionTitle("Major Entrance Exams"),
            const SizedBox(height: 12),
            _buildExamCard(
              "CA Foundation",
              "Entry-level exam for the prestigious Chartered Accountancy course.",
              "Professional",
            ),
            _buildExamCard(
              "IPMAT",
              "Entrance for the Integrated Program in Management at top IIMs.",
              "Management",
            ),
            _buildExamCard(
              "CUET",
              "Common University Entrance Test for B.Com and BBA in top central universities.",
              "University",
            ),
            _buildExamCard(
              "SET",
              "Symbiosis Entrance Test for BBA and other undergraduate programs.",
              "Private",
            ),

            const SizedBox(height: 32),

            // Popular Courses
            _buildSectionTitle("Popular Undergraduate Courses"),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTag("B.Com (Hons)"),
                _buildTag("BBA"),
                _buildTag("BMS"),
                _buildTag("B.A. Economics"),
                _buildTag("CA"),
                _buildTag("CS"),
                _buildTag("BFA"),
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
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
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
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.blue.shade700,
        ),
      ),
    );
  }
}
