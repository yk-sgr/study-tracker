import '../add_goal_topic/add_goal_topic_widget.dart';
import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddGoalTopicWidget(
                goal: widget.goal,
              ),
            ),
          );
        },
        backgroundColor: FlutterFlowTheme.primaryColor,
        elevation: 8,
        label: Text(
          'Add Topic',
          style: FlutterFlowTheme.bodyText1,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: StreamBuilder<List<TopicsRecord>>(
                      stream: queryTopicsRecord(
                        queryBuilder: (topicsRecord) => topicsRecord
                            .where('goal_id',
                                isEqualTo: functions.idFromGoal(widget.goal))
                            .where('user_id', isEqualTo: currentUserUid),
                      ),
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
                        List<TopicsRecord> listViewTopicsRecordList =
                            snapshot.data;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewTopicsRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewTopicsRecord =
                                listViewTopicsRecordList[listViewIndex];
                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                              child: Container(
                                width: 100,
                                constraints: BoxConstraints(
                                  maxHeight: double.infinity,
                                ),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.secondaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 5, 0),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 35,
                                              icon: FaIcon(
                                                FontAwesomeIcons.trash,
                                                color: Color(0xFFB3B2B2),
                                                size: 17,
                                              ),
                                              onPressed: () async {
                                                await listViewTopicsRecord
                                                    .reference
                                                    .delete();
                                              },
                                            ),
                                          ),
                                          Text(
                                            listViewTopicsRecord.name,
                                            style: FlutterFlowTheme.bodyText1
                                                .override(
                                              fontFamily: 'Open Sans',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (!(listViewTopicsRecord.done) ?? true)
                                        FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 30,
                                          borderWidth: 1,
                                          buttonSize: 60,
                                          icon: Icon(
                                            Icons
                                                .check_box_outline_blank_outlined,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          onPressed: () async {
                                            final topicsUpdateData =
                                                createTopicsRecordData(
                                              done: true,
                                            );
                                            await listViewTopicsRecord.reference
                                                .update(topicsUpdateData);
                                          },
                                        ),
                                      if (listViewTopicsRecord.done ?? true)
                                        FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 30,
                                          borderWidth: 1,
                                          buttonSize: 60,
                                          icon: Icon(
                                            Icons.check_box,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          onPressed: () async {
                                            final topicsUpdateData =
                                                createTopicsRecordData(
                                              done: false,
                                            );
                                            await listViewTopicsRecord.reference
                                                .update(topicsUpdateData);
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
