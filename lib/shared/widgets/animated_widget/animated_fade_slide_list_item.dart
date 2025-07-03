import 'package:flutter/material.dart';

class AnimatedFadeSlideListItem extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final VoidCallback onRemove;
  final Duration duration;

  const AnimatedFadeSlideListItem({
    super.key,
    required this.child,
    required this.isVisible,
    required this.onRemove,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<AnimatedFadeSlideListItem> createState() =>
      _AnimatedFadeSlideListItemState();
}

class _AnimatedFadeSlideListItemState extends State<AnimatedFadeSlideListItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);
    _offset = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(_controller);

    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedFadeSlideListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible) {
      _controller.forward();
    } else {
      _controller.reverse().then((_) => widget.onRemove());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}
