import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'scholarship_detail.dart';

class Scholarship extends StatefulWidget {
  const Scholarship({super.key});

  @override
  State<Scholarship> createState() => _ScholarshipState();
}

class _ScholarshipState extends State<Scholarship> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Scholarship Portal",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [

          // Scrollable top section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  // Modern Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.03),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery =
                              value.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        hintText:
                        "Search scholarships...",
                        hintStyle: TextStyle(
                            color:
                            Colors.grey.shade400),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Colors.blueAccent,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.symmetric(
                            vertical: 15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Featured Gradient Header
                  Container(
                    width: double.infinity,
                    padding:
                    const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent
                              .shade400,
                          Colors.blue.shade800
                        ],
                      ),
                      borderRadius:
                      BorderRadius.circular(
                          24),
                    ),
                    child: const Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          "Handpicked for you",
                          style: TextStyle(
                              color:
                              Colors.white70),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Latest Opportunities",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Available Scholarships",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Firestore List
                  StreamBuilder<
                      QuerySnapshot<
                          Map<String,
                              dynamic>>>(
                    stream: FirebaseFirestore
                        .instance
                        .collection(
                        'scholarships')
                        .snapshots(),
                    builder:
                        (context, snapshot) {

                      if (snapshot
                          .connectionState ==
                          ConnectionState
                              .waiting) {
                        return const Center(
                            child:
                            CircularProgressIndicator());
                      }

                      if (!snapshot
                          .hasData ||
                          snapshot.data!.docs
                              .isEmpty) {
                        return const Center(
                            child: Text(
                                "No scholarships available"));
                      }

                      final docs =
                          snapshot.data!.docs;

                      final filtered =
                      docs.where((doc) {
                        final data =
                        doc.data();
                        final name =
                        (data["name"] ??
                            "")
                            .toString()
                            .toLowerCase();
                        return name
                            .contains(
                            searchQuery);
                      }).toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        itemCount:
                        filtered.length,
                        itemBuilder:
                            (context,
                            index) {
                          final data =
                          filtered[index]
                              .data();

                          final name =
                              data["name"] ??
                                  "";
                          final type =
                              data["type"] ??
                                  "";
                          final amount =
                              data["amount"] ??
                                  "";
                          final logo =
                              data["logo"] ??
                                  "";

                          // Proper deadline formatting
                          String deadline =
                              "";
                          if (data[
                          "deadline"] !=
                              null) {
                            final raw =
                            data[
                            "deadline"];
                            if (raw
                            is Timestamp) {
                              final date =
                              raw.toDate();
                              deadline =
                              "${date.day} ${_monthName(date.month)} ${date.year}";
                            } else {
                              deadline =
                                  raw.toString();
                            }
                          }

                          return _buildScholarshipCard(
                            context,
                            name,
                            type,
                            amount,
                            deadline,
                            logo,
                            data,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScholarshipCard(
      BuildContext context,
      String name,
      String type,
      String amount,
      String deadline,
      String logo,
      Map<String, dynamic> data,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                ScholarshipDetail(
                    data: data),
          ),
        );
      },
      child: Container(
        margin:
        const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.02),
              blurRadius: 10,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              padding:
              const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey
                    .shade50,
                borderRadius:
                BorderRadius
                    .circular(15),
              ),
              child: logo.isNotEmpty
                  ? Image.network(
                logo,
                fit: BoxFit.contain,
                errorBuilder:
                    (context,
                    error,
                    stackTrace) =>
                const Icon(Icons.account_balance),
              )
                  : const Icon(
                  Icons
                      .account_balance_rounded),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: [
                  Text(
                    name,
                    style:
                    const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    type,
                    style:
                    const TextStyle(
                      color: Colors
                          .blueAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        amount,
                        style:
                        const TextStyle(
                          color: Colors
                              .green,
                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        deadline,
                        style:
                        const TextStyle(
                          color: Colors
                              .grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month];
  }
}
