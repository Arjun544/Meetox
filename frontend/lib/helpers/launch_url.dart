import 'package:frontend/helpers/show_toast.dart';
import 'package:url_launcher/url_launcher.dart';

void appLaunchUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  } else {
    showToast('Could not launch url');
  }
}
