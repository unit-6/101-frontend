import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String titleMsg;
  final String contentMsg;
  final Function onRetryPressed;

  const CustomDialog({Key key, this.titleMsg, this.contentMsg, this.onRetryPressed}) : super(key: key);
  
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
      height: 230,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              child: Text(
                titleMsg, 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.topLeft,
              width: double.infinity,
              child: Text(
                contentMsg, 
                style: TextStyle(
                  fontWeight: FontWeight.normal, 
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
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
                    child: RaisedButton(
                      child: const Text('OK', style: TextStyle(fontSize: 17.0)),
                      color: Colors.pink,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(6.0)),
                      onPressed: onRetryPressed,
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
        borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              child: Text(
                titleMsg, 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.topLeft,
              width: double.infinity,
              child: Text(
                contentMsg, 
                style: TextStyle(
                  fontWeight: FontWeight.normal, 
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
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
                    child: RaisedButton(
                      child: const Text('OK', style: TextStyle(fontSize: 17.0)),
                      color: Color(0xff44D62C),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(3.0)),
                      onPressed: onRetryPressed,
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