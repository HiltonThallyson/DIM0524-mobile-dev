import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int peopleQuantity;

  @override
  void initState() {
    super.initState();
    peopleQuantity = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            "https://p.turbosquid.com/ts-thumb/bO/i9gkVf/co/v0/jpg/1644433463/600x600/fit_q87/dbf3c5e1131b5afd931fef91f27b40d4b8c454f2/v0.jpg",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            height: 300,
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.black87),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to the hotel",
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  "People count: $peopleQuantity",
                  style: Theme.of(context).textTheme.headline3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (peopleQuantity > 0) {
                          setState(() {
                            peopleQuantity--;
                          });
                        }
                      },
                      child: const Text(
                        "-1",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          peopleQuantity++;
                        });
                      },
                      child: const Text(
                        "+1",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
