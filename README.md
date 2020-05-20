# flutterapp

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

##项目实现中遇到的问题
+ 使用Flutter运行Android模拟器的时候报错：
```
FAILURE: Build failed with an exception.                                
                                                                        
* What went wrong:                                                      
Could not determine the dependencies of task ':app:compileDebugJavaWithJavac'.
> Could not resolve all task dependencies for configuration ':app:debugCompileClasspath'.
   > Could not resolve io.flutter:flutter_embedding_debug:1.0.0-540786dd51f112885a89792d678296b95e6622e5.
     Required by:                                                       
         project :app                                                   
      > Skipped due to earlier error                                    
      > Skipped due to earlier error                                    
      > Skipped due to earlier error                                    
      > Skipped due to earlier error                                    
   > Could not resolve io.flutter:x86_debug:1.0.0-540786dd51f112885a89792d678296b95e6622e5.
     Required by:                                                       
         project :app                                                   
      > Skipped due to earlier error                                    
      > Skipped due to earlier error                                    
      > Skipped due to earlier error                                    
      > Skipped due to earlier error                                    
   > Could not resolve io.flutter:x86_64_debug:1.0.0-540786dd51f112885a89792d678296b95e6622e5.
     Required by:                                                       
         project :app                                                   
      > Skipped due to earlier error                                    
      > Skipped due to earlier error                                    
      > Skipped due to earlier error                                    
      > Skipped due to earlier error                                    
                                                                        
* Try:                                                                  
Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.
                                                                        
* Get more help at https://help.gradle.org                              
                                                                        
BUILD FAILED in 1m 48s 
```
 
解决方法：

修改文件：flutter/packages/flutter_tools/gradle/resolve_dependencies.gradle
`url "http://download.flutter.io" `
修改文件：flutter/packages/flutter_tools/gradle/flutter.gradle
`private static final String MAVEN_REPO = "http://download.flutter.io";`

+ 找不见资源文件 

需要在 pubspec.yaml 文件中声明 精确到文件夹
```
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true
  assets:
    - assets/images/
    - assets/images/state/

```
