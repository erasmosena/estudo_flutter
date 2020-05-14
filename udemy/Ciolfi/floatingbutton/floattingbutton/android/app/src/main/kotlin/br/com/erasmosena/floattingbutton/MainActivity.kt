package br.com.erasmosena.floattingbutton

import android.support.annotation.NonNull;
import android.widget.ImageView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

import com.yhao.floatwindow.FloatWindow
import com.yhao.floatwindow.Screen

enum class operacao { create, show, hide, isShowing }
class MainActivity: FlutterActivity() {

    private val CHANNEL = "android.channel.floating_window";

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL)
        channel.setMethodCallHandler{
            call, result ->
            when (call.method){
                "create" -> {
                    println("create is called")
                    val imageView = ImageView(applicationContext)
                    imageView.setImageResource(R.drawable.plus)
                    FloatWindow.with(applicationContext).setView(imageView)
                            .setWidth(Screen.width, 0.15f)
                            .setHeight(Screen.width, 0.15f)
                            .setX(Screen.width, 0.8f)
                            .setY(Screen.height, 0.3f)
                            .setDesktopShow(true)
                            .build()
                    imageView.setOnClickListener {
                        channel.invokeMethod("touch",null)
                    }

                }
                "show" -> {
                    println("show is called")
                    FloatWindow.get().show()
                }
                "hide" -> {
                    println("hide is called")
                    FloatWindow.get().hide()
                }
                "isShowing" -> {
                    println("isShowing is called")
                    result.success(FloatWindow.get().isShowing)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onDestroy() {
        FloatWindow.destroy()
        super.onDestroy()
    }
}
