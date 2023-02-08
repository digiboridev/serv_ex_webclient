import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';

class AuthDataError extends ConsumerStatefulWidget {
  const AuthDataError({
    Key? key,
    required this.error,
  }) : super(key: key);

  final String error;

  @override
  ConsumerState<AuthDataError> createState() => _ErrorSubpageState();
}

class _ErrorSubpageState extends ConsumerState<AuthDataError> {
  onRetry() {
    ref.read(authScreenControllerProvider.notifier).updateState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Error',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.error,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 200,
            child: Material(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  onRetry();
                },
                child: Ink(
                  // width: 600,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Retry',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
