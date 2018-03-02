# Emergency
简要介绍：紧急处理

在项目中某些控制器失去原有的预料之中的作用的时候，我们应当立即修复
而现在热修复是不被允许使用的，那么可以退而求其次，在一定的情况下，将本来是跳转到原生的界面拦截并跳转到一个用来代替的网页界面或者一个临时的图片作为代替。
当然，是需要通过后台来进行控制的。

#使用方法
1、一般是全局使用，则在 appdelegate 中导入对应的头文件即可
```
#import "UIViewController+Emergency.h"
#import "UINavigationController+Emergency.h"
```

2、 使用 `EmergencyObject.h` 中的方法控制哪些需要进行类进行跳转，且进行怎样的跳转。
支持 NSURL 与 UIImage 来代替原生页面

3、 如果出现重复的，则以最后一个为准
