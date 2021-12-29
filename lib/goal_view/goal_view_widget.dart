import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoalViewWidget extends StatefulWidget {
  const GoalViewWidget({
    Key key,
    this.goal,
  }) : super(key: key);

  final DocumentReference goal;

  @override
  _GoalViewWidgetState createState() => _GoalViewWidgetState();
}

class _GoalViewWidgetState extends State<GoalViewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: Color(0xFF303030)),
        automaticallyImplyLeading: true,
        title: StreamBuilder<GoalsRecord>(
          stream: GoalsRecord.getDocument(widget.goal),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: Color(0xFF93C3C0),
                  ),
                ),
              );
            }
            final textGoalsRecord = snapshot.data;
            return Text(
              textGoalsRecord.name,
              style: FlutterFlowTheme.title1,
            );
          },
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
