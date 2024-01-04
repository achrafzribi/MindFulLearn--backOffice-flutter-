import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:mindfullearn_dashboard/views/dashBoard_page.dart';

import 'package:mindfullearn_dashboard/views/postList_page.dart';
import 'package:mindfullearn_dashboard/views/reelsList_page.dart';

class SidebarPage extends StatefulWidget {
  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  late List<CollapsibleItem> _items;
  late String _body;
  final NetworkImage _avatarImg = const NetworkImage(
      'https://lh3.googleusercontent.com/-QMdTmLjrPzw/AAAAAAAAAAI/AAAAAAAAAAA/AFNEGgKxgUBY-SL78VYv2hkITfaNAU5Fvg/s128-c/photo.jpg');

  @override
  void initState() {
    super.initState();
    _items = _generateItems;

    _body = "dashboard";
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Dashboard',
        icon: Icons.assessment,
        onPressed: () => setState(() => _body = "dashboard"),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Dashboard"))),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Posts',
        icon: Icons.post_add,
        onPressed: () => setState(() => _body = _body = "post"),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Posts"))),
      ),
      CollapsibleItem(
        text: 'Reels',
        icon: Icons.video_camera_back,
        onPressed: () => setState(() => _body = "reel"),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Reels"))),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: CollapsibleSidebar(
          isCollapsed: MediaQuery.of(context).size.width <= 800,
          items: _items,
          collapseOnBodyTap: false,
          avatarImg: _avatarImg,
          title: 'Yahya Fhima',
          onTitleTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Yay! Flutter Collapsible Sidebar!')));
          },
          body: _body == "dashboard"
              ? _dashBordNody(size, context)
              : _body == "post"
                  ? _postBody(size, context)
                  : _reelsBody(size, context),
          backgroundColor: Colors.black,
          selectedTextColor: Colors.limeAccent,
          textStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          titleStyle: const TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
          toggleTitleStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          sidebarBoxShadow: const [
            BoxShadow(
              color: Colors.indigo,
              blurRadius: 20,
              spreadRadius: 0.01,
              offset: Offset(3, 3),
            ),
            BoxShadow(
              color: Colors.green,
              blurRadius: 50,
              spreadRadius: 0.01,
              offset: Offset(3, 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _postBody(Size size, BuildContext context) {
    return const PostsListPage();
  }

  Widget _dashBordNody(Size size, BuildContext context) {
    return const DashBoardPage();
  }

  Widget _reelsBody(Size size, BuildContext context) {
    return const ReelsListPage();
  }
}
