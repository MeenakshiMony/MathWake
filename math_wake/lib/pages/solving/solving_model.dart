import '/flutter_flow/flutter_flow_util.dart';
import 'solving_widget.dart' show SolvingWidget;
import 'package:flutter/material.dart';

class SolvingModel extends FlutterFlowModel<SolvingWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
