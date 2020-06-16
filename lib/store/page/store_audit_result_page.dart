import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/res/gaps.dart';
import 'package:flutterapp/res/styles.dart';
import 'package:flutterapp/routers/fluro_navigator.dart';
import 'package:flutterapp/routers/routers.dart';
import 'package:flutterapp/widgets/app_bar.dart';
import 'package:flutterapp/widgets/load_image.dart';
import 'package:flutterapp/widgets/my_button.dart';

class StoreAuditResultPage extends StatefulWidget {

  @override
  State createState() => _StoreAuditResultPageState();
}

class _StoreAuditResultPageState extends State<StoreAuditResultPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: '审核结果',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const LoadAssetImage('store/icon_success',
              width: 80.0,
              height: 80.0,
            ),
            Gaps.vGap12,
            Text(
              '恭喜，店铺资料审核成功',
              style: TextStyles.textSize16,
            ),
            Gaps.vGap8,
            Text(
              '2019-02-21 15:20:10',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Gaps.vGap8,
            Text(
              '预计完成时间：02月28日',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Gaps.vGap24,
            MyButton(
              onPressed: () {
                NavigatorUtils.push(context, Routes.home, clearStack: true);
              },
              text: '进入',
            )
          ],
        ),
      ),
    );
  }
}