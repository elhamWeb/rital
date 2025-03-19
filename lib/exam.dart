import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
import 'secon_screen.dart';

class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentQuestionIndex = 0;
  List<Question> questions = [];
  List<int?> selectedAnswers = [];

  // ألوان الاستدامة المتناسقة مع التطبيق
  final Color backgroundColor = const Color(0xFFF5F0E1); // بيج فاتح
  final Color appBarColor = const Color(0xFF8ECAE6); // أزرق فاتح
  final Color primaryTextColor = const Color(0xFF2D6A4F); // أخضر داكن
  final Color secondaryTextColor = const Color(0xFF40916C); // أخضر متوسط
  final Color accentColor = const Color(0xFF40916C); // أخضر للتأكيد
  final Color cardColor = const Color(0xFFFFFDF7); // بيج فاتح جداً

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    questions = [
      Question(
          text: "ما المقصود بالاستدامة البيئية؟",
          options: [
            "حماية البيئة",
            "زيادة الاستهلاك",
            "إزالة الغابات",
            "استخدام المزيد من البلاستيك"
          ],
          correctAnswerIndex: 0),
      Question(
          text: "أي من الخيارات التالية يعد من مصادر الطاقة المتجددة؟",
          options: ["الفحم", "النفط", "الطاقة الشمسية", "الغاز الطبيعي"],
          correctAnswerIndex: 2),
      Question(
          text: "ما الهدف من إعادة التدوير؟",
          options: [
            "زيادة النفايات",
            "الحفاظ على الموارد",
            "زيادة التلوث",
            "تقليل الإنتاج"
          ],
          correctAnswerIndex: 1),
      Question(
          text: "أي من هذه الممارسات يساعد على تقليل استهلاك المياه؟",
          options: [
            "ترك الصنبور مفتوحًا",
            "استخدام مياه الأمطار",
            "غسل السيارة يوميًا",
            "ري النباتات وقت الظهيرة"
          ],
          correctAnswerIndex: 1),
      Question(
          text: "ما هو الغرض من استخدام الأكياس القابلة للتحلل؟",
          options: [
            "تقليل التلوث البلاستيكي",
            "زيادة المخلفات",
            "استهلاك المزيد من الموارد",
            "جعل البيئة أكثر تلوثًا"
          ],
          correctAnswerIndex: 0),
      Question(
          text: "أي من التالي يعتبر مثالًا على النقل المستدام؟",
          options: [
            "استخدام السيارات التقليدية",
            "استخدام الدراجات",
            "زيادة الرحلات الجوية",
            "شراء المزيد من السيارات"
          ],
          correctAnswerIndex: 1),
      Question(
          text: "ما هو التأثير الرئيسي لإزالة الغابات؟",
          options: [
            "زيادة الأكسجين",
            "انخفاض التنوع البيولوجي",
            "تحسين المناخ",
            "تقليل الاحتباس الحراري"
          ],
          correctAnswerIndex: 1),
      Question(
          text: "ما هو أحد أهداف التنمية المستدامة للأمم المتحدة؟",
          options: [
            "القضاء على الفقر",
            "زيادة الانبعاثات الكربونية",
            "تقليل استخدام الطاقة المتجددة",
            "تدمير البيئة"
          ],
          correctAnswerIndex: 0),
      Question(
          text: "لماذا يجب علينا تقليل استهلاك البلاستيك؟",
          options: [
            "لأنه يتحلل بسهولة",
            "لأنه يسبب تلوث المحيطات",
            "لأنه مادة طبيعية",
            "لأنه مفيد للبيئة"
          ],
          correctAnswerIndex: 1),
      Question(
          text: "ما هو المصدر الأساسي لغازات الاحتباس الحراري؟",
          options: [
            "الطاقة المتجددة",
            "حرق الوقود الأحفوري",
            "زراعة الأشجار",
            "استخدام السيارات الكهربائية"
          ],
          correctAnswerIndex: 1),
    ];
    selectedAnswers = List.filled(questions.length, null);
  }

  Future<void> _playSuccessSound() async {
    await _audioPlayer.play(AssetSource('sounds/rrr.mp3'));
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswerIndex) {
        score++;
      } else {
        Vibration.vibrate();
      }
    }
    return score;
  }

  void _checkAnswers() {
    int score = calculateScore();
    if (score >= 5) {
      // تشغيل الصوت إذا كان عدد الإجابات الصحيحة 5 أو أكثر
      _playSuccessSound();
    }
    _showResultDialog(score);
  }

  void _showResultDialog(int score) {
    double percentage = (score / questions.length) * 100;
    String message;
    Color messageColor;

    if (percentage >= 80) {
      message = "ممتاز! أداء رائع";
      messageColor = Colors.green;
    } else if (percentage >= 60) {
      message = "جيد جدًا";
      messageColor = Colors.blue;
    } else if (percentage >= 40) {
      message = "جيد، يمكنك التحسن";
      messageColor = Colors.orange;
    } else {
      message = "تحتاج إلى مراجعة المعلومات";
      messageColor = Colors.red;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          "نتيجة الاختبار",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryTextColor),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "لقد حصلت على $score من ${questions.length}",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: secondaryTextColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: TextStyle(
                  fontSize: 18,
                  color: messageColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              "نسبة النجاح: ${percentage.toStringAsFixed(1)}%",
              style: TextStyle(fontSize: 16, color: secondaryTextColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SecondScreen()),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text(
              "متابعة",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _checkAnswers();
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "اختبار الاستدامة",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryTextColor),
        ),
        backgroundColor: appBarColor,
        elevation: 0,
        // إضافة زر العودة للصفحة الرئيسية
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryTextColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة عرض تقدم الاختبار
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: appBarColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "السؤال ${currentQuestionIndex + 1} من ${questions.length}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryTextColor),
                  ),
                  // شريط التقدم
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: LinearProgressIndicator(
                        value: (currentQuestionIndex + 1) / questions.length,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // بطاقة السؤال
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  question.text,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // خيارات الإجابة
            Expanded(
              child: ListView.builder(
                itemCount: question.options.length,
                itemBuilder: (context, optionIndex) {
                  final isSelected =
                      selectedAnswers[currentQuestionIndex] == optionIndex;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: isSelected ? accentColor : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    elevation: isSelected ? 4 : 2,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedAnswers[currentQuestionIndex] = optionIndex;
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? accentColor : Colors.white,
                                border:
                                    Border.all(color: accentColor, width: 2),
                              ),
                              child: isSelected
                                  ? const Icon(Icons.check,
                                      size: 16, color: Colors.white)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                question.options[optionIndex],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: secondaryTextColor,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // أزرار التنقل
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentQuestionIndex > 0)
                  ElevatedButton.icon(
                    onPressed: _previousQuestion,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("السابق"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appBarColor,
                      foregroundColor: primaryTextColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  )
                else
                  const SizedBox(
                      width: 100), // مساحة فارغة إذا كنا في السؤال الأول

                ElevatedButton.icon(
                  onPressed: _nextQuestion,
                  icon: Icon(currentQuestionIndex == questions.length - 1
                      ? Icons.done_all
                      : Icons.arrow_forward),
                  label: Text(currentQuestionIndex == questions.length - 1
                      ? "إنهاء"
                      : "التالي"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
