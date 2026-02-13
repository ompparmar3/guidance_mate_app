import 'package:flutter/material.dart';
import '../../models/counseling_data.dart';
import '../../logic/career_engine.dart';

// ⭐ NEW
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CounselingPhase4 extends StatefulWidget {
  const CounselingPhase4({super.key});

  @override
  State<CounselingPhase4> createState() => _CounselingPhase4State();
}

class _CounselingPhase4State extends State<CounselingPhase4> {

  late CounselingData data;
  late List<String> careers;

  // ⭐ prevent multiple saves
  bool saved = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    data = ModalRoute.of(context)!.settings.arguments as CounselingData;

    careers = CareerEngine.getCareers(data);

    // ⭐ SAVE TO FIRESTORE (ONLY ONCE)
    if (!saved) {
      saved = true;

      final uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        "education": data.level,
        "stream": data.stream,
        "interests": data.interests,
        "workStyle": data.workStyle,
        "budget": data.budget,
        "recommendedCareers": careers,
        "updatedAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
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
        centerTitle: true,
        title: const Text(
          "Results",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
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
                value: 1.0,
                backgroundColor: Colors.grey.shade100,
                color: Colors.blueAccent,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),

              const SizedBox(height: 12),

              const Text(
                "Step 4 of 4 - Complete",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [

                    const Text(
                      "Recommended Career Paths",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    ...careers.map((career) => _buildCareerCard(
                      career,
                      "Recommended based on your interests and preferences",
                      Icons.star_rounded,
                    )),

                    const SizedBox(height: 32),

                    const Text(
                      "Recommended Colleges",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    _buildCollegeCard("COEP Pune", "Engineering", Icons.account_balance_rounded),
                    _buildCollegeCard("VJTI Mumbai", "Engineering", Icons.apartment_rounded),
                    _buildCollegeCard("SPIT Mumbai", "Engineering", Icons.school_rounded),

                    const SizedBox(height: 20),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text("Go to Dashboard"),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCareerCard(String title, String desc, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      subtitle: Text(desc),
    );
  }

  Widget _buildCollegeCard(String name, String details, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(name),
      subtitle: Text(details),
    );
  }
}
