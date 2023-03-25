import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/widgets/pattern_lock/pattern_lock.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/log.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/data/dto/repair_service/new_order.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/services/rs_orders_service.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/widgets/loading_wrapper.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

class RSOrderPasswordScreen extends ConsumerStatefulWidget {
  const RSOrderPasswordScreen({
    required this.newOrder,
    super.key,
  });

  final RSNewOrderDTO newOrder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RSOrderPasswordScreenState();
}

class _RSOrderPasswordScreenState extends ConsumerState<RSOrderPasswordScreen> {
  bool busy = false;

  onPasswordSubmitted(String password) async {
    if (busy) return;
    RSNewOrderDTO newOrder = widget.newOrder;
    RSOrdersService ordersService = ref.read(rsOrdersServiceProvider);

    setState(() => busy = true);

    try {
      await ordersService.createOrder(order: newOrder);
      if (mounted) {
        context.router.navigate(const RSOrderSubmittedScreenRoute());
      }
    } catch (e) {
      log(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    setState(() => busy = false);
  }

  onPatternSubmitted(List<int> points) async {
    if (busy) return;
    RSNewOrderDTO newOrder = widget.newOrder;
    RSOrdersService ordersService = ref.read(rsOrdersServiceProvider);

    setState(() => busy = true);

    try {
      await ordersService.createOrder(order: newOrder);
      if (mounted) {
        context.router.navigate(const RSOrderSubmittedScreenRoute());
      }
    } catch (e) {
      log(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    setState(() => busy = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: LoadingWrapper(
          busy: busy,
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
              if (widget.newOrder.passwordType == DevicePasswordType.numeric)
                Expanded(
                    child: NumericForm(
                  onSubmit: onPasswordSubmitted,
                ))
              else if (widget.newOrder.passwordType == DevicePasswordType.pattern)
                Expanded(child: PatternForm(onSubmit: onPatternSubmitted))
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class PatternForm extends ConsumerStatefulWidget {
  const PatternForm({required this.onSubmit, super.key});

  final Function(List<int> points) onSubmit;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PatternFormState();
}

class _PatternFormState extends ConsumerState<PatternForm> {
  List<int> points = [];

  reset() => setState(() => points = []);

  submit() => widget.onSubmit(points);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32),
        const Text(
          'PATTERN PASSWORD',
          style: AppTextStyles.headline,
        ),
        const MinSpacer(minHeight: 32),
        Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: PatternLock(
            selectedColor: AppColors.primary,
            initialPoints: points,
            dimension: 3,
            onInputComplete: (List<int> s) {
              setState(() => points = s);
            },
          ),
        ),
        SizedBox(height: 8),
        TextButton(
          onPressed: points.isNotEmpty ? reset : null,
          child: Text('RESET', style: TextStyle(fontWeight: FontWeight.w500, color: points.isNotEmpty ? AppColors.primary : AppColors.primaryDisabled)),
        ),
        const MinSpacer(minHeight: 32),
        SizedBox(
          width: 546,
          child: RegularButton(
            onTap: points.isNotEmpty ? submit : null,
            text: 'Next',
            color: points.isNotEmpty ? AppColors.primary : AppColors.primaryDisabled,
          ),
        ),
        SizedBox(height: 32),
      ],
    );
  }
}

class NumericForm extends ConsumerStatefulWidget {
  const NumericForm({required this.onSubmit, super.key});

  final Function(String password) onSubmit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NumericFormState();
}

class _NumericFormState extends ConsumerState<NumericForm> {
  String password = '';

  bool get ready => password.length >= 4 && password.length <= 8 && password.contains(RegExp(r'[0-9]'));

  onSubmit() => widget.onSubmit(password);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32),
        const Text(
          'NUMERIC PASSWORD',
          style: AppTextStyles.headline,
        ),
        const MinSpacer(minHeight: 32),
        SizedBox(width: 546, child: passwordField()),
        const MinSpacer(minHeight: 32),
        SizedBox(
          width: 546,
          child: RegularButton(
            onTap: ready ? onSubmit : null,
            text: 'Next',
            color: ready ? AppColors.primary : AppColors.primaryDisabled,
          ),
        ),
        SizedBox(height: 32),
      ],
    );
  }

  Widget passwordField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      maxLength: 8,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }

        return null;
      },
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
      decoration: InputDecoration(
        isDense: true,
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        labelText: 'Password',
        fillColor: Colors.white70,
      ),
    );
  }
}
