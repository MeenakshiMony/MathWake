import '/flutter_flow/flutter_flow_util.dart';
import 'landing_widget.dart' show LandingWidget;
import 'package:flutter/material.dart';

class LandingModel extends FlutterFlowModel<LandingWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
