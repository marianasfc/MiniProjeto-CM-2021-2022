import 'package:flutter/material.dart';

const Color backgroundColor = Colors.black45;

class Dashboard extends StatelessWidget {
  final Duration duration;
  final bool isCollapsed;
  final Animation<double> scaleAnimation;
  final double screenWidth;
  final Function onMenuTap;

  const Dashboard({Key? key, required this.isCollapsed,
    required this.screenWidth, required this.duration,
    required this.scaleAnimation, required this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        duration: duration,
        top: 0,
        bottom: 0,
        left: isCollapsed ? 0 : 0.6 * screenWidth,
        right: isCollapsed ? 0 : -0.2 * screenWidth,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Material(
            animationDuration: duration,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            elevation: 8,
            color: backgroundColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
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
                          child: Icon(Icons.menu_rounded, color: Colors.white),
                          onTap: onMenuTap(),
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
