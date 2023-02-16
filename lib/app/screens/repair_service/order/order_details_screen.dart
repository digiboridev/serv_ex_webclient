// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/dto/repair_service/new_order.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';

class RSOrderDetailsScreen extends ConsumerStatefulWidget {
  const RSOrderDetailsScreen({
    required this.newOrder,
    super.key,
  });

  final RSNewOrderDTO newOrder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RSOrderDetailsScreenState();
}

class _RSOrderDetailsScreenState extends ConsumerState<RSOrderDetailsScreen> {
  final formKey = GlobalKey<FormState>();

  String description = '';
  bool deviceWet = false;
  String wetDescription = '';
  bool accesoriesIncluded = false;
  String accesoriesDescription = '';

  onSubmit() {
    bool? valid = formKey.currentState?.validate();
    if (valid ?? false) {
      RSNewOrderDTO newOrder = widget.newOrder;
      newOrder.description = description;
      newOrder.deviceWet = deviceWet;
      newOrder.wetDescription = wetDescription;
      newOrder.accesoriesIncluded = accesoriesIncluded;
      newOrder.accesoriesDescription = accesoriesDescription;

      context.router.navigate(RSOrderWarantyScreenRoute(newOrder: newOrder));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.router.pop(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                'ORDER',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              descriptionField(),
              const SizedBox(
                height: 16,
              ),
              deviceWetRadio(),
              const SizedBox(
                height: 16,
              ),
              wetDescriptionField(),
              const SizedBox(
                height: 16,
              ),
              deviceAccesoriesRadio(),
              const SizedBox(
                height: 16,
              ),
              accesoriesDescriptionField(),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              const MinSpacer(
                minHeight: 32,
              ),
              nextButton(),
              const MinSpacer(
                minHeight: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nextButton() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onSubmit,
            child: Ink(
              // width: 600,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Next',
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

  Widget deviceAccesoriesRadio() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Accesories included?'),
            const SizedBox(
              height: 8,
            ),
            Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  value: true,
                  groupValue: accesoriesIncluded,
                  onChanged: (value) {
                    setState(() => accesoriesIncluded = value!);
                  },
                ),
                const Text('Yes'),
              ],
            ),
            Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  value: false,
                  groupValue: accesoriesIncluded,
                  onChanged: (value) {
                    setState(() => accesoriesIncluded = value!);
                  },
                ),
                const Text('No'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget deviceWetRadio() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Is your device wet?'),
            const SizedBox(
              height: 8,
            ),
            Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  value: true,
                  groupValue: deviceWet,
                  onChanged: (value) {
                    setState(() => deviceWet = value!);
                  },
                ),
                const Text('Yes'),
              ],
            ),
            Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  value: false,
                  groupValue: deviceWet,
                  onChanged: (value) {
                    setState(() => deviceWet = value!);
                  },
                ),
                const Text('No'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget accesoriesDescriptionField() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          enabled: accesoriesIncluded,
          maxLines: 2,
          keyboardType: TextInputType.multiline,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (!accesoriesIncluded) return null;

            if (value == null || value.isEmpty) {
              return 'Please enter accesories description';
            }

            return null;
          },
          onFieldSubmitted: (value) {
            onSubmit();
          },
          onChanged: (value) {
            accesoriesDescription = value;
          },
          decoration: InputDecoration(
            counter: const SizedBox(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            labelText: 'Accesories description',
            fillColor: Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget wetDescriptionField() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          enabled: deviceWet,
          maxLines: 2,
          keyboardType: TextInputType.multiline,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (!deviceWet) return null;

            if (value == null || value.isEmpty) {
              return 'Please enter wet description';
            }

            return null;
          },
          onFieldSubmitted: (value) {
            onSubmit();
          },
          onChanged: (value) {
            wetDescription = value;
          },
          decoration: InputDecoration(
            counter: const SizedBox(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            labelText: 'Wet description',
            fillColor: Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget descriptionField() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          maxLines: 2,
          keyboardType: TextInputType.multiline,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter description';
            }

            return null;
          },
          onFieldSubmitted: (value) {
            onSubmit();
          },
          onChanged: (value) {
            description = value;
          },
          decoration: InputDecoration(
            counter: const SizedBox(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            labelText: 'Problem description',
            fillColor: Colors.white70,
          ),
        ),
      ),
    );
  }
}
