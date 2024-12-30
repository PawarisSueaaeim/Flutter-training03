import 'package:flutter/material.dart';

class TabMenuPage extends StatefulWidget {
  final String username;
  final String avatarUrl;

  const TabMenuPage(
      {super.key, required this.username, required this.avatarUrl});

  @override
  State<TabMenuPage> createState() => _TabMenuPageState();
}

class _TabMenuPageState extends State<TabMenuPage> {
  late String _username;
  late String _avatarUrl;

  @override
  void initState() {
    super.initState();
    _username = widget.username;
    _avatarUrl = widget.avatarUrl;
  }

  static const List<Tab> _tabItems = <Tab>[
    Tab(
      text: 'Home',
    ),
    Tab(
      text: 'Contact',
    ),
    Tab(
      text: 'Profile',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(tabs: _tabItems),
            ),
            body: TabBarView(children: [
              const Center(
                child: Text('Home'),
              ),
              const Center(
                child: Text('Contact'),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      _avatarUrl,
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(_username)
                  ],
                ),
              )
            ])));
  }
}
