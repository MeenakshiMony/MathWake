import '/flutter_flow/flutter_flow_util.dart';
import 'speechrecognition_widget.dart' show SpeechrecognitionWidget;
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class SpeechrecognitionModel extends FlutterFlowModel<SpeechrecognitionWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  AudioRecorder? audioRecorder;
  String? recording;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
