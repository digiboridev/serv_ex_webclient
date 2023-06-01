// import 'package:auto_route/auto_route.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:serv_expert_webclient/core/log.dart';
// import 'package:serv_expert_webclient/data/exceptions.dart';
// import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
// import 'package:serv_expert_webclient/data/reposiotories/repair_service/issues_repository.dart';
// import 'package:serv_expert_webclient/data/reposiotories/repair_service/categories_repository.dart';
// import 'package:serv_expert_webclient/global_providers.dart';
// import 'package:serv_expert_webclient/app/app_providers.dart';
// import 'package:serv_expert_webclient/app/controllers/contributor_controller.dart';
// import 'package:serv_expert_webclient/router.gr.dart';

// class SB extends ConsumerWidget {
//   const SB({super.key});

//   void test(WidgetRef ref) async {
//     RSCategoriesRepository catrep = ref.read(rsCategoriesRepositoryProvider);
//     RSIssuesRepository brrep = ref.read(rsIssuesRepositoryProvider);

//     // List<Category> cats = [
//     //   Category(global: false, id: rep.generateId(), name: 'Phone/Tablet', type: RSCType.category),
//     //   Category(global: false, id: rep.generateId(), name: 'Laptop', type: RSCType.category),
//     //   Category(global: false, id: rep.generateId(), name: 'PC', type: RSCType.category),
//     //   Category(global: false, id: rep.generateId(), name: 'TV', type: RSCType.category),
//     //   Category(global: false, id: rep.generateId(), name: 'Gaming console', type: RSCType.category),
//     //   Category(global: false, id: rep.generateId(), name: 'Other', type: RSCType.category),
//     // ];

//     // List<Category> cats = [
//     //   // phone subcats
//     //   Category(global: false, id: rep.generateId(), parentId: 'CsUHBDbcBkOw7BZB7pEt', name: 'Android device', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'CsUHBDbcBkOw7BZB7pEt', name: 'IOS device', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'CsUHBDbcBkOw7BZB7pEt', name: 'Drawing tablets', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'CsUHBDbcBkOw7BZB7pEt', name: 'eReader', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'CsUHBDbcBkOw7BZB7pEt', name: 'Other device', type: RSCType.subcategory),
//     //   // laptop subcats
//     //   Category(global: false, id: rep.generateId(), parentId: 'DnEEQEBTZBHx1tv2jABP', name: 'Apple laptop', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'DnEEQEBTZBHx1tv2jABP', name: 'Office laptop', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'DnEEQEBTZBHx1tv2jABP', name: 'Gaming laptop', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'DnEEQEBTZBHx1tv2jABP', name: 'Chromebook', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'DnEEQEBTZBHx1tv2jABP', name: 'Transformer', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'DnEEQEBTZBHx1tv2jABP', name: 'Other', type: RSCType.subcategory),

//     //   // PC subcats
//     //   Category(global: false, id: rep.generateId(), parentId: 'my0rrtWzXCVmCGt7GNzY', name: 'Apple PC', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'my0rrtWzXCVmCGt7GNzY', name: 'Office PC', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'my0rrtWzXCVmCGt7GNzY', name: 'Gaming PC', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'my0rrtWzXCVmCGt7GNzY', name: 'AIO', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'my0rrtWzXCVmCGt7GNzY', name: 'Other', type: RSCType.subcategory),

//     //   // TV subcats
//     //   Category(global: false, id: rep.generateId(), parentId: 'E3Z7mvp0KCmBr2PbhTVT', name: 'LCD', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'E3Z7mvp0KCmBr2PbhTVT', name: 'LED', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'E3Z7mvp0KCmBr2PbhTVT', name: 'OLED', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'E3Z7mvp0KCmBr2PbhTVT', name: 'Plasma', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'E3Z7mvp0KCmBr2PbhTVT', name: 'Other', type: RSCType.subcategory),

//     //   // Gaming console subcats
//     //   Category(global: false, id: rep.generateId(), parentId: 'obH0Kq9PGqxYJM7vzKqz', name: 'Playstation', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'obH0Kq9PGqxYJM7vzKqz', name: 'Xbox', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'obH0Kq9PGqxYJM7vzKqz', name: 'Nintendo', type: RSCType.subcategory),
//     //   Category(global: false, id: rep.generateId(), parentId: 'obH0Kq9PGqxYJM7vzKqz', name: 'Other', type: RSCType.subcategory),

//     // ];

//     // for (Category cat in cats) {
//     //   await rep.setCategory(cat);
//     // }

//     // log(cats.map((e) => e.id));

//     // ios device breakings
//     // List<RSIssue> asd = [
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Display isnt working', categoryId: '9xQZLlZWjMhHdgHzePsq'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Speakers isnt working', categoryId: '9xQZLlZWjMhHdgHzePsq'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Camera isnt working', categoryId: '9xQZLlZWjMhHdgHzePsq'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Battery or charging problems', categoryId: '9xQZLlZWjMhHdgHzePsq'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'RF signal problems', categoryId: '9xQZLlZWjMhHdgHzePsq'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Apple ID recovery', categoryId: '9xQZLlZWjMhHdgHzePsq'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: '3.5mm jack is missing', categoryId: '9xQZLlZWjMhHdgHzePsq'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Software problems', categoryId: '9xQZLlZWjMhHdgHzePsq'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Other', categoryId: '9xQZLlZWjMhHdgHzePsq'),
//     // ];

//     // asd.forEach((element) async {
//     //   await rep2.setVendorIssue(vendorId: 'ldcj3mU7kWGJpQh6hgMM', rsIssue: element);
//     // });

//     // android device breakings
//     // List<RSIssue> asd = [
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Display isnt working', categoryId: 'sR47gCR4uAnUS6asbloF'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Speakers isnt working', categoryId: 'sR47gCR4uAnUS6asbloF'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Camera isnt working', categoryId: 'sR47gCR4uAnUS6asbloF'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Battery or charging problems', categoryId: 'sR47gCR4uAnUS6asbloF'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'RF signal problems', categoryId: 'sR47gCR4uAnUS6asbloF'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Software problems', categoryId: 'sR47gCR4uAnUS6asbloF'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Other', categoryId: 'sR47gCR4uAnUS6asbloF'),
//     // ];

//     // asd.forEach((element) async {
//     //   await rep2.setVendorIssue(vendorId: 'ldcj3mU7kWGJpQh6hgMM', rsIssue: element);
//     // });

//     // ereader device breakings
//     // List<RSIssue> asd = [
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Display isnt working', categoryId: 'LNSnZrch0IYLaIYA5kMt'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Battery or charging problems', categoryId: 'LNSnZrch0IYLaIYA5kMt'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Software problems', categoryId: 'LNSnZrch0IYLaIYA5kMt'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Other', categoryId: 'LNSnZrch0IYLaIYA5kMt'),
//     // ];

//     // asd.forEach((element) async {
//     //   await rep2.setVendorIssue(vendorId: 'ldcj3mU7kWGJpQh6hgMM', rsIssue: element);
//     // });

//     // drawing device breakings
//     // List<RSIssue> asd = [
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Display isnt working', categoryId: 'SeKOQSMEian7mVKmFGMz'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Sensor isnt working', categoryId: 'SeKOQSMEian7mVKmFGMz'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Stylus dont recogrizing', categoryId: 'SeKOQSMEian7mVKmFGMz'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Battery or charging problems', categoryId: 'SeKOQSMEian7mVKmFGMz'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Software problems', categoryId: 'SeKOQSMEian7mVKmFGMz'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Other', categoryId: 'SeKOQSMEian7mVKmFGMz'),
//     // ];

//     // asd.forEach((element) async {
//     //   await rep2.setVendorIssue(vendorId: 'ldcj3mU7kWGJpQh6hgMM', rsIssue: element);
//     // });

//     // other phone tablet device breakings
//     // List<RSIssue> asd = [
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Hardware problems', categoryId: 'IjtNtisxhfXLxgXcJPD4'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Software problems', categoryId: 'IjtNtisxhfXLxgXcJPD4'),
//     //   RSIssue(id: rep2.generateId('ldcj3mU7kWGJpQh6hgMM'), name: 'Other', categoryId: 'IjtNtisxhfXLxgXcJPD4'),
//     // ];

//     // var cats = await catrep.vendorCategories('ldcj3mU7kWGJpQh6hgMM');

//     // cats.forEach((cat) async {
//     //   await catrep.setCategory(cat);
//     // });

//     // var brks = await brrep.vendorIssues('ldcj3mU7kWGJpQh6hgMM');

//     // brks.forEach((brk) async {
//     //   await brrep.setIssue(brk);
//     // });

//     log('object');

//     try {
//       final result = await FirebaseFunctions.instanceFor(region: 'europe-west1').httpsCallable('userDetailsSubmit').call(
//         {
//           'firstName': 'string',
//         },
//       );
//       log(result);
//     } catch (e, s) {
//       log(e, stackTrace: s);

//       if (e is FirebaseFunctionsException && e.code == 'unauthenticated') {
//         throw Unauthorized(e.message ?? 'Unauthorized');
//       }
//       if (e is FirebaseFunctionsException && e.code == 'invalid-argument') {
//         throw InvalidArgument(e.message ?? 'Invalid argument');
//       }
//       throw UnknownException(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ContributorState contributorState = ref.watch(contributorControllerProvider);
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SizedBox.expand(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text('V: 0.0.14'),
//             SelectableText(context.router.root.stack.toString()),
//             SelectableText('height: $height, width: $width'),
//             SelectableText('Authorized: ${ref.read(authServiceProvider).authorized}'),
//             SelectableText(ref.read(authServiceProvider).uid.toString()),
//             SelectableText(ref.read(authServiceProvider).email.toString()),
//             SelectableText(ref.read(authServiceProvider).phoneNumber.toString()),
//             SelectableText(contributorState.toString()),
//             const SizedBox(
//               height: 16,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 ref.read(contributorControllerProvider.notifier).clearContributor();
//               },
//               child: const Text('Unassign contributor'),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 ref.read(authServiceProvider).signOut();
//                 context.router.replaceAll([const AuthScreenRoute()]);
//               },
//               child: const Text('Sign out'),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Tooltip(
//               message: 'Yobana',
//               child: ElevatedButton(
//                 onPressed: () => test(ref),
//                 child: const Text('Test'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
