import 'package:flutter/material.dart';
import 'package:jnote/src/utils/constants/colors.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    required this.tabViews,
    required this.items,
    this.selectedIndex = 0,
    this.onChanged,
  }) : assert(selectedIndex <= items.length && tabViews.length == items.length);
  final List<CustomTabItem> items;
  final List<Widget> tabViews;
  final int selectedIndex;
  final void Function(int index)? onChanged;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.lightGray.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.items
                  .asMap()
                  .entries
                  .map(
                    (entry) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = entry.key;
                        });
                        widget.onChanged?.call(selectedIndex);
                      },
                      child: AnimatedContainer(
                          width:
                              (MediaQuery.of(context).size.width * 0.5) - 16.0,
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: entry.key == selectedIndex
                                ? Theme.of(context).primaryColorDark
                                : null,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: entry.value),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        Expanded(
          child: IndexedStack(
            index: selectedIndex,
            children: widget.tabViews,
          ),
        ),
      ],
    );
  }
}

class CustomTabItem extends StatelessWidget {
  const CustomTabItem({
    Key? key,
    required this.iconData,
    required this.text,
  }) : super(key: key);

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: Colors.white,
        ),
        const SizedBox(width: 8.0),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
