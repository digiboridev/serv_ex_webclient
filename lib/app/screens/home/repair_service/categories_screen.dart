import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/providers/repair_service/categories_provider.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/utils/ui_utils.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/headline.dart';
import 'package:transparent_image/transparent_image.dart';

class RSCategoriesScreen extends ConsumerStatefulWidget {
  const RSCategoriesScreen({
    super.key,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RSCategoriesScreenState();
}

class _RSCategoriesScreenState extends ConsumerState<RSCategoriesScreen> {
  onCategoryTap(RSCategory category) {
    context.router.navigate(RSSubCategoriesScreenRoute(categoryId: category.id));
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context);

    AsyncValue<List<RSCategory>> categories = ref.watch(rsCategoriesProvider(null));

    return FillableScrollableWrapper(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: whenLayout(mobile: 32.ms, tablet: 48.ts)),
            const Headline(
              text: 'CATEGORY',
            ),
            SizedBox(height: whenLayout(mobile: 32.ms, tablet: 48.ts)),
            Expanded(
              child: categories.when(
                data: (categories) => FadeIn(child: content(categories)),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text(error.toString())),
              ),
            ),
            SizedBox(height: whenLayout(mobile: 32.ms, tablet: 48.ts)),
          ],
        ),
      ),
    );
  }

  Widget content(List<RSCategory> categories) {
    return Wrap(
      spacing: whenLayout(mobile: 8.ms, tablet: 16.ts),
      runSpacing: whenLayout(mobile: 8.ms, tablet: 16.ts),
      children: categories.map((category) => categoryTile(category)).toList(),
    );
  }

  Widget categoryTile(RSCategory category) {
    return Container(
      width: whenLayout(mobile: 160.ms, tablet: 300.ts),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(whenLayout(mobile: 8.ms, tablet: 16.ts)),
        color: AppColors.primary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onCategoryTap(category),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: whenLayout(mobile: 32.ms, tablet: 64.ts)),
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: category.imageUri,
                width: whenLayout(mobile: 80.ms, tablet: 120.ts),
                height: whenLayout(mobile: 80.ms, tablet: 120.ts),
                fit: BoxFit.contain,
              ),
              SizedBox(height: whenLayout(mobile: 8.ms, tablet: 16.ts)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(category.name, style: TextStyle(color: Colors.white, fontSize: whenLayout(mobile: 16.ms, tablet: 24.ts))),
              ),
              SizedBox(height: whenLayout(mobile: 32.ms, tablet: 64.ts)),
            ],
          ),
        ),
      ),
    );
  }
}
