part of flipable_card_tab;

class _Slider extends StatefulWidget {
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
  State<_Slider> createState() => _SliderState();
}

class _SliderState extends State<_Slider> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.value.toString());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller.text = widget.value.toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("${widget.label}:"),
        Expanded(
          child: Slider.adaptive(
            label: widget.label,
            min: widget.min,
            max: widget.max,
            value: widget.value,
            onChanged: (value) {
              widget.onChanged?.call(value);
              controller.text = value.toString();
            },
          ),
        ),
        SizedBox(
          width: 64,
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 12.0),
            maxLines: 1,
            decoration: const InputDecoration(border: InputBorder.none),
            onSubmitted: (result) {
              double? value = double.tryParse(result);

              if (value != null && value >= widget.min && value <= widget.max) {
                widget.onChanged?.call(value);
              } else {
                controller.text = widget.value.toString();
              }
            },
          ),
        ),
      ],
    );
  }
}
