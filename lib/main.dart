import 'package:flutter/material.dart';
import 'secon_screen.dart'; // استيراد الشاشة الثانية

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _darkMode = false;

  void toggleTheme() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF5DADE2), // أزرق فاتح
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF5DADE2), // أزرق فاتح
          secondary: const Color(0xFF1E8449), // أخضر داكن
          tertiary: const Color(0xFFF5F5DC), // بيج
          background: const Color(0xFFE8F8F5), // خلفية فاتحة
        ),
        fontFamily: 'Cairo',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF2874A6), // أزرق داكن
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF2874A6), // أزرق داكن
          secondary: const Color(0xFF196F3D), // أخضر داكن
          tertiary: const Color(0xFF5D6D7E), // بيج داكن
          background: const Color(0xFF1C2833), // خلفية داكنة
        ),
        fontFamily: 'Cairo',
      ),
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(toggleTheme: toggleTheme, isDarkMode: _darkMode),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const MyHomePage(
      {super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // زر تبديل الوضع
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                  color: theme.colorScheme.primary,
                  onPressed: () {
                    toggleTheme();
                  },
                ),
              ),

              // صورة كبيرة في الأعلى
              Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage('images/home2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // العنوان والوصف
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نحو مستقبل أخضر مستدام',
                      style: TextStyle(
                        fontSize: 28,
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "معًا نبني بيئة صحية للأجيال القادمة. كل خطوة صغيرة تصنع فرقًا كبيرًا في مستقبل كوكبنا!",
                      style: TextStyle(
                        fontSize: 18,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // بطاقات المعلومات
              Row(
                children: [
                  Expanded(
                    child: InfoCard(
                      icon: Icons.eco,
                      title: 'الحفاظ على الطاقة',
                      description: 'استخدم مصادر الطاقة المتجددة',
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: InfoCard(
                      icon: Icons.water_drop,
                      title: 'ترشيد المياه',
                      description: 'كل قطرة ماء تهم',
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: InfoCard(
                      icon: Icons.restore_from_trash,
                      title: 'إعادة التدوير',
                      description: 'فرز النفايات يحمي البيئة',
                      color: theme.colorScheme.tertiary,
                      textColor: isDarkMode
                          ? Color.fromARGB(255, 247, 244, 244)
                          : Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: InfoCard(
                      icon: Icons.park,
                      title: 'التشجير',
                      description: 'زرع الأشجار يحسن جودة الهواء',
                      color: const Color(0xFF8BC34A),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // معلومات التواصل
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تواصل معنا',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 15),
                    buildContactRow(
                        Icons.email, 'sustainability@gmail.com', theme),
                    const SizedBox(height: 10),
                    buildContactRow(Icons.phone, '0790033624', theme),
                    const SizedBox(height: 10),
                    buildContactRow(
                        Icons.facebook, '@sustainabilityPage', theme),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              // زر بدء الرحلة
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                  shadowColor: theme.colorScheme.secondary.withOpacity(0.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "اكتشف عالم الاستدامة",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContactRow(IconData icon, String text, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.primary),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: theme.brightness == Brightness.dark
                ? Colors.white70
                : Colors.black87,
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final Color? textColor;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextColor =
        color.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;
    final actualTextColor = textColor ?? defaultTextColor;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: actualTextColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

extension ThemeDataExtensions on ThemeData {
  bool get isDark => brightness == Brightness.dark;
}
