import 'package:flutter/material.dart';
import 'package:sbit_mobile/Helper/AppTheme/appColors.dart';
import 'package:sbit_mobile/Helper/Component/input.dart';

class InputDialog extends StatelessWidget {
  final String? titleMsg;
  final String? contentMsg;
  final Function? onRetryPressed1;
  final Function? onRetryPressed;
  final Input? textField;

  const InputDialog({Key? key, this.titleMsg, this.contentMsg, this.onRetryPressed, this.onRetryPressed1, this.textField}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: buildChild(context),
    );
  }
  
  buildChild(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return buildLandscapeLayout(context);
      }else {
        return buildPortraitLayout();
      }
    }
  );

  Widget buildPortraitLayout() {
      return Container(
        height: 240,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              child: Text(
                titleMsg!, 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  contentMsg!, 
                  style: TextStyle(
                    fontWeight: FontWeight.normal, 
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: textField
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    child: FlatButton(
                      child: const Text('Cancel', style: TextStyle(fontSize: 17.0, color: Colors.pink,)),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(6.0),
                        side: BorderSide(
                            color: Colors.pink,
                          ),
                        ),
                      onPressed: onRetryPressed1 as void Function()?,
                    ),
                  ),
                  SizedBox(width: 8,),
                  Container(
                    width: 100,
                    height: 50,
                    child: RaisedButton(
                      child: const Text('Start', style: TextStyle(fontSize: 17.0)),
                      color: AppColors.label,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(6.0)),
                      onPressed: onRetryPressed as void Function()?,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLandscapeLayout(BuildContext context) {
      return Container(
        height: 200,
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0), 
                child: Text(titleMsg!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0), 
                child: Text(contentMsg!, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19.0),),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    child: FlatButton(
                      child: const Text('NO', style: TextStyle(fontSize: 17.0, color: Color(0xff44D62C),)),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(3.0),
                        side: BorderSide(
                            color: Color(0xff44D62C),
                          ),
                        ),
                      onPressed: onRetryPressed1 as void Function()?,
                    ),
                  ),
                  SizedBox(width: 8,),
                  Container(
                    width: 100,
                    height: 50,
                    child: RaisedButton(
                      child: const Text('YES', style: TextStyle(fontSize: 17.0)),
                      color: Color(0xff44D62C),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(3.0)),
                      onPressed: onRetryPressed as void Function()?,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}