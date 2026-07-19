import 'package:flutter/material.dart';
import 'module_model.dart';
import 'chapter_model.dart';

/// Single source of truth for all local module and chapter data.
/// Replace the content of each [ModuleModel] with database-fetched data later
/// without touching any screen code.
class SampleModuleData {
  SampleModuleData._();

  static const List<ModuleModel> modules = [
    // ── Visual Structures ───────────────────────────────────────────────────
    ModuleModel(
      id: 'visual_structures',
      title: 'Visual Structures',
      description:
          'Explore the anatomy and physiology of the human visual system, '
          'from the cornea to the occipital lobe.',
      progress: 0.85,
      icon: Icons.visibility_rounded,
      chapters: [
        ChapterModel(
          chapterNumber: 1,
          title: 'Introduction to the Human Eye',
          content:
              'The human eye is a remarkable organ that captures light and '
              'converts it into neural signals. In this chapter, we explore '
              'its overall structure and evolutionary significance.',
        ),
        ChapterModel(
          chapterNumber: 2,
          title: 'Anatomy of the Eye',
          content:
              'We examine the major anatomical components: the cornea, iris, '
              'pupil, lens, and vitreous humour, and how each contributes to '
              'focusing light onto the retina.',
        ),
        ChapterModel(
          chapterNumber: 3,
          title: 'The Retina',
          content:
              'The retina contains photoreceptors — rods for low-light vision '
              'and cones for colour perception. This chapter covers the layered '
              'structure of the retina and the phototransduction cascade.',
        ),
        ChapterModel(
          chapterNumber: 4,
          title: 'The Optic Nerve',
          content:
              'The optic nerve transmits visual information from the retina to '
              'the brain. We discuss the optic disc, blind spot, and the path '
              'through the optic chiasm to the lateral geniculate nucleus.',
        ),
        ChapterModel(
          chapterNumber: 5,
          title: 'Common Eye Disorders',
          content:
              'This chapter surveys prevalent conditions such as myopia, '
              'hyperopia, glaucoma, cataracts, and macular degeneration, '
              'including their causes and current treatment approaches.',
        ),
      ],
    ),

    // ── Sensory & Perception ────────────────────────────────────────────────
    ModuleModel(
      id: 'sensory_perception',
      title: 'Sensory & Perception',
      description:
          'How we interpret environmental stimuli through sensory organs '
          'and higher-order cortical processing.',
      progress: 0.45,
      icon: Icons.psychology_rounded,
      chapters: [
        ChapterModel(
          chapterNumber: 1,
          title: 'Overview of Sensory Systems',
          content:
              'An introduction to the five classical senses and the modern '
              'understanding of interoception, proprioception, and '
              'nociception.',
        ),
        ChapterModel(
          chapterNumber: 2,
          title: 'Visual Perception',
          content:
              'From raw retinal signals to conscious sight: feature detection, '
              'depth perception, and object recognition in the visual cortex.',
        ),
        ChapterModel(
          chapterNumber: 3,
          title: 'Auditory Perception',
          content:
              'Sound wave transduction in the cochlea, frequency mapping on '
              'the basilar membrane, and the auditory pathway to the temporal '
              'lobe.',
        ),
        ChapterModel(
          chapterNumber: 4,
          title: 'Touch and Proprioception',
          content:
              'Mechanoreceptors in the skin, Meissner and Pacinian corpuscles, '
              'and the somatosensory cortex\'s role in body schema.',
        ),
        ChapterModel(
          chapterNumber: 5,
          title: 'Multisensory Integration',
          content:
              'How the brain combines signals across modalities — the McGurk '
              'effect, rubber-hand illusion, and clinical implications of '
              'cross-modal plasticity.',
        ),
      ],
    ),

    // ── Attention & Focus ───────────────────────────────────────────────────
    ModuleModel(
      id: 'attention_focus',
      title: 'Attention & Focus',
      description:
          'Mechanisms of selective attention, sustained concentration, '
          'and the neural circuits underlying attentional control.',
      progress: 0.20,
      icon: Icons.track_changes_rounded,
      chapters: [
        ChapterModel(
          chapterNumber: 1,
          title: 'Theories of Attention',
          content:
              'From Broadbent\'s filter model to Treisman\'s attenuation '
              'theory and the biased-competition model — a historical survey '
              'of how scientists conceptualise attention.',
        ),
        ChapterModel(
          chapterNumber: 2,
          title: 'Selective Attention',
          content:
              'Spotlight and zoom-lens metaphors, top-down vs. bottom-up '
              'capture, and the role of the prefrontal cortex in directing '
              'attentional resources.',
        ),
        ChapterModel(
          chapterNumber: 3,
          title: 'Sustained Attention',
          content:
              'Vigilance tasks, signal detection theory, and the neural '
              'correlates of maintaining focus over extended time periods.',
        ),
        ChapterModel(
          chapterNumber: 4,
          title: 'Divided Attention & Multitasking',
          content:
              'The cognitive costs of task-switching, the central bottleneck '
              'hypothesis, and why true multitasking is largely a myth.',
        ),
        ChapterModel(
          chapterNumber: 5,
          title: 'Attention Disorders',
          content:
              'ADHD, acquired attention deficits after stroke, and current '
              'pharmacological and behavioural interventions.',
        ),
      ],
    ),

    // ── Problem Solving ─────────────────────────────────────────────────────
    ModuleModel(
      id: 'problem_solving',
      title: 'Problem Solving',
      description:
          'Higher-level executive function and reasoning paradigms '
          'that underpin human intelligence.',
      progress: 0.0,
      icon: Icons.lightbulb_rounded,
      chapters: [
        ChapterModel(
          chapterNumber: 1,
          title: 'Introduction to Problem Solving',
          content:
              'What is a problem? We define problem spaces, initial states, '
              'goal states, and the operators that transform one into the '
              'other.',
        ),
        ChapterModel(
          chapterNumber: 2,
          title: 'Heuristics and Algorithms',
          content:
              'Systematic versus heuristic approaches, means-ends analysis, '
              'hill climbing, and when shortcuts lead us astray.',
        ),
        ChapterModel(
          chapterNumber: 3,
          title: 'Creative Problem Solving',
          content:
              'Insight, restructuring, and the "aha" moment — neural '
              'correlates of creative cognition and divergent thinking.',
        ),
        ChapterModel(
          chapterNumber: 4,
          title: 'Decision Making Under Uncertainty',
          content:
              'Prospect theory, cognitive biases (anchoring, availability, '
              'confirmation bias), and Bayesian reasoning in everyday '
              'decisions.',
        ),
        ChapterModel(
          chapterNumber: 5,
          title: 'Executive Functions & Planning',
          content:
              'The prefrontal cortex\'s role in goal-setting, inhibition, '
              'cognitive flexibility, and working memory as the seat of '
              'executive control.',
        ),
      ],
    ),

    // ── Memory & Recall ─────────────────────────────────────────────────────
    ModuleModel(
      id: 'memory_recall',
      title: 'Memory & Recall',
      description:
          'Short-term, long-term, and sensory memory retention — from '
          'encoding to retrieval.',
      progress: 0.10,
      icon: Icons.memory_rounded,
      chapters: [
        ChapterModel(
          chapterNumber: 1,
          title: 'Memory Systems Overview',
          content:
              'Sensory, working, and long-term memory — Atkinson & Shiffrin\'s '
              'multi-store model and Baddeley\'s working memory model '
              'introduced.',
        ),
        ChapterModel(
          chapterNumber: 2,
          title: 'Encoding',
          content:
              'Levels of processing, elaborative rehearsal, the self-reference '
              'effect, and mnemonic strategies that strengthen encoding.',
        ),
        ChapterModel(
          chapterNumber: 3,
          title: 'Storage',
          content:
              'Synaptic consolidation, systems consolidation, the role of the '
              'hippocampus, and why sleep is critical for memory stabilisation.',
        ),
        ChapterModel(
          chapterNumber: 4,
          title: 'Retrieval & Forgetting',
          content:
              'Recall vs. recognition, cue-dependent forgetting, interference '
              'theory, and the reconstructive nature of memory.',
        ),
        ChapterModel(
          chapterNumber: 5,
          title: 'Memory Disorders',
          content:
              'Amnesia (anterograde & retrograde), Alzheimer\'s disease, '
              'Korsakoff syndrome — mechanisms, symptoms, and care.',
        ),
      ],
    ),

    // ── Cognitive Science ───────────────────────────────────────────────────
    ModuleModel(
      id: 'cognitive_science',
      title: 'Cognitive Science',
      description:
          'Foundations of cognitive architectures and models that bridge '
          'neuroscience, psychology, AI, and linguistics.',
      progress: 0.92,
      icon: Icons.auto_awesome_rounded,
      chapters: [
        ChapterModel(
          chapterNumber: 1,
          title: 'Introduction to Cognitive Science',
          content:
              'The interdisciplinary nature of cognitive science: psychology, '
              'neuroscience, linguistics, philosophy, and computer science '
              'working in concert.',
        ),
        ChapterModel(
          chapterNumber: 2,
          title: 'Cognitive Architectures',
          content:
              'ACT-R, SOAR, and connectionist models — how researchers '
              'formalise cognition in computational terms.',
        ),
        ChapterModel(
          chapterNumber: 3,
          title: 'Language and Thought',
          content:
              'Linguistic relativity (Sapir-Whorf hypothesis), Chomsky\'s '
              'universal grammar, and debates about the relationship between '
              'language and conceptual thought.',
        ),
        ChapterModel(
          chapterNumber: 4,
          title: 'Embodied Cognition',
          content:
              'How the body shapes the mind: grounded cognition, enactivism, '
              'and why physical interaction with the world is central to '
              'understanding.',
        ),
        ChapterModel(
          chapterNumber: 5,
          title: 'Artificial Intelligence & Cognition',
          content:
              'From symbolic AI to deep learning: comparisons between machine '
              'and human intelligence, current benchmarks, and the future of '
              'cognitive computing.',
        ),
      ],
    ),
  ];

  /// Looks up a [ModuleModel] by its [id], returns null if not found.
  static ModuleModel? findById(String id) {
    try {
      return modules.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }
}
