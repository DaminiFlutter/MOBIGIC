import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'Utils/Datacostants.dart';
import 'databasehelper.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  int index = 0, noOfTextField = 0;
  String searchText = '';
  var list = [];
  late Map<int, TextEditingController> indexList;
  final TextEditingController _rowController = TextEditingController();
  final TextEditingController _columnController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _rowAnimationController;
  late AnimationController _columnAnimationController;
  final List<TextEditingController> _gridTextControllers = [];
  bool shouldCreateGrid = false, isContain = false;
  FocusNode _rowFocus = FocusNode();
  FocusNode _columnFocus = FocusNode();

  Helper db = Helper();

  @override
  void initState() {
    // TODO: implement initState
    _rowAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _columnAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    // _gridTextController.text = "hi";

    super.initState();
  }

  Widget rowWidget(BuildContext context, Widget? child, text, controller) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width - 100,
      child: TextField(
        controller: controller,
        autofocus: true,
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).requestFocus(_columnFocus);
          }
        },
        onSubmitted: (value) {
          if (value.isEmpty) {
            DataConstants.showBasicToast(
                context: context, message: "Please enter field");
          }
        },
        focusNode: _rowFocus,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: "Enter No Of $text",
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(width: 1, color: Colors.blue)),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(
                    width: 2, style: BorderStyle.none, color: Colors.blue)),
            filled: true),
      ),
    );
  }

  Widget columnWidget(BuildContext context, Widget? child, text, controller) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width - 100,
      child: TextField(
        controller: controller,
        onChanged: (value) {},
        focusNode: _columnFocus,
        onSubmitted: (value) {
          if (value.isEmpty) {
            DataConstants.showBasicToast(
                context: context, message: "Please enter field");
          }
          if (_rowController.text.isNotEmpty &&
              _columnController.text.isNotEmpty) {
            setState(() {
              shouldCreateGrid = true;
            });
            int rowLength = int.parse(_rowController.text);
            int columnLength = int.parse(_columnController.text);
            noOfTextField = rowLength * columnLength;
            for (var j = 0; j < noOfTextField; j++) {
              final controller = TextEditingController();
              _gridTextControllers.add(controller);
              list.add(j);
            }
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: "Enter No Of $text",
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(width: 1, color: Colors.blue)),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(
                    width: 2, style: BorderStyle.none, color: Colors.blue)),
            filled: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFF7acaf5),
                const Color(0xFFebf0f2),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: height - 800,
            ),
            AnimatedTextKit(
                repeatForever: true,
                isRepeatingAnimation: true,
                animatedTexts: [
                  TyperAnimatedText("Let's Play A Game",
                      speed: Duration(milliseconds: 100),
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TyperAnimatedText("Let's Have  fun",
                      speed: Duration(milliseconds: 100),
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TyperAnimatedText("Let's Create Memories ",
                      speed: Duration(milliseconds: 100),
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ]),
            const SizedBox(
              height: 50,
            ),
            AnimatedBuilder(
                animation: _rowAnimationController,
                builder: (context, child) =>
                    rowWidget(context, child, "Rows", _rowController)),
            const SizedBox(
              height: 20,
            ),
            AnimatedBuilder(
                animation: _columnAnimationController,
                builder: (context, child) =>
                    columnWidget(context, child, "Columns", _columnController)),
            shouldCreateGrid
                ? Expanded(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: width - 100,
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                searchText = _searchController.text;
                                print("list => $list");
                                for (var i = 0;
                                    i < _gridTextControllers.length;
                                    i++) {

                                  if (_gridTextControllers[i]
                                      .text
                                      .toLowerCase()
                                      .contains(value.toLowerCase())) {
                                    setState(() {
                                      list[i]=true;
                                    });
                                    print("Indexlist => $list");
                                  }
                                  else{
                                    list[i]=false;
                                  }
                                }
                                //  print("Search list => $list");
                              },
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  // labelText: "Search text",
                                  hintText: "Search text",
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.blue)),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      borderSide: BorderSide(
                                          width: 2,
                                          style: BorderStyle.none,
                                          color: Colors.blue)),
                                  filled: true),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // for(var x=0;x< noOfTextField;x++)
                          //   _gridTextControllers.any((element) => element.text.toLowerCase().contains(searchText.toLowerCase()))?
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: int.parse(_rowController.text) *
                                int.parse(_columnController.text),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        int.parse(_columnController.text),
                                    childAspectRatio:
                                        int.parse(_rowController.text) *
                                            int.parse(_columnController.text) /
                                            2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: _searchController.text.isNotEmpty
                                          ? list[index] == true
                                              ? Colors.greenAccent
                                              : Colors.white
                                          : Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18))),
                                  child: Center(
                                      child: TextField(
                                    controller: _gridTextControllers[index],
                                    dragStartBehavior: DragStartBehavior.start,
                                    textDirection: TextDirection.ltr,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        border: InputBorder.none,
                                        hintText: "Enter a word"),
                                  )),
                                ),
                              );
                            },
                          )
                          //     :
                          // SizedBox.shrink(),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink()
          ],
        )),
      ),
    );
  }
}
