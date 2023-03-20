import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

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
              style: AppTextStyles.headline,
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
      width: 546,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RegularButton(onTap: onOk, text: 'Home'),
      ),
    );
  }
}
