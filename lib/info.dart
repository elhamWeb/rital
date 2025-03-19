import 'package:flutter/material.dart';

class InfiScreen extends StatelessWidget {
  const InfiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ألوان الاستدامة: البيج والأزرق الفاتح والأخضر
    const Color backgroundColor = Color(0xFFF5F0E1); // بيج فاتح
    const Color appBarColor = Color(0xFF8ECAE6); // أزرق فاتح
    const Color primaryTextColor = Color(0xFF2D6A4F); // أخضر داكن
    const Color secondaryTextColor = Color(0xFF40916C); // أخضر متوسط
    const Color cardColor = Color(0xFFFFFDF7); // بيج فاتح جداً

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "معلومات عامة",
          style: TextStyle(
            color: Color(0xFF2D6A4F),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: appBarColor,
        elevation: 0,
        // إضافة زر العودة للصفحة الرئيسية بشكل صريح
        automaticallyImplyLeading: false, // إيقاف الزر التلقائي
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF2D6A4F),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // عنوان كبير للمحتوى
          const Text(
            " - معلومات عن الاستدامه -",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20), // مسافة بين العنوان والمحتوى

          _buildInfoCard(
            "1. مفهوم الاستدامة",
            "الاستدامة هي القدرة على تلبية احتياجات الحاضر دون التأثير على قدرة الأجيال القادمة على تلبية احتياجاتهم. هي توازن بين البيئة، الاقتصاد، والمجتمع.",
            cardColor,
            primaryTextColor,
            secondaryTextColor,
          ),

          _buildInfoCard(
            "2. أهمية الاستدامة",
            "الاستدامة ضرورية لحماية الموارد الطبيعية، وتحقيق النمو الاقتصادي المستدام، وضمان العدالة الاجتماعية بين الأفراد والمجتمعات.",
            cardColor,
            primaryTextColor,
            secondaryTextColor,
          ),

          _buildInfoCard(
            "3. الاستدامة البيئية",
            "تشمل الاستدامة البيئية الحفاظ على الموارد الطبيعية وتقليل التلوث. يمكن تحقيق ذلك من خلال استخدام الطاقة المتجددة والحفاظ على المياه.",
            cardColor,
            primaryTextColor,
            secondaryTextColor,
          ),

          _buildInfoCard(
            "4. الاستدامة الاقتصادية",
            "الاستدامة الاقتصادية تعني توفير النمو الاقتصادي بشكل عادل ومستدام، من خلال تحسين الإنتاجية واستخدام الموارد بشكل أكثر كفاءة.",
            cardColor,
            primaryTextColor,
            secondaryTextColor,
          ),

          _buildInfoCard(
            "5. الاستدامة الاجتماعية",
            "الاستدامة الاجتماعية تهدف إلى تعزيز العدالة والمساواة بين الأفراد، وضمان حقوق الإنسان، وتحقيق رفاهية المجتمعات المحلية.",
            cardColor,
            primaryTextColor,
            secondaryTextColor,
          ),

          _buildInfoCard(
            "6. كيف نساهم في الاستدامة؟",
            "يمكننا المساهمة في الاستدامة من خلال تقليل استهلاك الموارد، استخدام الطاقة المتجددة، دعم المنتجات المستدامة، وتعزيز الوعي البيئي.",
            cardColor,
            primaryTextColor,
            secondaryTextColor,
          ),

          _buildInfoCard(
            "7. أهمية التدوير",
            "التدوير يساعد في تقليل النفايات، الحفاظ على الموارد الطبيعية، وتقليل التأثير البيئي. يجب على الجميع المشاركة في عملية التدوير.",
            cardColor,
            primaryTextColor,
            secondaryTextColor,
          ),

          _buildInfoCard(
            "8. الابتكار في مجال الاستدامة",
            "الابتكار في الاستدامة يشمل تطوير تقنيات جديدة تساعد في تحسين الكفاءة وتقليل التأثير البيئي، مثل استخدام الطاقة الشمسية والتقنيات النظيفة.",
            cardColor,
            primaryTextColor,
            secondaryTextColor,
          ),

          _buildInfoCard(
            "9. دور الحكومات في الاستدامة",
            "تلعب الحكومات دورًا حيويًا في تطبيق السياسات والأنظمة التي تدعم الاستدامة، مثل دعم الطاقة المتجددة، وتقليل انبعاثات الكربون.",
            cardColor,
            primaryTextColor,
            secondaryTextColor,
          ),

          _buildInfoCard(
            "10. الاستدامة في الأعمال",
            "الاستدامة في الأعمال تتضمن تبني ممارسات اقتصادية بيئية واجتماعية، مما يساعد في تحسين سمعة الشركات وتوفير فرص نمو مستدام.",
            cardColor,
            primaryTextColor,
            secondaryTextColor,
          )
        ],
      ),
    );
  }

  // دالة مساعدة لإنشاء بطاقة معلومات
  Widget _buildInfoCard(
    String title,
    String content,
    Color cardColor,
    Color titleColor,
    Color contentColor,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: contentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
