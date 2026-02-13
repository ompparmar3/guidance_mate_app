import 'dart:async';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late ScrollController _scrollController1;
  late ScrollController _scrollController2;
  late ScrollController _scrollController3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    _scrollController3 = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _startScrolling() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_scrollController1.hasClients) {
        if (_scrollController1.offset >= _scrollController1.position.maxScrollExtent) {
          _scrollController1.jumpTo(_scrollController1.position.minScrollExtent);
        } else {
          _scrollController1.animateTo(
            _scrollController1.offset + 1,
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }

      if (_scrollController2.hasClients) {
        if (_scrollController2.offset <= _scrollController2.position.minScrollExtent) {
          _scrollController2.jumpTo(_scrollController2.position.maxScrollExtent);
        } else {
          _scrollController2.animateTo(
            _scrollController2.offset - 1,
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }

      if (_scrollController3.hasClients) {
        if (_scrollController3.offset >= _scrollController3.position.maxScrollExtent) {
          _scrollController3.jumpTo(_scrollController3.position.minScrollExtent);
        } else {
          _scrollController3.animateTo(
            _scrollController3.offset + 1,
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<String> images1 = [
      "assets/images/img9.jpg",
      "assets/images/img14.jpg",
      "assets/images/img6.jpg",
      "assets/images/img12.jpg"
    ];

    final List<String> images2 = [
      "assets/images/img3.jpg",
      "assets/images/img4.jpg",
      "assets/images/img7.jpg",
      "assets/images/img11.jpg"
    ];

    final List<String> images3 = [
      "assets/images/img5.jpg",
      "assets/images/img10.jpg",
      "assets/images/img13.jpg",
      "assets/images/img8.jpg"
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      // ===== Title =====
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: const [
                            Text(
                              "Welcome to ",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              "Guidance-Mate",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Your personal career compass",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.blueGrey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // ===== Image Rows =====
                      SizedBox(
                        height: size.height * 0.45,
                        child: Column(
                          children: [
                            Expanded(child: _buildScrollingRow(_scrollController1, images1)),
                            const SizedBox(height: 12),
                            Expanded(child: _buildScrollingRow(_scrollController2, images2)),
                            const SizedBox(height: 12),
                            Expanded(child: _buildScrollingRow(_scrollController3, images3)),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // ===== ONLY BUTTON (updated part) =====
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Get Started",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward_rounded, size: 22),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildScrollingRow(ScrollController controller, List<String> images) {
    final repeatedImages = [...images, ...images, ...images, ...images];

    return ListView.builder(
      controller: controller,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: repeatedImages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(repeatedImages[index]),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
