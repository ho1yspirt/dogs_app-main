import 'package:flutter/material.dart';

class CustomSlidingToggle extends StatefulWidget {
  const CustomSlidingToggle({
    Key? key,
    required this.leftLabel,
    required this.rightLabel,
    required this.onChange,
  }) : super(key: key);

  final String leftLabel;
  final String rightLabel;
  final ValueSetter<int> onChange;

  @override
  State<CustomSlidingToggle> createState() => _CustomSlidingToggleState();
}

class _CustomSlidingToggleState extends State<CustomSlidingToggle> {
  final Duration _fadeAnimDuration = const Duration(milliseconds: 250);
  final Duration _slideAnimDuration = const Duration(milliseconds: 300);
  final Duration _textAnimDuration = const Duration(milliseconds: 300);
  int _position = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: GestureDetector(
        onTap: () {
          _position++;
          if (_position > 1) {
            _position = 0;
          }
          setState(() {});

          widget.onChange(_position);
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            Positioned.fill(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: AnimatedOpacity(
                          duration: _fadeAnimDuration,
                          opacity: _position == 0 ? 0 : 1,
                          curve: Curves.easeOutQuad,
                          child: Text(
                            widget.leftLabel,
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: AnimatedOpacity(
                        duration: _fadeAnimDuration,
                        opacity: _position == 0 ? 1 : 0,
                        curve: Curves.easeOutQuad,
                        child: Text(
                          widget.rightLabel,
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            AnimatedAlign(
              alignment:
                  _position == 0 ? Alignment.centerLeft : Alignment.centerRight,
              duration: _slideAnimDuration,
              child: LayoutBuilder(
                builder: (_, constraints) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: constraints.maxWidth / 2,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: _textAnimDuration,
                          child: _position == 0
                              ? Text(
                                  widget.leftLabel,
                                  key: ValueKey(widget.leftLabel),
                                  style: const TextStyle(),
                                )
                              : Text(
                                  widget.rightLabel,
                                  key: ValueKey(widget.rightLabel),
                                  style: const TextStyle(),
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
