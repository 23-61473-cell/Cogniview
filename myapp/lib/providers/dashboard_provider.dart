import 'package:flutter/material.dart';

class ModuleItem {
  final String id;
  final String title;
  final String description;
  final double progress; // 0.0 to 1.0
  final IconData icon;
  final bool isLocked;

  const ModuleItem({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.icon,
    this.isLocked = false,
  });
}

class QuizQuestion {
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;

  const QuizQuestion({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });
}

class DashboardProvider extends ChangeNotifier {
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  void setTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  double get overallProgress => 0.65;

  final List<ModuleItem> _modules = [
    const ModuleItem(
      id: 'visual_structures',
      title: 'Visual Structures',
      description: 'Explore the anatomy and physiology of the human visual system.',
      progress: 0.85,
      icon: Icons.visibility_rounded,
    ),
    const ModuleItem(
      id: 'sensory_perception',
      title: 'Sensory & Perception',
      description: 'How we interpret environmental stimuli through sensory organs.',
      progress: 0.45,
      icon: Icons.psychology_rounded,
    ),
    const ModuleItem(
      id: 'attention_focus',
      title: 'Attention & Focus',
      description: 'Mechanisms of selective attention and concentration.',
      progress: 0.20,
      icon: Icons.track_changes_rounded,
    ),
    const ModuleItem(
      id: 'problem_solving',
      title: 'Problem Solving',
      description: 'Higher-level executive function and reasoning paradigms.',
      progress: 0.0,
      icon: Icons.lightbulb_rounded,
    ),
    const ModuleItem(
      id: 'memory_recall',
      title: 'Memory & Recall',
      description: 'Short-term, long-term, and sensory memory retention.',
      progress: 0.10,
      icon: Icons.memory_rounded,
    ),
    const ModuleItem(
      id: 'cognitive_science',
      title: 'Cognitive Science',
      description: 'Foundations of cognitive architectures and models.',
      progress: 0.92,
      icon: Icons.auto_awesome_rounded,
    ),
  ];

  List<ModuleItem> get modules => _modules;
  
  List<ModuleItem> get activeModules => _modules.where((m) => m.progress > 0 && m.progress < 1.0).toList();
  
  ModuleItem? get continueLearningModule {
    final active = _modules.where((m) => m.progress > 0 && m.progress < 1.0).toList();
    if (active.isNotEmpty) {
      return active.reduce((a, b) => a.progress < b.progress ? a : b);
    }
    return _modules.first;
  }

  // --- Selected Module Details ---
  String? _selectedModuleId = 'visual_structures';
  String? get selectedModuleId => _selectedModuleId;

  ModuleItem get selectedModule {
    return _modules.firstWhere(
      (m) => m.id == _selectedModuleId,
      orElse: () => _modules.first,
    );
  }

  void selectModule(String moduleId) {
    _selectedModuleId = moduleId;
    notifyListeners();
  }

  // --- Quiz State Management ---
  int _currentQuestionIndex = 3; // Starts at 3 (Question 4/10) to match Figma screen mockup
  int get currentQuestionIndex => _currentQuestionIndex;

  int? _selectedAnswerIndex;
  int? get selectedAnswerIndex => _selectedAnswerIndex;

  final List<QuizQuestion> _quizQuestions = [
    const QuizQuestion(
      questionText: 'Which lobe of the brain is primary responsible for processing auditory signals and speech comprehension?',
      options: ['Frontal Lobe', 'Temporal Lobe', 'Occipital Lobe', 'Parietal Lobe'],
      correctOptionIndex: 1,
    ),
    const QuizQuestion(
      questionText: 'What structure acts as the principal communication pathway linking the left and right cerebral hemispheres?',
      options: ['Corpus Callosum', 'Thalamus', 'Hypothalamus', 'Hippocampus'],
      correctOptionIndex: 0,
    ),
    const QuizQuestion(
      questionText: 'Which neurotransmitter is most commonly associated with reward pathways and motor control regulations?',
      options: ['Serotonin', 'GABA', 'Dopamine', 'Acetylcholine'],
      correctOptionIndex: 2,
    ),
    const QuizQuestion(
      questionText: 'Which part of the brain is primarily responsible for long-term memory?',
      options: ['Prefrontal Cortex', 'Hippocampus', 'Amygdala', 'Cerebellum'],
      correctOptionIndex: 1, // Hippocampus (Option B) - Matches the Figma mockup!
    ),
    const QuizQuestion(
      questionText: 'The occipital lobe is primarily specialized in processing which of the following sensory modalities?',
      options: ['Auditory input', 'Tactile sensation', 'Olfactory signaling', 'Visual information'],
      correctOptionIndex: 3,
    ),
    const QuizQuestion(
      questionText: 'Which autonomic structure governs crucial homeostatic metrics such as temperature, hunger, and thirst?',
      options: ['Hypothalamus', 'Medulla Oblongata', 'Pons', 'Basal Ganglia'],
      correctOptionIndex: 0,
    ),
    const QuizQuestion(
      questionText: 'Damage to Broca\'s area in the left frontal hemisphere leads to what cognitive deficit?',
      options: ['Sensory loss', 'Expressive aphasia', 'Receptive aphasia', 'Retrograde amnesia'],
      correctOptionIndex: 1,
    ),
    const QuizQuestion(
      questionText: 'Which brain system is principally responsible for emotional processing, fear, and motivation states?',
      options: ['Endocrine System', 'Limbic System', 'Visual Cortex', 'Somatosensory strip'],
      correctOptionIndex: 1,
    ),
    const QuizQuestion(
      questionText: 'The primary somatosensory cortex is situated in which of the four main cerebral lobes?',
      options: ['Parietal Lobe', 'Occipital Lobe', 'Frontal Lobe', 'Temporal Lobe'],
      correctOptionIndex: 0,
    ),
    const QuizQuestion(
      questionText: 'Which structure sits at the base of the skull and regulates balance, posture, and fine motor coordination?',
      options: ['Thalamus', 'Amgydala', 'Cerebellum', 'Pons'],
      correctOptionIndex: 2,
    ),
  ];

  List<QuizQuestion> get quizQuestions => _quizQuestions;
  
  QuizQuestion get currentQuestion => _quizQuestions[_currentQuestionIndex];

  void selectAnswer(int index) {
    _selectedAnswerIndex = index;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _quizQuestions.length - 1) {
      _currentQuestionIndex++;
      _selectedAnswerIndex = null;
    } else {
      // Quiz finished, reset or loop
      _currentQuestionIndex = 0;
      _selectedAnswerIndex = null;
    }
    notifyListeners();
  }

  void startQuizForModule(String moduleId) {
    _selectedModuleId = moduleId;
    _currentQuestionIndex = 0; // Start at beginning or 3 to show demo
    _selectedAnswerIndex = null;
    _currentTabIndex = 3; // Switch to the Quiz tab (index 3)
    notifyListeners();
  }
}
