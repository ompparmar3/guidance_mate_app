import 'package:flutter/material.dart';
import '../../models/counseling_data.dart'; // ⭐ add this

class CounselingPhase2 extends StatefulWidget {
  const CounselingPhase2({super.key});

  @override
  State<CounselingPhase2> createState() => _CounselingPhase2State();
}

class _CounselingPhase2State extends State<CounselingPhase2> {

  // ⭐ receive shared object
  late CounselingData data;

  String? selectedStream;
  final List<String> selectedInterests = [];

  final List<String> streams = ["Science", "Commerce", "Arts", "Other"];

  final List<String> interests = [
    "Technology",
    "Business",
    "Creativity",
    "Helping People",
    "Government Jobs",
    "Design",
    "Research",
    "Management",
  ];

  // ⭐ get arguments from Phase 1
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
                value: 0.5,
                backgroundColor: Colors.grey.shade100,
                color: Colors.blueAccent,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),

              const SizedBox(height: 12),

              Text(
                "Step 2 of 4",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 25),

              // ================= STREAM =================

              const Text(
                "Your current stream?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: streams.length,
                  itemBuilder: (context, index) {
                    final stream = streams[index];
                    final isSelected = selectedStream == stream;

                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(stream),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedStream = selected ? stream : null;
                          });
                        },
                        selectedColor: Colors.blueAccent,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor: Colors.grey.shade50,
                        showCheckmark: false,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // ================= INTERESTS =================

              const Text(
                "What interests you the most?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Select all that apply to you.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey.shade400,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: interests.map((interest) {

                      final isSelected =
                      selectedInterests.contains(interest);

                      return FilterChip(
                        label: Text(interest),
                        selected: isSelected,

                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedInterests.add(interest);
                            } else {
                              selectedInterests.remove(interest);
                            }
                          });
                        },

                        selectedColor:
                        Colors.blueAccent.withOpacity(0.1),
                        checkmarkColor: Colors.blueAccent,
                        backgroundColor: Colors.grey.shade50,
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ================= CONTINUE =================

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(

                  onPressed: (selectedStream == null ||
                      selectedInterests.isEmpty)
                      ? null
                      : () {

                    // ⭐ SAVE DATA
                    data.stream = selectedStream;
                    data.interests = selectedInterests;

                    // ⭐ PASS FORWARD
                    Navigator.pushNamed(
                      context,
                      '/counseling_phase3',
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
                            fontWeight: FontWeight.bold),
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
}
