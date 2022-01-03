/*
 * Study Progress Tracker
 * Copyright (C) 2022 Yannick Seeger
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

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
                borderRadius: BorderRadius.circular(20),
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
