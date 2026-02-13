import 'package:flutter/material.dart';
import '../../models/counseling_data.dart'; // ⭐ add this

class CounselingPhase1 extends StatefulWidget {
  const CounselingPhase1({super.key});

  @override
  State<CounselingPhase1> createState() => _CounselingPhase1State();
}

class _CounselingPhase1State extends State<CounselingPhase1> {
  String? selectedLevel;

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

              // progress
              LinearProgressIndicator(
                value: 0.25,
                backgroundColor: Colors.grey.shade100,
                color: Colors.blueAccent,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),

              const SizedBox(height: 12),

              Text(
                "Step 1 of 4",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Your current education level?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "This helps us personalize the guidance for you.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey.shade400,
                ),
              ),

              const SizedBox(height: 40),

              // options
              Expanded(
                child: ListView(
                  children: [
                    _buildOption("10th"),
                    _buildOption("12th"),
                    _buildOption("Graduate"),
                    _buildOption("Other"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // continue button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: selectedLevel == null
                      ? null
                      : () {

                    // ⭐ create and store data
                    final data = CounselingData();
                    data.level = selectedLevel;

                    // ⭐ send to phase 2
                    Navigator.pushNamed(
                      context,
                      '/counseling_phase2',
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
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  // option card
  Widget _buildOption(String title) {
    final isSelected = selectedLevel == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLevel = title;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.blueAccent : Colors.black87,
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: Colors.blueAccent)
            else
              Icon(Icons.circle_outlined, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }
}
