import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../presentation/component/custom_text_field.dart';

class DropDownField extends StatelessWidget {
  final List<DropDownItem> items;
  final String? title;
  final String? hint;
  final double? radius;
  final double? height;
  final Color? fillColor;
  final Color? prefixIconColor;
  final Color? hintColor;
  final Color? dropDownIconColor;
  final dynamic valueId;
  final TextStyle? texStyle;
  final IconData? prefixIcon;
  final Widget? iconWidget;
  final void Function(DropDownItem?)? onChanged;
  final bool isValidator;
  final String? Function(dynamic)? validator;
  final TextStyle? style;
  final TextStyle? titleStyle;
  final double? hintFontSize;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? marginDropDown;
  final bool isDecoration;
  final InputDecoration? inputDecoration;
  final bool isLoading;
  final bool disabled;
  final Color? backgroundColor;
  final DropDownItem? value;

  const DropDownField(
      {Key? key,
        required this.items,
        this.title,
        this.hint,
        this.onChanged,
        this.prefixIcon,
        this.texStyle,
        this.valueId,
        this.iconWidget,
        this.isValidator = true,
        this.validator,
        this.style,
        this.margin,
        this.marginDropDown,
        this.height,
        this.fillColor,
        this.hintColor,
        this.dropDownIconColor,
        this.hintFontSize, this.radius, this.titleStyle,
        this.isDecoration = false,
        this.inputDecoration,
        this.isLoading = false,
        this.disabled = false,
        this.backgroundColor, this.prefixIconColor, this.value,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? colorBorderSide = isDecoration ? Colors.grey.shade200 : Colors.grey;
    Color? fillColor = Colors.white;
    TextEditingController controller = TextEditingController();
    DropDownItem? defaultValue = value ?? (items.isNotEmpty ? items[0] : null);

    return Container(
      decoration: BoxDecoration(
          color: backgroundColor ?? fillColor,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title ?? '',
              style: titleStyle,
            ),
            const SizedBox(height: 5,)
          ],
          Padding(
            padding: marginDropDown ?? EdgeInsets.zero,
            child: DropdownButtonFormField2<DropDownItem>(
              isExpanded: true,
              value: defaultValue,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: inputDecoration ?? InputDecoration(
                filled: true,
                fillColor: backgroundColor ?? fillColor,
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(radius ?? 12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorBorderSide,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(radius ?? 12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(radius ?? 12),
                ),
                prefixIcon: iconWidget ??
                    (prefixIcon != null
                        ? Icon(prefixIcon, color: prefixIconColor ?? Colors.grey.shade800)
                        : null),
              ),
              hint: Text(
                hint ?? '',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              items: items
                  .map((item) => DropdownMenuItem<DropDownItem>(
                value: item,
                child: Text(
                  item.title ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ))
                  .toList(),
              onChanged: onChanged,
              onSaved: (value) {
                //  selectedValue = value.toString();
              },
              buttonStyleData: ButtonStyleData(
                height: height,
              ),
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: dropDownIconColor,
                    size: 20,
                  ),
                ),
                iconSize: 20,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 250,
                openInterval: const Interval(0.25, 0.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius ?? 8),
                  border: Border.all(color: Colors.grey.shade100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.15),
                      offset: const Offset(0, 0),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              dropdownSearchData: items.length < 10
                  ? null
                  : DropdownSearchData(
                searchInnerWidgetHeight: 50,
                searchController: controller,
                searchInnerWidget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    borderColor: Colors.grey.shade200,
                    hintText: 'search',
                    controller: controller,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.blue.withOpacity(0.5),
                    ),
                    isValidator: false,
                  ),
                ),
                searchMatchFn: (DropdownMenuItem<DropDownItem> item, String text) {
                  return item.value?.title
                      ?.toLowerCase()
                      .contains(text.toLowerCase()) ??
                      false;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropDownItem? getDropDownItemById(String id) {
    if (id.isEmpty) return null;
    // return items.firstWhere((element) => element.id == id);
  }
}

class DropDownItem {
  final String? id;
  final String? title;
  final String? value;
  final IconData? icon;
  final Widget? child;

  const DropDownItem({this.id, this.title, this.value, this.icon, this.child});
}
