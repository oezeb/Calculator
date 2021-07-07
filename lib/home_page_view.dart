import 'package:calculator/home_page_view_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageViewModel _homePageVM = HomePageViewModel();

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
        setState(() {});
      },
    );
  }

  double _currFontSize = 60;
  _fontSize(double screenWidth) {
    if (_homePageVM.textEditingController.text.length * _currFontSize >
        1.4 * screenWidth) {
      if (_currFontSize > 40) _currFontSize -= 20;
    } else if (_homePageVM.textEditingController.text.length * _currFontSize <
        screenWidth) {
      if (_currFontSize < 60) _currFontSize += 20;
    }
    return _currFontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
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
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 85,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(top: 10),
                                  child: ListView(
                                    reverse: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Container(
                                        width: 1000,
                                        child: TextField(
                                          onChanged: (text) {
                                            setState(() {});
                                          },
                                          autofocus: true,
                                          readOnly: true,
                                          showCursor: true,
                                          textAlign: TextAlign.right,
                                          controller:
                                              _homePageVM.textEditingController,
                                          style: TextStyle(
                                            fontSize: _fontSize(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width),
                                            letterSpacing: 5,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    _homePageVM.answer,
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
                                _homePageVM.showResult();
                                setState(() {});
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
