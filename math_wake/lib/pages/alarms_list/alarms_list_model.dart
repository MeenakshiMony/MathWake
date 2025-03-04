import '/flutter_flow/flutter_flow_util.dart';
import 'alarms_list_widget.dart' show AlarmsListWidget;
import 'package:flutter/material.dart';

class AlarmsListModel extends FlutterFlowModel<AlarmsListWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
