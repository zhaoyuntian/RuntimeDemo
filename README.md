# RuntimeDemo


#MethodSwizzling

#1UIViewController生命周期应用实例
#2NSArray、NSDictionary、NSMutableArray、NSMutableDictionary
不免会进行索引访问、添加、删除元素的操作，越界问题也是很常见，
这时我们可以通过Method Swizzling解决这些问题，
越界给予提示防止崩溃。
