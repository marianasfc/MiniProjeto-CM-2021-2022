import 'package:flutter/material.dart';

class Menu extends StatelessWidget {

  final  Animation<double> menuScaleAnimation;
  final Animation<Offset> slideAnimation;
  const Menu({Key? key, required this.menuScaleAnimation,
    required this.slideAnimation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: const [
                    Icon(Icons.home, color: Colors.white, size: 22),
                    SizedBox(width: 10),
                    Text("Dashboard",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    SizedBox(height: 10),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.add, color: Colors.white, size: 24),
                    SizedBox(width: 10),
                    Text("Novo registo",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    SizedBox(height: 10),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.history_rounded, color: Colors.white, size: 22),
                    SizedBox(width: 10),
                    Text("Histórico",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

