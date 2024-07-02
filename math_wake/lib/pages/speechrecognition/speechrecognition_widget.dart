
import '/flutter_flow/flutter_flow_util.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'speechrecognition_model.dart';
export 'speechrecognition_model.dart';

class SpeechrecognitionWidget extends StatefulWidget {
  const SpeechrecognitionWidget({super.key});

  @override
  State<SpeechrecognitionWidget> createState() =>
      _SpeechrecognitionWidgetState();
}

class _SpeechrecognitionWidgetState extends State<SpeechrecognitionWidget> {
  late SpeechrecognitionModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SpeechrecognitionModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.amber,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.amber),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Good Morning,',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 36,
                  color: Colors.purple,
                  letterSpacing: 0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Have a Wonderful Day :)',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 24,
                  color: Colors.purple,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
