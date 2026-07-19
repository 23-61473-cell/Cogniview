import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/dashboard_provider.dart';

class QuizTab extends StatelessWidget {
  const QuizTab({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);

    if (provider.isQuizFinished) {
      return _buildResultsView(context, provider);
    }

    final question = provider.currentQuestion;
    final questionsCount = provider.quizQuestions.length;
    final questionNumber = provider.currentQuestionIndex + 1;
    final progressPercent = (questionNumber / questionsCount);

    final optionLabels = ['A', 'B', 'C', 'D'];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Module Title Header
            Center(
              child: Column(
                children: [
                  const Text(
                    'COGNIVIEW AR QUIZ',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    provider.selectedModule.title,
                    style: const TextStyle(
                      color: AppTheme.darkGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Progress Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question $questionNumber / $questionsCount',
                  style: const TextStyle(
                    color: AppTheme.darkGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${(progressPercent * 100).toInt()}% Complete',
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progressPercent,
                minHeight: 8,
                backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.15),
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              ),
            ),
            const SizedBox(height: 28),

            // Question Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppTheme.primaryColor.withValues(alpha: 0.15),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.darkGreen.withValues(alpha: 0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.help_outline_rounded,
                      color: AppTheme.darkGreen,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      question.questionText,
                      style: const TextStyle(
                        color: AppTheme.darkGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Options List
            Column(
              children: List.generate(question.options.length, (index) {
                final isSelected = provider.selectedAnswerIndex == index;
                final optionText = question.options[index];

                Color borderColor = AppTheme.primaryColor.withValues(alpha: 0.15);
                Color bgColor = Colors.white;
                Color textColor = AppTheme.darkGreen;

                if (isSelected) {
                  borderColor = AppTheme.primaryColor;
                  bgColor = AppTheme.primaryColor.withValues(alpha: 0.08);
                  textColor = AppTheme.darkGreen;
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: InkWell(
                    onTap: () => provider.selectAnswer(index),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor, width: 2),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: isSelected
                                ? AppTheme.primaryColor
                                : AppTheme.primaryColor.withValues(alpha: 0.15),
                            child: Text(
                              optionLabels[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : AppTheme.darkGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              optionText,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),

            // Next Button
            ElevatedButton(
              onPressed: provider.selectedAnswerIndex == null
                  ? null
                  : () => provider.nextQuestion(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkGreen,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey[300],
                disabledForegroundColor: Colors.grey[500],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Next Question',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsView(BuildContext context, DashboardProvider provider) {
    final questions = provider.quizQuestions;
    final answers = provider.userAnswers;
    final optionLabels = ['A', 'B', 'C', 'D'];

    int correctCount = 0;
    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == questions[i].correctOptionIndex) {
        correctCount++;
      }
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Results Summary Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.darkGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.darkGreen.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.emoji_events_rounded,
                    color: AppTheme.accentColor,
                    size: 64,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Quiz Completed!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Module: ${provider.selectedModule.title}',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$correctCount / ${questions.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text(
                    'Correct Answers',
                    style: TextStyle(
                      color: AppTheme.accentColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Review Details Header
            const Text(
              'Questions Review',
              style: TextStyle(
                color: AppTheme.darkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),

            // Question review list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, qIndex) {
                final question = questions[qIndex];
                final userAnswerIndex = answers[qIndex];
                final isUserCorrect = userAnswerIndex == question.correctOptionIndex;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isUserCorrect
                          ? AppTheme.primaryColor.withValues(alpha: 0.25)
                          : Colors.redAccent.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            isUserCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                            color: isUserCorrect ? AppTheme.primaryColor : Colors.redAccent,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Question ${qIndex + 1}: ${question.questionText}',
                              style: const TextStyle(
                                color: AppTheme.darkGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Options list with highlights
                      ...List.generate(question.options.length, (oIndex) {
                        final isCorrectOption = oIndex == question.correctOptionIndex;
                        final isUserSelected = oIndex == userAnswerIndex;

                        Color textColor = AppTheme.darkGreen;
                        FontWeight fontWeight = FontWeight.normal;
                        Widget? markerIcon;

                        if (isCorrectOption) {
                          textColor = AppTheme.primaryColor;
                          fontWeight = FontWeight.bold;
                          markerIcon = const Icon(Icons.check_rounded, color: AppTheme.primaryColor, size: 16);
                        } else if (isUserSelected && !isUserCorrect) {
                          textColor = Colors.redAccent;
                          fontWeight = FontWeight.bold;
                          markerIcon = const Icon(Icons.close_rounded, color: Colors.redAccent, size: 16);
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Row(
                            children: [
                              Text(
                                '${optionLabels[oIndex]}.  ',
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: fontWeight,
                                  fontSize: 13,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  question.options[oIndex],
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: fontWeight,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              ?markerIcon,
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Restart Button
            ElevatedButton(
              onPressed: () => provider.resetQuiz(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Restart Quiz',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
