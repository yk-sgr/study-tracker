import 'package:flutter/material.dart';
import 'package:study_tracker/theme/app_theme.dart';

class LoadingButton extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final Color background;
  final Function() onPressed;

  const LoadingButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.child,
      required this.background,
      required this.onPressed})
      : super(key: key);

  @override
  State createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: widget.background,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )
            ),
            onPressed: () async {
              setState(() {
                _loading = true;
              });
              await widget.onPressed();
              setState(() {
                _loading = false;
              });
            },
            child: _loading ? _progressIndicator() : widget.child));
  }

  Widget _progressIndicator() {
    return CircularProgressIndicator(
      color: AppTheme.secondaryColor,
    );
  }
}
