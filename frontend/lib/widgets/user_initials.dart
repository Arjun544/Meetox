import 'package:frontend/core/imports/core_imports.dart';

class UserInititals extends StatelessWidget {
  const UserInititals({
    required this.name,
    super.key,
    this.fontSize,
    this.radius,
    this.color,
  });
  final String name;
  final double? fontSize;
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color ?? AppColors.primaryYellow.withOpacity(0.5),
      radius: radius ?? 20,
      child: Text(
        name.isNotEmpty
            ? name
                .trim()
                .split(RegExp(' +'))
                .map((s) => s[0])
                .take(2)
                .join()
                .toUpperCase()
            : '',
        style: context.theme.textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: fontSize ?? context.theme.textTheme.labelLarge!.fontSize,
        ),
      ),
    );
  }
}
