import 'package:frontend/core/imports/core_imports.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Notification',
          style: context.theme.textTheme.labelSmall,
        ),
      ),
    );
  }
}
