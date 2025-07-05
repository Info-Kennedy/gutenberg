import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gutenberg/common/common.dart';

class CategoryItem extends StatelessWidget {
  final Map<String, dynamic> category;
  final Function(Map<String, dynamic>) onTap;
  const CategoryItem({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final commonHelper = CommonHelper();
    return InkWell(
      onTap: () => onTap(category),
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1), blurRadius: 5.0, offset: Offset(0, 5.0))],
        ),
        child: Row(
          spacing: 10.0,
          children: [
            SvgPicture.asset(commonHelper.getIconPath(category['image']), fit: BoxFit.cover, width: 24.0, height: 24.0),
            Text(
              category['name'].toString().toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            SvgPicture.asset(commonHelper.getIconPath('ic_next.svg'), fit: BoxFit.cover, width: 20.0, height: 20.0),
          ],
        ),
      ),
    );
  }
}
