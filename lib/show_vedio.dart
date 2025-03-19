import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowVideoScreen extends StatefulWidget {
  const ShowVideoScreen({super.key});

  @override
  State<ShowVideoScreen> createState() => _ShowVideoScreenState();
}

class _ShowVideoScreenState extends State<ShowVideoScreen> {
  // متغيرات للتحكم بالفيديو المحلي
  late VideoPlayerController _localVideoController;
  bool _isPlaying = false;

  // معلومات الفيديو
  final String _videoTitle = "الاستدامة في حياتنا اليومية";
  final String _videoDescription =
      "هذا الفيديو يشرح كيفية تطبيق مفاهيم الاستدامة في حياتنا اليومية، ويقدم نصائح عملية للحفاظ على البيئة وترشيد استهلاك الموارد الطبيعية.";

  // ألوان التطبيق
  final Color _lightBlue = const Color(0xFF7FCCDC);
  final Color _green = const Color(0xFF6CAE75);
  final Color _beige = const Color(0xFFF7E7CE);
  final Color _darkBlue = const Color(0xFF2B6D87);

  // حالة الأزرار التفاعلية
  bool _isLiked = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();

    // إعداد الفيديو المحلي
    _localVideoController = VideoPlayerController.asset('vedios/vedios11.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    // إضافة مستمع لتحديث حالة التشغيل
    _localVideoController.addListener(() {
      final isPlaying = _localVideoController.value.isPlaying;
      if (isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = isPlaying;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _beige.withOpacity(0.7),
      appBar: AppBar(
        title: const Text(
          "مستدامة - عرض الفيديو",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Tajawal',
          ),
        ),
        backgroundColor: _darkBlue,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _darkBlue,
              _beige.withOpacity(0.7),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عنوان الفيديو
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _lightBlue.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      border: Border.all(color: _lightBlue, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.video_library, color: _darkBlue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _videoTitle,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _darkBlue,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // منطقة الفيديو
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: _lightBlue, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                      child: _buildLocalVideoPlayer(),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // أزرار تفاعلية
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          "أعجبني",
                          _isLiked ? Colors.red : _lightBlue, () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      }),
                      _buildActionButton(Icons.share, "مشاركة", _green, () {
                        // إضافة وظيفة المشاركة هنا
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('تمت مشاركة الفيديو'),
                            backgroundColor: _green,
                          ),
                        );
                      }),
                      _buildActionButton(
                          _isSaved ? Icons.bookmark : Icons.bookmark_border,
                          "حفظ",
                          _darkBlue, () {
                        setState(() {
                          _isSaved = !_isSaved;
                        });
                      }),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // وصف الفيديو
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border:
                          Border.all(color: _green.withOpacity(0.5), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.description, color: _green),
                            const SizedBox(width: 8),
                            Text(
                              "وصف الفيديو",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _darkBlue,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 8),
                        Text(
                          _videoDescription,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontFamily: 'Tajawal',
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // معلومات إضافية
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _lightBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: _lightBlue.withOpacity(0.5), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.eco, color: _green),
                            const SizedBox(width: 8),
                            Text(
                              "نصائح للاستدامة",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _darkBlue,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildTip(
                            "قلل من استخدام المواد البلاستيكية ذات الاستخدام الواحد."),
                        _buildTip(
                            "حاول استخدام وسائل النقل العام أو الدراجة بدلاً من السيارة."),
                        _buildTip("اطفئ الأجهزة الكهربائية عند عدم استخدامها."),
                        _buildTip("استخدم المياه بشكل مسؤول وتجنب الإسراف."),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _green,
        onPressed: () {
          // تبديل بين الفيديوهات المحلية المتاحة
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('تبديل الفيديو التالي'),
              backgroundColor: _green,
            ),
          );
        },
        child: const Icon(Icons.shuffle),
      ),
    );
  }

  // بناء مشغل الفيديو المحلي
  Widget _buildLocalVideoPlayer() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: _localVideoController.value.isInitialized
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(_localVideoController),
                _buildVideoProgressIndicator(_localVideoController),
                Positioned(
                  bottom: 30,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: _green.withOpacity(0.7),
                    onPressed: () {
                      setState(() {
                        if (_localVideoController.value.isPlaying) {
                          _localVideoController.pause();
                        } else {
                          _localVideoController.play();
                        }
                      });
                    },
                    child: Icon(
                      _localVideoController.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                ),
              ],
            )
          : Container(
              height: 220,
              color: Colors.black12,
              child: Center(
                child: CircularProgressIndicator(
                  color: _green,
                ),
              ),
            ),
    );
  }

  // بناء شريط التقدم المخصص
  Widget _buildVideoProgressIndicator(VideoPlayerController controller) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.5),
          ],
        ),
      ),
      child: VideoProgressIndicator(
        controller,
        allowScrubbing: true,
        padding: const EdgeInsets.symmetric(vertical: 8),
        colors: VideoProgressColors(
          playedColor: _green,
          bufferedColor: Colors.white.withOpacity(0.5),
          backgroundColor: Colors.white.withOpacity(0.2),
        ),
      ),
    );
  }

  // بناء زر تفاعلي
  Widget _buildActionButton(
      IconData icon, String label, Color color, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // بناء نصيحة للاستدامة
  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: _green, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.3,
                fontFamily: 'Tajawal',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // تنظيف موارد المشغل
    _localVideoController.dispose();
    super.dispose();
  }
}
