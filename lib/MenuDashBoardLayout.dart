import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'Menu.dart';

const Color backgroundColor = Colors.black45;

class MenuDashBoardLayout extends StatefulWidget {
  const MenuDashBoardLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  State<MenuDashBoardLayout> createState() => _MenuDashBoardLayoutState();
}

class _MenuDashBoardLayoutState extends State<MenuDashBoardLayout>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onMenuTap() {
    setState(() {
      if (isCollapsed) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      isCollapsed = !isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          Menu(slideAnimation: _slideAnimation, menuScaleAnimation: _menuScaleAnimation),
          Dashboard(duration: duration, onMenuTap: onMenuTap,
            isCollapsed: isCollapsed, screenWidth: screenWidth,
            scaleAnimation: _scaleAnimation,),
        ],
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
        duration: duration,
        top: 0,
        bottom: 0,
        left: isCollapsed ? 0 : 0.6 * screenWidth,
        right: isCollapsed ? 0 : -0.2 * screenWidth,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Material(
            animationDuration: duration,
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            elevation: 8,
            color: backgroundColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 15, top: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        InkWell(
                          child: const Icon(Icons.menu_rounded, color: Colors.white),
                          onTap: () {
                            setState(() {
                              if (isCollapsed) {
                                _controller.forward();
                              } else {
                                _controller.reverse();
                              }
                              isCollapsed = !isCollapsed;
                            });
                          },
                        ),
                        const Text("Dashboard",
                            style:
                                TextStyle(fontSize: 24, color: Colors.white)),
                        const Icon(Icons.settings, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Container(
                      height: 200,
                      child: PageView(
                        controller: PageController(viewportFraction: 0.8),
                        scrollDirection: Axis.horizontal,
                        pageSnapping: true,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            color: Colors.deepPurpleAccent,
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 200),
                    const Text("A sua avaliação:",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const ListTile(
                            title: Text("Média peso (7 dias)"),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(height: 16);
                        },
                        itemCount: 10)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
