import 'package:frontend/core/imports/core_imports.dart';

class OnlineIndicator extends StatelessWidget {
  const OnlineIndicator({required this.id, super.key});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        height: 10,
        width: 10,
        decoration: const BoxDecoration(
          color: Colors.green,
          // color: onlineUsers.any((element) => element == id)
          //     ? Colors.greenAccent
          //     : Colors.red[300],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
