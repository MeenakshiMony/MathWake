import '/flutter_flow/flutter_flow_util.dart';
import 'about_phone_widget.dart' show AboutPhoneWidget;
import 'package:flutter/material.dart';

class AboutPhoneModel extends FlutterFlowModel<AboutPhoneWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
