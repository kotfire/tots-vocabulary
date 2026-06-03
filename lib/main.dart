import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const App());
}

class AppConfig {
  static const academyName = 'Tots&Tweens';
  static const appTagline = 'Learn English while playing';

  static const brandPrimary = Color(0xFFC2A6E1);
  static const brandSecondary = Color(0xFF1DCAD3);
  static const brandYellow = Color(0xFFFCE200);
  static const brandPeach = Color(0xFFFFB4AB);
  static const brandPink = Color(0xFFEB80A8);
  static const brandMint = Color(0xFF7ADBD4);
  static const brandSoftYellow = Color(0xFFF5EA61);
  static const brandSoftOrange = Color(0xFFFFBE9F);
  static const brandSoftRose = Color(0xFFFCA3BB);
  static const background = Color(0xFFFFFBFE);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.academyName,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConfig.brandPrimary,
          primary: AppConfig.brandPrimary,
          secondary: AppConfig.brandSecondary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppConfig.background,
      ),
      home: const SplashScreen(),
    );
  }
}

class VocabularyItem {
  final String emoji;
  final String english;
  final String spanish;
  final Color color;

  const VocabularyItem({
    required this.emoji,
    required this.english,
    required this.spanish,
    required this.color,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final String answer;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });
}

const vocabulary = [
  VocabularyItem(emoji: '🐶', english: 'Dog', spanish: 'Perro', color: AppConfig.brandSecondary),
  VocabularyItem(emoji: '🐱', english: 'Cat', spanish: 'Gato', color: AppConfig.brandPink),
  VocabularyItem(emoji: '🍎', english: 'Apple', spanish: 'Manzana', color: AppConfig.brandPeach),
  VocabularyItem(emoji: '☀️', english: 'Sun', spanish: 'Sol', color: AppConfig.brandYellow),
  VocabularyItem(emoji: '🚗', english: 'Car', spanish: 'Coche', color: AppConfig.brandSoftOrange),
  VocabularyItem(emoji: '📘', english: 'Book', spanish: 'Libro', color: AppConfig.brandMint),
];

const questions = [
  QuizQuestion(
    question: 'How do you say “Perro” in English?',
    options: ['Dog', 'Cat', 'Book'],
    answer: 'Dog',
  ),
  QuizQuestion(
    question: 'Which word means “Manzana”?',
    options: ['Sun', 'Apple', 'Car'],
    answer: 'Apple',
  ),
  QuizQuestion(
    question: 'What is “Libro” in English?',
    options: ['Book', 'Dog', 'Sun'],
    answer: 'Book',
  ),
  QuizQuestion(
    question: 'Which one is “Sol”?',
    options: ['Car', 'Sun', 'Cat'],
    answer: 'Sun',
  ),
];

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppConfig.brandPrimary,
              AppConfig.brandSecondary,
              AppConfig.brandYellow,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 144,
              height: 144,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(36),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: SvgPicture.asset('assets/logo.svg'),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                AppConfig.academyName,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              AppConfig.appTagline,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 28),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConfig.background,
          title: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: SvgPicture.asset('assets/logo.svg'),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  AppConfig.academyName,
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          bottom: const TabBar(
            indicatorColor: AppConfig.brandSecondary,
            tabs: [
              Tab(text: 'Vocabulary', icon: Icon(Icons.menu_book_rounded)),
              Tab(text: 'Mini Quiz', icon: Icon(Icons.quiz_rounded)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [VocabularyScreen(), QuizScreen()],
        ),
      ),
    );
  }
}

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Basic vocabulary',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 8),
                Text(
                  'Simple words with cheerful colors and visual cards for kids.',
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: vocabulary.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (context, index) {
                final item = vocabulary[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: item.color.withValues(alpha: 0.35)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item.emoji, style: const TextStyle(fontSize: 46)),
                      const SizedBox(height: 12),
                      Text(
                        item.english,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.spanish,
                        style: const TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int current = 0;
  int score = 0;
  bool finished = false;

  void answer(String option) {
    if (finished) return;
    if (option == questions[current].answer) {
      score++;
    }
    if (current == questions.length - 1) {
      setState(() => finished = true);
    } else {
      setState(() => current++);
    }
  }

  void restart() {
    setState(() {
      current = 0;
      score = 0;
      finished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[current];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: finished
          ? Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🎉', style: TextStyle(fontSize: 64)),
                    const SizedBox(height: 12),
                    const Text(
                      'Great job!',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 8),
                    Text('Score: $score / ${questions.length}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppConfig.brandPrimary,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: restart,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Play again'),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${current + 1} of ${questions.length}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Text(
                    question.question,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 18),
                ...question.options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  final palette = [
                    AppConfig.brandSecondary,
                    AppConfig.brandSoftYellow,
                    AppConfig.brandSoftRose,
                  ];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => answer(option),
                        style: FilledButton.styleFrom(
                          backgroundColor: palette[index % palette.length],
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          option,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
    );
  }
}
