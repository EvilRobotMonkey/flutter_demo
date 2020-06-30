import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/order/page/order_list_page.dart';
import 'package:flutterapp/order/provider/order_page_provider.dart';
import 'package:flutterapp/res/colors.dart';
import 'package:flutterapp/utils/image_utils.dart';
import 'package:flutterapp/utils/theme_utils.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  State createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with SingleTickerProviderStateMixin {
  OrderPageProvider provider = OrderPageProvider();
  TabController _tabController;

  bool isDark = false;
  int _lastReportedPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  _onPageChange(int index) async {
    provider.setIndex(index);
    _tabController.animateTo(index);
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 预先缓存剩余切换图片
      _preCacheImage();
    });
  }
  _preCacheImage() {
    precacheImage(ImageUtils.getAssetImage('order/xdd_n'), context);
    precacheImage(ImageUtils.getAssetImage('order/dps_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/dwc_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/ywc_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/yqx_s'), context);
  }
  @override
  Widget build(BuildContext context) {
    isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider<OrderPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: SizedBox(
                  height: 105,
                  width: double.infinity,
                  child: isDark
                      ? null
                      : const DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: const [
                          Color(0xFF5793FA),
                          Color(0xFF4647FA)
                        ])))),
            ),
            NestedScrollView(
              physics: ClampingScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) =>
                      _sliverBuilder(context),
              body: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  /// PageView的onPageChanged是监听ScrollUpdateNotification，会造成滑动中卡顿。这里修改为监听滚动结束再更新、
                  if (notification.depth == 0 &&
                      notification is ScrollEndNotification) {
                    final PageMetrics metrics = notification.metrics;
                    final int currentPage = metrics.page.round();
                    if (currentPage != _lastReportedPage) {
                      _lastReportedPage = currentPage;
                      _onPageChange(currentPage);
                    }
                  }
                  return false;
                },
                child: PageView.builder(
                    key: const Key('pageView'),
                    itemCount: 5,
                    controller: _pageController,
                    itemBuilder: (_, index) => OrderListPage(index: index)),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return [
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(

        ),
      ),
      SliverPersistentHeader(
          pinned: true,
          delegate: SliverAppBarDelegate(
              DecoratedBox(
                  decoration: BoxDecoration(
                      color: isDark ? Colours.dark_bg_color : null,
                      image: isDark
                          ? null
                          : DecorationImage(
                              image:
                                  ImageUtils.getAssetImage('order/order_bg1'),
                              fit: BoxFit.fill)),
                  child: Text("hello")),
              80.0))
    ];
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;

  SliverAppBarDelegate(this.widget, this.height);

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
