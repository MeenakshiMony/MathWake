import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:glassmorphism/glassmorphism.dart';

import 'alarms_list_model.dart';
export 'alarms_list_model.dart';

class AlarmsListWidget extends StatefulWidget {
  const AlarmsListWidget({super.key});

  @override
  State<AlarmsListWidget> createState() => _AlarmsListWidgetState();
}

class _AlarmsListWidgetState extends State<AlarmsListWidget> {
  late AlarmsListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AlarmsListModel());
    _model.switchValue = true;
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
        backgroundColor:  FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child:
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      'Your Alarms',
                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        letterSpacing: 0.0,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        context.pushNamed('Settings');
                      },
                      child: Icon(
                        Icons.settings_outlined,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Below are the list of alarms',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Outfit',
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                          tabletLandscape: false,
                        ))
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Status',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    gradient: RadialGradient(
                      colors: [Colors.white, Colors.grey.shade200],
                      center: const Alignment(0.0, 0.0),
                      radius: 0.8,
                    ),
                  ),
                  child: AnalogClock(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: FlutterFlowTheme.of(context).primary,),
                        color: Colors.transparent,
                        shape: BoxShape.circle),
                    width: 150.0,
                    isLive: true,
                    hourHandColor: Color(0xFF131313),
                    minuteHandColor: Color(0xFF131313),
                    secondHandColor: Colors.red,
                    showSecondHand: true,
                    numberColor: Colors.black87,
                    showNumbers: true,
                    showAllNumbers: true,
                    textScaleFactor: 1.4,
                    showTicks: true,
                    showDigitalClock: false,
                    datetime: DateTime.now(),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: InkWell(
                        onTap: () async {
                          context.pushNamed('Set_Alarm');
                        },
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(
                            maxWidth: 570.0,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Date: ',
                                                style: TextStyle(),
                                              ),
                                              TextSpan(
                                                text: dateTimeFormat('yMMMd', FFAppState().date),
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(context).primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0.0,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            dateTimeFormat('jm', FFAppState().time),
                                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Alarm 1',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                                          fontFamily: 'Outfit',
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                      Switch.adaptive(
                                        value: _model.switchValue!,
                                        onChanged: (newValue) async {
                                          setState(() => _model.switchValue = newValue);
                                          if (newValue) {
                                            FFAppState().date = FFAppState().date;
                                            FFAppState().time = FFAppState().time;
                                            setState(() {});
                                          } else {
                                            FFAppState().deleteDate();
                                            FFAppState().date = null;
                                            FFAppState().deleteTime();
                                            FFAppState().time = null;
                                            setState(() {});
                                          }
                                        },
                                        activeColor: FlutterFlowTheme.of(context).primary,
                                        activeTrackColor: FlutterFlowTheme.of(context).accent1,
                                        inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                                        inactiveThumbColor: FlutterFlowTheme.of(context).secondaryText,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed('landing');
                      },
                      text: 'Go to Math Solving Page',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}