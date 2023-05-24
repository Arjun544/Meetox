import 'package:frontend/core/imports/core_imports.dart';

class UnFocuser extends StatelessWidget {

  const UnFocuser({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
