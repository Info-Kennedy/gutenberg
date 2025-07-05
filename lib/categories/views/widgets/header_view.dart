import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gutenberg/common/common.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    final commonHelper = CommonHelper();
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              commonHelper.getIconPath('ic_pattern.svg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary.withValues(alpha: 0.2), BlendMode.srcIn),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveBreakpoints.of(context).isDesktop ? MediaQuery.of(context).size.width * 0.15 : 20.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.0,
              children: [
                SizedBox(height: 20.0),
                Text(
                  commonHelper.getStringLabel("gutenberg_project"),
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                ),
                Text(
                  commonHelper.getStringLabel("gutenberg_project_description"),
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
