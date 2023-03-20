import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/utils/ui_utils.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/headline.dart';

class ServicesScreen extends ConsumerStatefulWidget {
  const ServicesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends ConsumerState<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context);

    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: Column(
          children: [
            SizedBox(height: whenLayout(mobile: 32.ms, tablet: 48.ts)),
            const Headline(
              text: 'HOME SCREEN',
            ),
            SizedBox(height: whenLayout(mobile: 32.ms, tablet: 48.ts)),
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: whenLayout(mobile: 8.ms, tablet: 16.ts),
                runSpacing: whenLayout(mobile: 8.ms, tablet: 16.ts),
                children: [
                  serviceTile(),
                  ordersTile(),
                ],
              ),
            ),
            SizedBox(height: whenLayout(mobile: 32.ms, tablet: 48.ts)),
          ],
        ),
      ),
    );
  }

  Widget serviceTile() {
    return Container(
      width: whenLayout(mobile: 160.ms, tablet: 300.ts),
      height: whenLayout(mobile: 160.ms, tablet: 268.ts),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(whenLayout(mobile: 8.ms, tablet: 16.ts)),
        color: AppColors.primary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.router.navigate(const RSCategoriesScreenRoute());
          },
          child: Center(
            child: Text(
              'SERVICES',
              style: TextStyle(
                color: Colors.white,
                fontSize: whenLayout(mobile: 16.ms, tablet: 24.ts),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ordersTile() {
    return Container(
      width: whenLayout(mobile: 160.ms, tablet: 300.ts),
      height: whenLayout(mobile: 160.ms, tablet: 268.ts),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(whenLayout(mobile: 8.ms, tablet: 16.ts)),
        color: AppColors.primary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Orders screen is not implemented yet'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Center(
            child: Text(
              'TOVARS',
              style: TextStyle(
                color: Colors.white,
                fontSize: whenLayout(mobile: 16.ms, tablet: 24.ts),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
