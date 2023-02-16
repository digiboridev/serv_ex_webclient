import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';

class RSOrderSubmittedScreen extends ConsumerStatefulWidget {
  const RSOrderSubmittedScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RSOrderSubmittedScreenState();
}

class _RSOrderSubmittedScreenState extends ConsumerState<RSOrderSubmittedScreen> {
  onOk() {
    context.router.navigate(const App());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: Column(
          children: [
            const MinSpacer(
              minHeight: 32,
            ),
            const Text(
              'ORDER SUBMITTED',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const MinSpacer(
              minHeight: 32,
            ),
            homeButton(),
            const MinSpacer(
              minHeight: 32,
            ),
          ],
        ),
      ),
    );
  }

  Widget homeButton() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onOk,
            child: Ink(
              // width: 600,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Home',
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
    );
  }
}
