import 'package:flutter/material.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new ConstrainedBox(
          constraints: widget.isExpanded
              ? new BoxConstraints()
              : new BoxConstraints(maxHeight: 40.0),
          child: new Text(
            widget.text,
            softWrap: true,
            overflow: TextOverflow.fade,
          )),
      widget.isExpanded
          ? InkWell(
              child: const Text(
                'See  less...',
                style: AppFont.primarySecond,
              ),
              onTap: () => setState(() => widget.isExpanded = false))
          : InkWell(
              child: const Text(
                'See  More...',
                style: AppFont.primarySecond,
              ),
              onTap: () => setState(() => widget.isExpanded = true))
    ]);
  }
}
