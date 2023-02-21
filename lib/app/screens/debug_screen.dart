import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/log.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/categories_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/app/app_providers.dart';
import 'package:serv_expert_webclient/app/contributor_controller.dart';
import 'package:serv_expert_webclient/router.gr.dart';

class SB extends ConsumerWidget {
  const SB({super.key});

  void test(WidgetRef ref) async {
    RSCategoriesRepository rep = ref.read(rsCategoriesRepositoryProvider);
    // RSBreakingTypesRepository rep2 = ref.read(rsBreakingTypesRepositoryProvider);

    // List<RSCategory> cats = [
    //   RSCategory(global: false, id: rep.generateId(), name: 'Phone/Tablet', type: RSCType.category),
    //   RSCategory(global: false, id: rep.generateId(), name: 'Laptop', type: RSCType.category),
    //   RSCategory(global: false, id: rep.generateId(), name: 'PC', type: RSCType.category),
    //   RSCategory(global: false, id: rep.generateId(), name: 'TV', type: RSCType.category),
    //   RSCategory(global: false, id: rep.generateId(), name: 'Gaming console', type: RSCType.category),
    //   RSCategory(global: false, id: rep.generateId(), name: 'Other', type: RSCType.category),
    // ];

    // List<RSCategory> cats = [
    //   // phone subcats
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'CsUHBDbcBkOw7BZB7pEt', name: 'Android device', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'CsUHBDbcBkOw7BZB7pEt', name: 'IOS device', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'CsUHBDbcBkOw7BZB7pEt', name: 'Drawing tablets', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'CsUHBDbcBkOw7BZB7pEt', name: 'eReader', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'CsUHBDbcBkOw7BZB7pEt', name: 'Other device', type: RSCType.subcategory),
    //   // laptop subcats
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'DnEEQEBTZBHx1tv2jABP', name: 'Apple laptop', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'DnEEQEBTZBHx1tv2jABP', name: 'Office laptop', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'DnEEQEBTZBHx1tv2jABP', name: 'Gaming laptop', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'DnEEQEBTZBHx1tv2jABP', name: 'Chromebook', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'DnEEQEBTZBHx1tv2jABP', name: 'Transformer', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'DnEEQEBTZBHx1tv2jABP', name: 'Other', type: RSCType.subcategory),

    //   // PC subcats
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'my0rrtWzXCVmCGt7GNzY', name: 'Apple PC', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'my0rrtWzXCVmCGt7GNzY', name: 'Office PC', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'my0rrtWzXCVmCGt7GNzY', name: 'Gaming PC', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'my0rrtWzXCVmCGt7GNzY', name: 'AIO', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'my0rrtWzXCVmCGt7GNzY', name: 'Other', type: RSCType.subcategory),

    //   // TV subcats
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'E3Z7mvp0KCmBr2PbhTVT', name: 'LCD', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'E3Z7mvp0KCmBr2PbhTVT', name: 'LED', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'E3Z7mvp0KCmBr2PbhTVT', name: 'OLED', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'E3Z7mvp0KCmBr2PbhTVT', name: 'Plasma', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'E3Z7mvp0KCmBr2PbhTVT', name: 'Other', type: RSCType.subcategory),

    //   // Gaming console subcats
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'obH0Kq9PGqxYJM7vzKqz', name: 'Playstation', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'obH0Kq9PGqxYJM7vzKqz', name: 'Xbox', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'obH0Kq9PGqxYJM7vzKqz', name: 'Nintendo', type: RSCType.subcategory),
    //   RSCategory(global: false, id: rep.generateId(), parentId: 'obH0Kq9PGqxYJM7vzKqz', name: 'Other', type: RSCType.subcategory),

    // ];

    // for (RSCategory cat in cats) {
    //   await rep.setCategory(cat);
    // }

    // log(cats.map((e) => e.id));

    // ios device breakings
    // List<RSBreakingType> asd = [
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Display isnt working', categoryId: '9xQZLlZWjMhHdgHzePsq'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Speakers isnt working', categoryId: '9xQZLlZWjMhHdgHzePsq'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Camera isnt working', categoryId: '9xQZLlZWjMhHdgHzePsq'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Battery or charging problems', categoryId: '9xQZLlZWjMhHdgHzePsq'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'RF signal problems', categoryId: '9xQZLlZWjMhHdgHzePsq'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Apple ID recovery', categoryId: '9xQZLlZWjMhHdgHzePsq'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: '3.5mm jack is missing', categoryId: '9xQZLlZWjMhHdgHzePsq'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Software problems', categoryId: '9xQZLlZWjMhHdgHzePsq'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Other', categoryId: '9xQZLlZWjMhHdgHzePsq'),
    // ];

    // asd.forEach((element) async {
    //   await rep2.setVendorBreakingType(vendorId: 'ldcj3mU7kWGJpQh6hgMM', rsBreakingType: element);
    // });

    // android device breakings
    // List<RSBreakingType> asd = [
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Display isnt working', categoryId: 'sR47gCR4uAnUS6asbloF'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Speakers isnt working', categoryId: 'sR47gCR4uAnUS6asbloF'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Camera isnt working', categoryId: 'sR47gCR4uAnUS6asbloF'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Battery or charging problems', categoryId: 'sR47gCR4uAnUS6asbloF'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'RF signal problems', categoryId: 'sR47gCR4uAnUS6asbloF'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Software problems', categoryId: 'sR47gCR4uAnUS6asbloF'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Other', categoryId: 'sR47gCR4uAnUS6asbloF'),
    // ];

    // asd.forEach((element) async {
    //   await rep2.setVendorBreakingType(vendorId: 'ldcj3mU7kWGJpQh6hgMM', rsBreakingType: element);
    // });

    // ereader device breakings
    // List<RSBreakingType> asd = [
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Display isnt working', categoryId: 'LNSnZrch0IYLaIYA5kMt'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Battery or charging problems', categoryId: 'LNSnZrch0IYLaIYA5kMt'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Software problems', categoryId: 'LNSnZrch0IYLaIYA5kMt'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Other', categoryId: 'LNSnZrch0IYLaIYA5kMt'),
    // ];

    // asd.forEach((element) async {
    //   await rep2.setVendorBreakingType(vendorId: 'ldcj3mU7kWGJpQh6hgMM', rsBreakingType: element);
    // });

    // drawing device breakings
    // List<RSBreakingType> asd = [
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Display isnt working', categoryId: 'SeKOQSMEian7mVKmFGMz'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Sensor isnt working', categoryId: 'SeKOQSMEian7mVKmFGMz'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Stylus dont recogrizing', categoryId: 'SeKOQSMEian7mVKmFGMz'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Battery or charging problems', categoryId: 'SeKOQSMEian7mVKmFGMz'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Software problems', categoryId: 'SeKOQSMEian7mVKmFGMz'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Other', categoryId: 'SeKOQSMEian7mVKmFGMz'),
    // ];

    // asd.forEach((element) async {
    //   await rep2.setVendorBreakingType(vendorId: 'ldcj3mU7kWGJpQh6hgMM', rsBreakingType: element);
    // });

    // other phone tablet device breakings
    // List<RSBreakingType> asd = [
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Hardware problems', categoryId: 'IjtNtisxhfXLxgXcJPD4'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Software problems', categoryId: 'IjtNtisxhfXLxgXcJPD4'),
    //   RSBreakingType(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Other', categoryId: 'IjtNtisxhfXLxgXcJPD4'),
    // ];

    // asd.forEach((element) async {
    //   await rep2.setVendorBreakingType(vendorId: 'ldcj3mU7kWGJpQh6hgMM', rsBreakingType: element);
    // });

    // List<RSCategory> categories = await rep.vendorCategories('ldcj3mU7kWGJpQh6hgMM');
    // categories.forEach((element) {
    //   var nc = element.copyWith(
    //       imageUri:
    //           'https://firebasestorage.googleapis.com/v0/b/serv-expert.appspot.com/o/rs_categories%2Fother.png?alt=media&token=462cb016-8619-4c17-a0bd-1c07ab5fed3a');
    //   rep.setVendorCategory(vendorId: 'ldcj3mU7kWGJpQh6hgMM', category: nc);
    //   print(element.name);
    // });

    log('object');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ContributorState contributorState = ref.watch(contributorControllerProvider);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('V: 0.0.12'),
            SelectableText(context.router.root.stack.toString()),
            SelectableText('height: $height, width: $width'),
            SelectableText('Authorized: ${ref.read(authServiceProvider).authorized}'),
            SelectableText(ref.read(authServiceProvider).uid.toString()),
            SelectableText(ref.read(authServiceProvider).email.toString()),
            SelectableText(ref.read(authServiceProvider).phoneNumber.toString()),
            SelectableText(contributorState.toString()),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                ref.read(contributorControllerProvider.notifier).clearContributor();
              },
              child: const Text('Unassign contributor'),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                ref.read(authServiceProvider).signOut();
                context.router.replaceAll([const AuthScreenRoute()]);
              },
              child: const Text('Sign out'),
            ),
            const SizedBox(
              height: 16,
            ),
            Tooltip(
              message: 'Yobana',
              child: ElevatedButton(
                onPressed: () => test(ref),
                child: const Text('Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
