import 'package:flutter/material.dart';
import 'show_vedio.dart'; // استيراد شاشة الفيديو
import 'exam.dart'; // استيراد شاشة الامتحان
import 'info.dart'; // استيراد شاشة المعلومات

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _selectedIndex = 0;

  // قائمة الشاشات التي سيتم عرضها
  final List<Widget> _screens = [
    const HomeContent(),
    const InfiScreen(),
    const ShowVideoScreen(),
    const ExamScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color:
              isDarkMode ? const Color(0xFF1C2833) : theme.colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor:
              isDarkMode ? Colors.white60 : Colors.white.withOpacity(0.7),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'معلومات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library),
              label: 'الفيديو',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz),
              label: 'المسابقة',
            ),
          ],
        ),
      ),
    );
  }
}

// محتوى الشاشة الرئيسية
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // قائمة العناصر
    final List<Map<String, dynamic>> items = [
      {
        'icon': Icons.quiz,
        'text': 'المسابقة',
        'description': 'اختبر معلوماتك في مجال الاستدامة البيئية',
        'color': theme.colorScheme.primary,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ExamScreen()),
          );
        },
      },
      {
        'icon': Icons.info,
        'text': 'معلومات عامة',
        'description': 'تعرف على أهم المعلومات المتعلقة بالاستدامة',
        'color': theme.colorScheme.secondary,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InfiScreen()),
          );
        },
      },
      {
        'icon': Icons.video_library,
        'text': 'الفيديو',
        'description': 'شاهد مقاطع فيديو توعوية عن الاستدامة البيئية',
        'color': const Color(0xFF8BC34A),
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ShowVideoScreen()),
          );
        },
      },
    ];

    return SafeArea(
      child: Column(
        children: [
          // عنوان الصفحة
          Container(
            padding: const EdgeInsets.all(20),
            color: theme.colorScheme.tertiary.withOpacity(0.2),
            child: Row(
              children: [
                Icon(
                  Icons.eco,
                  color: theme.colorScheme.secondary,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  'استكشف عالم الاستدامة',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // عرض المحتوى
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // نص ترحيبي
                  Text(
                    '!مرحباً بك ',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'اختر من القائمة أدناه لاستكشاف المزيد عن الاستدامة البيئية وكيفية المساهمة في حماية كوكبنا.',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // عرض القائمة
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: isDarkMode
                              ? Color.fromARGB(255, 28, 40, 51)
                              : Colors.white,
                          child: InkWell(
                            onTap: items[index]['onTap'],
                            borderRadius: BorderRadius.circular(15),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  // أيقونة الخدمة
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: items[index]['color']
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      items[index]['icon'],
                                      color: items[index]['color'],
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  // معلومات الخدمة
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          items[index]['text'],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          items[index]['description'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: isDarkMode
                                                ? Colors.white70
                                                : Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // سهم للانتقال
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: items[index]['color'],
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
