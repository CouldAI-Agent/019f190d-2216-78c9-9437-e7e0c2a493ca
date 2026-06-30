import 'package:flutter/material.dart';

void main() {
  runApp(const ExamScheduleApp());
}

class ExamScheduleApp extends StatelessWidget {
  const ExamScheduleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'កាលវិភាគប្រឡងត្រីមាស',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976D2),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'System', // Relies on system fonts, which support Khmer natively on most modern OS
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
    );
  }
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5), // Presentation background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AspectRatio(
            aspectRatio: 16 / 9, // Standard PowerPoint slide ratio
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      _buildTitleSlide(),
                      _buildScheduleSlide(),
                      _buildTeacherStatusSlide(),
                      _buildNoteSlide(),
                    ],
                  ),
                  
                  // Presentation Controls (Overlay)
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Slide ${_currentPage + 1} of 4',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              onPressed: _currentPage > 0 ? _prevPage : null,
                              color: _currentPage > 0 ? Theme.of(context).primaryColor : Colors.grey,
                              tooltip: 'ត្រឡប់ក្រោយ',
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: _currentPage < 3 ? _nextPage : null,
                              color: _currentPage < 3 ? Theme.of(context).primaryColor : Colors.grey,
                              tooltip: 'បន្ទាប់',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSlide() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
        ),
      ),
      padding: const EdgeInsets.all(48.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.calendar_month, size: 80, color: Colors.white),
          const SizedBox(height: 24),
          const Text(
            'កាលវិភាគប្រឡងត្រីមាស',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'និងការសម្រាករបស់គ្រូ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 48),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.swipe, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'អូសដើម្បីមើលបន្ត',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSlide() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 48, 48, 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSlideHeader('កាលវិភាគប្រឡង', Icons.schedule),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(1.5),
                },
                border: TableBorder(
                  horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                children: [
                  _buildTableHeader(['ថ្ងៃខែ / ថ្ងៃជួប', 'ម៉ោងប្រឡង', 'មុខវិជ្ជា', 'រយៈពេល']),
                  _buildTableRow(['ថ្ងៃចន្ទ ទី២៧', '06:00 - 08:00 ល្ងាច', 'ភាសាចិន', '2 ម៉ោង'], isHighlight: true),
                  _buildTableRow(['ថ្ងៃអង្គារ ទី២៨', '—', '—', '—'], isDimmed: true),
                  _buildTableRow(['ថ្ងៃពុធ ទី២៩', '06:00 - 08:00 ល្ងាច*', 'ភាសាអង់គ្លេស', '2 ម៉ោង'], isHighlight: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherStatusSlide() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 48, 48, 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSlideHeader('ស្ថានភាពលោកគ្រូ-អ្នកគ្រូ', Icons.group),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              children: [
                _buildStatusCard(
                  'ថ្ងៃចន្ទ ទី២៧',
                  [
                    '🧑‍🏫 គ្រូចិន៖ កំពុងរៀបចំការប្រឡង',
                    '☕ គ្រូអង់គ្លេស៖ បានសម្រាក',
                  ],
                  Colors.blue.shade50,
                ),
                const SizedBox(height: 16),
                _buildStatusCard(
                  'ថ្ងៃអង្គារ ទី២៨',
                  [
                    '😴 ថ្ងៃសម្រាកកាយ / គ្មានការប្រឡង',
                  ],
                  Colors.grey.shade100,
                ),
                const SizedBox(height: 16),
                _buildStatusCard(
                  'ថ្ងៃពុធ ទី២៩',
                  [
                    '🧑‍🏫 គ្រូអង់គ្លេស៖ កំពុងរៀបចំការប្រឡង',
                    '☕ គ្រូចិន៖ បានសម្រាក',
                  ],
                  Colors.green.shade50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteSlide() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 48, 48, 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lightbulb_outline, size: 64, color: Colors.orange),
          const SizedBox(height: 24),
          const Text(
            'ចំណាំសំខាន់',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: const Text(
              'ម៉ោងប្រឡងភាសាអង់គ្លេសនៅថ្ងៃពុធ ទី២៩ គឺយកតាមគំរូ ២ ម៉ោងដូចថ្ងៃចន្ទ (ពីម៉ោង ៦ ដល់ ៨ យប់) ដើម្បីឲ្យគ្រូចិនបានសម្រាកដូចគ្នា។',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 48),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.screenshot, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                'អ្នកអាចថតរូបអេក្រង់ (Screenshot) ស្លាយទាំងនេះទុកបានយ៉ាងងាយស្រួល!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSlideHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Theme.of(context).primaryColor, size: 32),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  TableRow _buildTableHeader(List<String> cells) {
    return TableRow(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      children: cells.map((cell) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Text(
            cell,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHighlight = false, bool isDimmed = false}) {
    Color textColor = isDimmed ? Colors.grey.shade500 : Colors.black87;
    FontWeight fontWeight = isHighlight ? FontWeight.w600 : FontWeight.normal;

    return TableRow(
      children: cells.map((cell) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Text(
            cell,
            style: TextStyle(
              fontSize: 18,
              color: textColor,
              fontWeight: fontWeight,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatusCard(String day, List<String> statuses, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...statuses.map((status) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              status,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
            ),
          )),
        ],
      ),
    );
  }
}
