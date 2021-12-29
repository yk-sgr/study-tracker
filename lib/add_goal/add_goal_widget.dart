import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../home_page/home_page_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class AddGoalWidget extends StatefulWidget {
  const AddGoalWidget({Key key}) : super(key: key);

  @override
  _AddGoalWidgetState createState() => _AddGoalWidgetState();
}

class _AddGoalWidgetState extends State<AddGoalWidget> {
  DateTime datePicked;
  TextEditingController textController1;
  TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: Color(0xFF303030)),
        automaticallyImplyLeading: true,
        title: Text(
          'Add Goal',
          style: FlutterFlowTheme.title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: TextFormField(
                      controller: textController1,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Open Sans',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF303030),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF303030),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Open Sans',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: TextFormField(
                      controller: textController2,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Open Sans',
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF303030),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF303030),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Open Sans',
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              await DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                onConfirm: (date) {
                                  setState(() => datePicked = date);
                                },
                                currentTime: getCurrentTimestamp,
                                minTime: getCurrentTimestamp,
                              );
                            },
                            child: Text(
                              'Select Due',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: Text(
                            dateTimeFormat('d/M/y', datePicked),
                            style: FlutterFlowTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      final goalsCreateData = createGoalsRecordData(
                        name: textController1.text,
                        description: textController2.text,
                        due: datePicked,
                        userId: currentUserUid,
                      );
                      await GoalsRecord.collection.doc().set(goalsCreateData);
                      await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePageWidget(),
                        ),
                        (r) => false,
                      );
                    },
                    text: 'Add Goal',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50,
                      color: Color(0xFF303030),
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Open Sans',
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: 20,
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
