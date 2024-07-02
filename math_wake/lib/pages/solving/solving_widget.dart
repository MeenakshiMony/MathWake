import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'solving_model.dart';
export 'solving_model.dart';

class SolvingWidget extends StatefulWidget {
  const SolvingWidget({
    super.key,
    this.question,
  });

  final String? question;

  @override
  State<SolvingWidget> createState() => _SolvingWidgetState();
}

class _SolvingWidgetState extends State<SolvingWidget> {
  late SolvingModel _model;
  final SpeechToText _speech = SpeechToText();
  String _transcribedText = '';
  bool _isListening = false;
  double _soundLevel = 0.0;
  final player = AudioPlayer();
  bool _isPlaying = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SolvingModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _transcribeAudio() async {
    bool isConnected = await _isConnectedToInternet();
    if (!isConnected) {
      _showSnackbar('No internet connection. Please try again later.');
      return;
    }

    bool isInitialized = await _speech.initialize();
    if (isInitialized) {
      var systemLocale = await _speech.systemLocale();
      String _currentLocaleId = systemLocale?.localeId ?? '';

      _speech.listen(
        onResult: (result) async {
          setState(() {
            _transcribedText =
                _convertSpokenDigitsToNumbers(result.recognizedWords);
          });
          FFAppState().voiceanswer = result.recognizedWords;
        },
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 3),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: (level) {},
        cancelOnError: true,
        listenMode: ListenMode.confirmation,
        onDevice: false,
      );
      setState(() {
        _isListening = true;
      });
    } else {
      _showSnackbar('Failed to initialize speech recognition.');
    }
  }

  String _convertSpokenDigitsToNumbers(String input) {
    final Map<String, String> digitMap = {
      'zero': '0',
      'one': '1',
      'two': '2',
      'three': '3',
      'four': '4',
      'five': '5',
      'six': '6',
      'seven': '7',
      'eight': '8',
      'nine': '9',
      'ten': '10',
      'eleven': '11',
      'twelve': '12',
      'thirteen': '13',
      'fourteen': '14',
      'fifteen': '15',
      'sixteen': '16',
      'seventeen': '17',
      'eighteen': '18',
    };

    List<String> words = input.split(' ');
    List<String> convertedWords = words.map((word) {
      return digitMap[word.toLowerCase()] ?? word;
    }).toList();

    return convertedWords.join(' ');
  }

  Future<void> _checkAnswer() async {
    if (FFAppState().voiceanswer == FFAppState().sum) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Correct Answer! Alarm Stopped.')));
      context.pushNamed('speechrecognition');

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wrong Answer! Try Again.')));
      playSound();
    }
  }

  Future<bool> _isConnectedToInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
        ),
        duration: Duration(milliseconds: 4000),
        backgroundColor: FlutterFlowTheme.of(context).secondary,
      ),
    );
  }

  Future<void> playSound() async {
    String audioPath = "audios/walk_in_the_forest.mp3";
    await player.play(AssetSource(audioPath));
    setState(() {
      _isPlaying = true;
    });
  }

  Future<void> _stopAudio() async {
    await player.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondary,
            automaticallyImplyLeading: false,
            title: Text(
              'Speak Your Answer',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22.0,
                letterSpacing: 0.0,
              ),
            ),
            actions: const [],
            centerTitle: false,
            elevation: 2.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 391.0,
                  height: 703.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-0.06, -0.48),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 11.0,
                          child: Container(
                            width: 266.0,
                            height: 310.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 9.0,
                              ),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                FFAppState().question ?? '',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 23.0,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-0.07, 0.02),
                        child: FFButtonWidget(
                          onPressed: () async {
                            final List<String>? result =
                            functions.mathprobgen();
                            if (result != null && result.length >= 2) {
                              setState(() {
                                FFAppState().question = result[0];
                                FFAppState().sum = result[1];
                              });
                            }
                          },
                          text: 'Tap for question',
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                              letterSpacing: 0.0,
                            ),
                            elevation: 3.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0.04, -0.93),
                        child: GradientText(
                          'Solve the math problem',
                          style: FlutterFlowTheme.of(context).headlineSmall
                              .override(
                            fontFamily: 'Outfit',
                            color: const Color(0xFFF6FF10),
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                          ),
                          colors: const [
                            Color(0xFF89F5C3),
                            Color(0xFFF6FF10)
                          ],
                          gradientDirection: GradientDirection.ltr,
                          gradientType: GradientType.linear,
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0.01, -0.87),
                        child: GradientText(
                          'voice answering',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                            fontFamily: 'Outfit',
                            color: const Color(0xFFF6FF10),
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                          ),
                          colors: const [
                            Color(0xFF89F5C3),
                            Color(0xFFF6FF10)
                          ],
                          gradientDirection: GradientDirection.ltr,
                          gradientType: GradientType.linear,
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-0.20, 0.30),
                        child: Text(
                          'Transcribed Text:',
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.35, 0.30),
                        child: Text(
                          FFAppState().voiceanswer,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.09, 0.57),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await flutterLocalNotificationsPlugin.cancelAll();
                            await _stopAudio();
                            await _transcribeAudio();
                          },
                          text: 'Transcribe audio',
                          options: FFButtonOptions(
                            height: 40,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                              letterSpacing: 0,
                            ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.09, 0.78),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await _checkAnswer();
                          },
                          text: 'Check Answer',
                          options: FFButtonOptions(
                            width: 185,
                            height: 40,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24, 0, 24, 0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                              letterSpacing: 0,
                            ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}