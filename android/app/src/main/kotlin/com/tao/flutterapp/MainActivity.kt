package com.tao.flutterapp

import android.widget.TextView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.view.FlutterMain
import io.flutter.view.FlutterRunArguments
import io.flutter.view.FlutterView

class MainActivity : FlutterActivity() {
    lateinit var flutterView: FlutterView
    var messageChannel: BasicMessageChannel<String>? = null
    var counter: Int = 0;
    val EMPTY_MESSAGE: String = "收到消息啦"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        val arr = arrayOfNulls<String>(0);

        FlutterMain.ensureInitializationComplete(applicationContext, arr)
        setContentView(R.layout.flutter_view_layout)


        var flutterRunArguments = FlutterRunArguments()
        //绑定路径
        flutterRunArguments.bundlePath = FlutterMain.findAppBundlePath()
        //获取入口 main方法
        flutterRunArguments.entrypoint = "main"


        flutterView = findViewById<FlutterView>(R.id.flutter_view) as FlutterView
        //flutterview 运行设置绑定
        flutterView.runFromBundle(flutterRunArguments)
        //设置消息频道
        messageChannel = BasicMessageChannel(flutterView, "android_channel", StringCodec.INSTANCE)
        messageChannel?.setMessageHandler(object : BasicMessageChannel.MessageHandler<String> {

            override fun onMessage(p0: String?, p1: BasicMessageChannel.Reply<String>) {
                print("BasicMessageChannel")
                //处理来自 flutter  main里面的消息
                onFlutterMessage();
                p1?.reply(EMPTY_MESSAGE);
            }

        })


    }

    private fun onFlutterMessage() {
        counter++
        val tv = findViewById<TextView>(R.id.button_tap)
        var decroibe: String = "android 接收 flutter $counter + 次消息} "
        tv.text = decroibe

    }
}
