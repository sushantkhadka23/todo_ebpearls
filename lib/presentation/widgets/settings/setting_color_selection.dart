import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_ebpearls/domain/entity/app_color.dart';

class SettingColorSelection extends StatelessWidget {
  final Color currentSeedColor;
  final Function(Color) onColorSelected;

  SettingColorSelection({super.key, required this.currentSeedColor, required this.onColorSelected});

  final List<AppColor> _appColors = [
    AppColor('Blue', Colors.blue, Colors.blue),
    AppColor('Purple', Colors.purple, Colors.purple),
    AppColor('Green', Colors.green, Colors.green),
    AppColor('Orange', Colors.orange, Colors.orange),
    AppColor('Red', Colors.red, Colors.red),
    AppColor('Teal', Colors.teal, Colors.teal),
    AppColor('Indigo', Colors.indigo, Colors.indigo),
    AppColor('Pink', Colors.pink, Colors.pink),
    AppColor('Cyan', Colors.cyan, Colors.cyan),
    AppColor('Amber', Colors.amber, Colors.amber),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.palette, size: 18, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            Text('App Color', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            Text(
              'Choose your preferred color theme for the app interface',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: _appColors.length,
              itemBuilder: (context, index) {
                final appColor = _appColors[index];
                final isSelected = appColor.lightColor.value == currentSeedColor.value;

                return GestureDetector(
                  onTap: () => onColorSelected(appColor.lightColor),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: appColor.lightColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isSelected ? appColor.darkColor : Colors.transparent, width: 3),
                      boxShadow: isSelected
                          ? [BoxShadow(color: appColor.lightColor.withOpacity(0.4), blurRadius: 8, spreadRadius: 2)]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isSelected)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4)],
                            ),
                            child: FaIcon(FontAwesomeIcons.check, color: appColor.darkColor, size: 12),
                          )
                        else
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(color: appColor.darkColor, shape: BoxShape.circle),
                          ),
                        const SizedBox(height: 4),
                        Text(
                          appColor.name,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
