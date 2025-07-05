import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gutenberg/common/helper/common_helper.dart';

class BookSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback? onClear;
  final ValueChanged<String>? onChanged;

  const BookSearchBar({super.key, required this.controller, required this.focusNode, this.onClear, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final commonHelper = CommonHelper();
    final hasText = controller.text.isNotEmpty;
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHigh, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.titleMedium,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: SvgPicture.asset(
              commonHelper.getIconPath("ic_search.svg"),
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(Colors.grey.shade500, BlendMode.srcIn),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          suffixIcon: hasText
              ? IconButton(
                  padding: const EdgeInsets.all(10),
                  icon: SvgPicture.asset(
                    commonHelper.getIconPath("ic_cancel.svg"),
                    width: 18,
                    height: 18,
                    colorFilter: ColorFilter.mode(Colors.grey.shade500, BlendMode.srcIn),
                  ),
                  onPressed: onClear,
                )
              : null,
          hintText: 'Search',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
