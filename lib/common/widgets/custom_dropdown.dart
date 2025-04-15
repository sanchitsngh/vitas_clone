import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vitas_clone/core/constants/app_colors.dart';


class CustomDropdown extends ConsumerStatefulWidget {
  final List<String> options;
  final String label;
  final String? hintText;

  const CustomDropdown(
      {super.key,
      required this.options,
      required this.label,
      required this.hintText});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return CustomDropdownState();
  }
}

class CustomDropdownState extends ConsumerState<CustomDropdown> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 13,
            color: grayscale[600],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
                color: colorGrayscale[500]!,
                style: BorderStyle.solid,
                width: 0.5),
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            value: widget.options.contains(_value) ? _value : null,
            onChanged: (newValue) => setState(() => _value = newValue),
            items: widget.options.map<DropdownMenuItem<String>>((String itemValue) {
              return DropdownMenuItem<String>(
                value: itemValue,
                child: Text(
                  itemValue,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }).toList(),
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                (widget.hintText ?? ""),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: colorPurple),
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SvgPicture.asset('assets/icons/icon_dropdown.svg'),
            ),
            isExpanded: true,
          ),
        ),
      ]
    );
  }
}
