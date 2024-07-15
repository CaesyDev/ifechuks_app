// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class AllCategories extends StatefulWidget {
  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  ScrollController _scrollController = ScrollController();
  bool _showTitle = true;

  final _kPages = <String, IconData>{
    'home': Icons.home,
    'map': Icons.map,
    'add': Icons.add,
    'message': Icons.message,
    'people': Icons.people,
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 50 && _showTitle) {
        setState(() {
          _showTitle = false;
        });
      } else if (_scrollController.offset < 50 && !_showTitle) {
        setState(() {
          _showTitle = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 2,
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              snap: true,
              floating: true,
              expandedHeight: 90.0,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    centerTitle: false,
                    title: top > 100
                        ? Text("What are you looking for?",
                            style: TextStyle(color: Colors.white, fontSize: 16))
                        : Container(),
                    background: Container(color: Colors.green),
                  );
                },
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 95.0,
                maxHeight: 95.0,
                child: Container(
                  color: Colors.green,
                  padding: const EdgeInsets.only(top: 25.0, bottom: 8, left: 8, right: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(right: 8.0),
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextButton(onPressed: () {

                          }, child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text("All Nigeria", style: TextStyle(color: Colors.white),),
                            Icon(Icons.arrow_drop_down_sharp, color: Colors.white,)
                          ],)),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: EdgeInsets.only(right: 8.0),
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextButton(onPressed: () {

                          }, child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text("I am looking for ...", style: TextStyle(color: Colors.white),),
                            Icon(Icons.search, color: Colors.white,)
                          ],)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),



            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item #$index'),
                  );
                },
                childCount: 100,
              ),
            ),
          ],
        ),
        bottomNavigationBar: ConvexAppBar.badge(
          backgroundColor: Colors.green,
          const <int, dynamic>{3: '99+'},
          style: TabStyle.reactCircle,
          items: <TabItem>[
            for (final entry in _kPages.entries)
              TabItem(icon: entry.value, title: entry.key),
          ],
          onTap: (int i) => print('click index=$i'),
        ),
      ),
    );
  }


}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
