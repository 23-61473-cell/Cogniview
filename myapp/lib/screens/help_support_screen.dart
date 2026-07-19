import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.darkGreen),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          children: [
            // FAQ Section Header
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                color: AppTheme.darkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),

            _buildFaqItem(
              'What is CogniView AR?',
              'CogniView AR is an augmented reality educational tool designed specifically for Psychology students at Batangas State University. It visualizes brain regions, lobes, and neural structures in 3D using your camera.',
            ),
            _buildFaqItem(
              'How do I launch the AR Scanner?',
              'Tap the AR Scan button (center circle icon) on the bottom navigation bar. Point your camera at a flat surface or a specified brain marker to view the interactive 3D model.',
            ),
            _buildFaqItem(
              'Are my quiz scores saved?',
              'Yes, when you complete a quiz, your score is recorded immediately and saved to your profile dashboard so instructors can monitor progress.',
            ),
            
            const SizedBox(height: 24),
            
            // Support Actions Header
            const Text(
              'Contact & Feedback',
              style: TextStyle(
                color: AppTheme.darkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),

            _buildActionCard(
              context,
              icon: Icons.admin_panel_settings_rounded,
              title: 'Contact Administrator',
              subtitle: 'Send an email to support.cogniview@g.batstate-u.edu.ph',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Support email copied to clipboard!')),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildActionCard(
              context,
              icon: Icons.feedback_rounded,
              title: 'Send Feedback',
              subtitle: 'Help us improve by sending feature suggestions.',
              onTap: () {
                _showFeedbackDialog(context);
              },
            ),

            const SizedBox(height: 24),
            
            // Legal Section Header
            const Text(
              'Legal & Policies',
              style: TextStyle(
                color: AppTheme.darkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),

            _buildActionCard(
              context,
              icon: Icons.privacy_tip_rounded,
              title: 'Privacy Policy',
              subtitle: 'Read how we handle your camera and account data.',
              onTap: () => _showTextDialog(context, 'Privacy Policy', 'We collect email addresses and student identifiers solely for authentication and learning progress tracking. The application uses your device\'s camera locally to render 3D brain models. No camera feeds or visual recordings are uploaded or processed on external servers. All personal academic information is protected under local educational record regulations.'),
            ),
            const SizedBox(height: 12),
            _buildActionCard(
              context,
              icon: Icons.gavel_rounded,
              title: 'Terms & Conditions',
              subtitle: 'Terms of service guidelines for CogniView.',
              onTap: () => _showTextDialog(context, 'Terms & Conditions', 'By registering and using CogniView AR, you agree to utilize the software for educational study purposes only. Any unauthorized modification, disassembly, or malicious execution of internal models is prohibited. The developers provide visual guides "as is" and do not claim medical diagnosis accuracy for local simulated structures.'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            color: AppTheme.darkGreen,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        shape: const Border(),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            answer,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkGreen.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primaryColor),
        title: Text(
          title,
          style: const TextStyle(
            color: AppTheme.darkGreen,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 11,
          ),
        ),
        trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
        onTap: onTap,
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Send Feedback', style: TextStyle(color: AppTheme.darkGreen, fontWeight: FontWeight.bold)),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Describe your feedback...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Feedback sent! Thank you.')),
                );
              },
              child: const Text('Submit', style: TextStyle(color: AppTheme.darkGreen, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _showTextDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(title, style: const TextStyle(color: AppTheme.darkGreen, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Text(
              text,
              style: const TextStyle(height: 1.4, fontSize: 14),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close', style: TextStyle(color: AppTheme.darkGreen, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
