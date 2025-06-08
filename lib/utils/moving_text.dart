import 'package:flutter/material.dart';

class MovingText extends StatefulWidget{
  final String text;
  final TextStyle style;
  MovingText({required this.text, required this.style});

  @override
  State<MovingText> createState() => _MovingTextState();
}

class _MovingTextState extends State<MovingText> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
        duration:  const Duration(seconds: 5),
        vsync: this
    )..repeat();

    _animation = Tween<double>(begin: 1.0 ,end: -1.0).animate(_controller);
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedBuilder(
                animation: _animation,
                builder: (context, child){
                  final offset = _animation.value * constraints.maxWidth;
                  return Transform.translate(
                    offset: Offset(offset, 0),
                    child: SizedBox(
                      width: constraints.maxWidth*2,
                      child: Text(widget.text,
                      style: widget.style),
                    ),
                  );

            });
          }
      ),
    );
  }
}