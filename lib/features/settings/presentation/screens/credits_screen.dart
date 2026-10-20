import 'package:cafe_analog_app/core/snackbar.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/core/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

const _analogIoGitHubUrl = 'https://github.com/AnalogIO/';

class CreditsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Credits',
      children: [
        const SectionTitle('Development team'),
        const Padding(
          padding: .symmetric(horizontal: 16),
          child: Text(
            'The Café Analog app is built and maintained by volunteers in '
            'AnalogIO, the student organisation behind the café.',
          ),
        ),
        const Gap(8),
        ListTile(
          leading: const Icon(Icons.code),
          title: const Text('AnalogIO on GitHub'),
          subtitle: const Text('github.com/AnalogIO'),
          onTap: () => _openExternalPage(
            context,
            url: _analogIoGitHubUrl,
            documentName: 'GitHub',
          ),
        ),
        const Gap(24),
        const SectionTitle('About AnalogIO'),
        const Padding(
          padding: .symmetric(horizontal: 16),
          child: Text(
            'AnalogIO is a group of volunteer software students supporting '
            'Café Analog. We create and maintain the backend systems, apps and '
            'websites used by customers and baristas.',
          ),
        ),
        const Gap(24),
        const SectionTitle('Licenses'),
        ListTile(
          leading: const Icon(Icons.description_outlined),
          title: const Text('View open source licenses'),
          onTap: () => context.go('/settings/licenses'),
        ),
      ],
    );
  }

  Future<void> _openExternalPage(
    BuildContext context, {
    required String url,
    required String documentName,
  }) async {
    final launched = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppBrowserView,
    );
    if (!launched && context.mounted) {
      showSnackBar(context: context, message: 'Could not open $documentName');
    }
  }
}
