part of flipable_card_tab;

class _Slider extends StatelessWidget {
  const _Slider({
    required this.label,
    required this.value,
    this.onChanged,
    this.min = -360,
    this.max = 360,
  });

  final String label;
  final double value;
  final void Function(double)? onChanged;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("$label:"),
        Expanded(
          child: Slider.adaptive(
            label: label,
            min: min,
            max: max,
            onChanged: onChanged,
            value: value,
          ),
        ),
        SizedBox(
          width: 64,
          child: Text(value.toStringAsFixed(2)),
        ),
      ],
    );
  }
}
