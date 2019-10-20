import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  GlobalKey _containerKey = GlobalKey();

  Size _containerSize = Size(0, 0);
  Offset _containerPosition = Offset(0, 0);

  _getContainerSize() {
    final RenderBox containerRenderBox =
        _containerKey.currentContext.findRenderObject();
    final containerSize = containerRenderBox.size;
    setState(() {
      _containerSize = containerSize;
    });
  }

  _getContainerPosition() {
    final RenderBox containerRenderBox =
        _containerKey.currentContext.findRenderObject();
    final containerPosition = containerRenderBox.localToGlobal(Offset.zero);

    setState(() {
      _containerPosition = containerPosition;
    });
  }

  @override
  void initState() {
    super.initState();

    //initState() method called before buid() method so these two methods call before build() method
    //and _containerKey..currentContext becomes null and we get exception
    /*_getContainerPosition();
    _getContainerSize();
    */

    WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted);
  }

  _onBuildCompleted(_) {
    _getContainerPosition();
    _getContainerSize();
  }

  @override
  Widget build(BuildContext context) {
    var dv = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        key: _containerKey,
        title: Text('Widget SizePosition'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              //skey: _containerKey,
              margin: EdgeInsets.all(10.0),
              width: 200.0,
              height: 300.0,
              color: Colors.blue,
            ),
            Text(
                "height: ${_containerSize.height}, width: ${_containerSize.width}"),
            Text(
                "position: x - ${_containerPosition.dx}, y - ${_containerPosition.dy}"),
            Text("device width: ${dv.width} and heighht: ${dv.height}")
          ],
        ),
      ),
    );
  }
}
