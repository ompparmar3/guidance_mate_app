import 'package:flutter/material.dart';
import '../../models/counseling_data.dart'; // ⭐ add this

class CounselingPhase3 extends StatefulWidget {
  const CounselingPhase3({super.key});

  @override
  State<CounselingPhase3> createState() => _CounselingPhase3State();
}

class _CounselingPhase3State extends State<CounselingPhase3> {

  // ⭐ receive shared data
  late CounselingData data;

  String? selectedWorkStyle;
  String? selectedBudget;

  final List<Map<String, dynamic>> workStyles = [
    {"title": "Office", "icon": Icons.business_rounded, "desc": "Traditional workplace"},
    {"title": "Remote", "icon": Icons.home_work_rounded, "desc": "Work from anywhere"},
    {"title": "Hybrid", "icon": Icons.vignette_rounded, "desc": "Best of both worlds"},
  ];

  final List<String> budgetRanges = [
    "Free only",
    "Low cost",
    "Medium",
    "Any budget"
  ];

  // ⭐ get data from Phase 2
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments as CounselingData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),

              LinearProgressIndicator(
                value: 0.75,
                backgroundColor: Colors.grey.shade100,
                color: Colors.blueAccent,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),

              const SizedBox(height: 12),

              Text(
                "Step 3 of 4",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 25),

              // ================= WORK STYLE =================

              const Text(
                "Preferred Work Style?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: [

                    ...workStyles
                        .map((style) => _buildWorkStyleCard(style))
                        .toList(),

                    const SizedBox(height: 30),

                    // ================= BUDGET =================

                    const Text(
                      "Expected Budget for Courses?",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: budgetRanges.map((budget) {

                        final isSelected = selectedBudget == budget;

                        return ChoiceChip(
                          label: Text(budget),
                          selected: isSelected,

                          onSelected: (val) =>
                              setState(() =>
                              selectedBudget = val ? budget : null),

                          selectedColor: Colors.blueAccent,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),

                          backgroundColor: Colors.grey.shade50,
                          showCheckmark: false,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ================= CONTINUE =================

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(

                  onPressed: (selectedWorkStyle == null ||
                      selectedBudget == null)
                      ? null
                      : () {

                    // ⭐ SAVE DATA
                    data.workStyle = selectedWorkStyle;
                    data.budget = selectedBudget;

                    // ⭐ PASS TO RESULT
                    Navigator.pushNamed(
                      context,
                      '/counseling_phase4',
                      arguments: data,
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade200,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ================= WORK STYLE CARD =================

  Widget _buildWorkStyleCard(Map<String, dynamic> style) {

    final isSelected = selectedWorkStyle == style['title'];

    return GestureDetector(
      onTap: () => setState(() =>
      selectedWorkStyle = style['title']),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blueAccent.withOpacity(0.05)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            width: 2,
          ),
        ),

        child: Row(
          children: [
            Icon(style['icon'],
                color: isSelected ? Colors.blueAccent : Colors.blueGrey,
                size: 28),

            const SizedBox(width: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style['title'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.blueAccent : Colors.black87,
                  ),
                ),
                Text(
                  style['desc'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),

            const Spacer(),

            if (isSelected)
              const Icon(Icons.check_circle_rounded,
                  color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }
}
