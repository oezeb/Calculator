import 'package:calculator/home_page_view_model.dart';
import 'package:calculator/widgets/textfield_tween_animation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageViewModel _homePageVM;
  late ScrollController _controller;
  late List<Widget> _widgetList;
  int _count = 0;

  _regButton(String text) {
    return ElevatedButton(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 35,
            color: Colors.grey,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      onPressed: () {
        _homePageVM.memOp(text);
        updateFontSize();
        setState(() {});
      },
    );
  }

  _operandButton(String text) {
    return ElevatedButton(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 35,
            color: Colors.indigo,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      onPressed: () {
        _homePageVM.append(text);
        updateFontSize();
        setState(() {});
      },
    );
  }

  _digitButton(String text) {
    return ElevatedButton(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 35,
            color: Colors.black,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      onPressed: () {
        _homePageVM.append(text);
        updateFontSize();
        setState(() {});
      },
    );
  }

  double? _screenWidth;
  late Param _param;

  updateFontSize() {
    if (_screenWidth != null) {
      if (_homePageVM.opCtrl.text.length * _param.fontSize! >
          1.4 * _screenWidth!) {
        if (_param.fontSize! > 40) _param.fontSize = _param.fontSize! - 20;
      } else if (_homePageVM.opCtrl.text.length * _param.fontSize! <
          _screenWidth!) {
        if (_param.fontSize! < 60) _param.fontSize = _param.fontSize! + 20;
      }
    }
    setState(() {
      _widgetList[(_count + 0) % _widgetList.length] = TextFieldTweenAnimation(
        param: _param,
      );
    });
  }

  void _scroll() {
    _controller.animateTo(_controller.position.pixels + 85,
        duration: TextFieldTweenAnimation.duration,
        curve: Curves.fastOutSlowIn);

    _widgetList[(_count + 1) % _widgetList.length] = TextFieldTweenAnimation(
      param: Param.op(
        controller: _homePageVM.ansCtrl.text == ''
            ? _homePageVM.opCtrl
            : _homePageVM.ansCtrl,
      ),
    );

    setState(() {});

    Future.delayed(
        TextFieldTweenAnimation.duration + Duration(milliseconds: 10), () {
      _controller.jumpTo(_controller.position.minScrollExtent);

      _homePageVM.showResult();

      setState(() {
        _count = (_count + 1) % _widgetList.length;
        _widgetList[(_count + 0) % _widgetList.length] =
            TextFieldTweenAnimation(
          param: _param,
        );
        _widgetList[(_count + 1) % _widgetList.length] =
            TextFieldTweenAnimation(
          param: Param.ans(
            controller: _homePageVM.ansCtrl,
          ),
        );
        _widgetList[(_count + 2) % _widgetList.length] =
            TextFieldTweenAnimation(
          param: Param.ans(),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();

    _homePageVM = HomePageViewModel();

    _param = Param.op(controller: _homePageVM.opCtrl);

    _widgetList = [
      TextFieldTweenAnimation(param: _param),
      TextFieldTweenAnimation(
        param: Param.ans(
          controller: _homePageVM.ansCtrl,
        ),
      ),
      TextFieldTweenAnimation(
        param: Param.ans(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_screenWidth == null) _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: _screenWidth,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                height: 200,
                child: Column(
                  children: [
                    Container(
                      height: 25,
                      alignment: Alignment.centerRight,
                      child: Text(
                        _homePageVM.mem,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        controller: _controller,
                        itemBuilder: (context, index) {
                          if (index < _widgetList.length)
                            return _widgetList[
                                (index + _count) % _widgetList.length];
                          else
                            return Container(height: 1000);
                        },
                        itemCount: _widgetList.length + 1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(child: _regButton('mc')),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _homePageVM.clear();
                                      setState(() {});
                                    },
                                    child: Center(
                                      child: Text(
                                        'C',
                                        style: TextStyle(
                                          fontSize: 35,
                                          color: Colors.indigo,
                                        ),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                        side: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(child: _regButton('m+')),
                                Expanded(child: _operandButton('÷')),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(child: _regButton('m−')),
                                Expanded(child: _operandButton('×')),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(child: _regButton('mr')),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _homePageVM.backspace();
                                      updateFontSize();
                                      setState(() {});
                                    },
                                    child: Center(
                                      child: Icon(
                                        Icons.backspace_outlined,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[300],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                        side: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(child: _digitButton('7')),
                                Expanded(child: _digitButton('4')),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(child: _digitButton('8')),
                                Expanded(child: _digitButton('5')),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(child: _digitButton('9')),
                                Expanded(child: _digitButton('6')),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(child: _operandButton('−')),
                                Expanded(child: _operandButton('+')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(child: _digitButton('1')),
                                Expanded(child: _digitButton('%')),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(child: _digitButton('2')),
                                Expanded(child: _digitButton('0')),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(child: _digitButton('3')),
                                Expanded(child: _digitButton('.')),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _scroll();
                              },
                              child: Center(
                                child: Text(
                                  '=',
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.indigo,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(
                                      color: Colors.grey, width: 0.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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



  // _opListView() {
  //   if (_ansCount > 1) {
  //     Future.delayed(Duration(milliseconds: 510), () {
  //       _opCount--;
  //       prevOp = _homePageVM.textEditingController.text;
  //       setState(() {});
  //     });
  //   }
  //   return ListView.builder(
  //     physics: NeverScrollableScrollPhysics(),
  //     controller: _opController,
  //     padding: EdgeInsets.zero,
  //     itemBuilder: (context, index) {
  //       return ListView(
  //         reverse: true,
  //         scrollDirection: Axis.horizontal,
  //         children: [
  //           Container(
  //             width: 1000,
  //             child: TextField(
  //               onChanged: (text) {
  //                 setState(() {});
  //               },
  //               autofocus: true,
  //               readOnly: true,
  //               showCursor: true,
  //               textAlign: TextAlign.right,
  //               controller: _homePageVM.textEditingController,
  //               style: TextStyle(
  //                 fontSize: _fontSize(MediaQuery.of(context).size.width),
  //                 letterSpacing: 5,
  //               ),
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //     itemCount: _opCount,
  //   );
  // }

  // _ansListView() {
  //   if (_ansCount > 1) {
  //     Future.delayed(Duration(milliseconds: 510), () {
  //       _ansCount--;
  //       setState(() {});
  //     });
  //   }
  //   return ListView.builder(
  //     physics: NeverScrollableScrollPhysics(),
  //     controller: _ansController,
  //     padding: EdgeInsets.zero,
  //     itemBuilder: (context, index) {
  //       return Text(
  //         index == 0
  //             ? _homePageVM.textEditingController.text
  //             : _homePageVM.answer,
  //         textAlign: TextAlign.right,
  //         style: TextStyle(
  //           fontSize: 34,
  //           color: Colors.grey,
  //         ),
  //       );
  //     },
  //     itemCount: _ansCount,
  //   );
  // }