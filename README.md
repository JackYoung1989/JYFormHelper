# JYFormHelper：十分钟就可以完成的表单创建、提交、展示框架
### 该工程主要处理关于表单输入、表单展示、表单提交等一系列问题的。

## 创建表单步骤：
* 1.只需要继承JYFormViewController类；
* 2.完成该- (void)configFormView 方法实现。
* 3.组装不同的JYFormModel，每一个JYFormModel就是一行表单的行，如下，
    ```Objective-C
    JYFormModel *model8 = [[JYFormModel alloc] init];
    model8.title = @"可以输入";
    model8.requestKey = @"";
    model8.placeHolder = @"Jack is a good boy";
    if (self.netModel && [JYEasyCodeHelper isNotEmpty:self.netModel.inputDefaultText]) {
        model8.contentString = self.netModel.inputDefaultText;
    }
    model8.style = JYFormModelCellStyle_InputTextField;
    model8.inputMaxLength = 5;
    [self.dataArray addObject:model8];
    ```
    
    通过修改title属性，可以修改显示的标题名字；requstKey修改对应后台的请求参数；placeHolder是占位符可自定义；
    如果网络上下来的数据需要填充，那么直接给contentString赋值，内容就会显示在表单之上；
    不同的行的样式，通过style进行区分，上面是一个输入框样式；
    可以通过inputMaxLength来控制输入的最大位数，
    还有别的一系列控制，eg.是不是必选？最小输入位数，等等
 * 4.将创建的一系列model存放在dataArray中，刷新tableView即可。
 * 5.设置self.requestURL参数，可以在点击的时候，收集所有编辑过的内容字典生成参数params，根据该URL自动完成提交工作，
    这个过程仅仅需要创建展示model和设置选择内容，方便快捷。
 
## 总结：
* 1.该方法通统一创建model驱动页面上的每一个cell的方式，来实现动态创建，动态插入删除cell的目的。
* 2.修改model的属性就可以控制某数据的产品需求要求，简单易行。
* 3.编码迅速，之前可能需要一天的时间开发的页面和处理逻辑，现在只需要十分钟足以。
* 4.代码复用性高，简洁易懂
* 5.集成简单，只需要拖入需要的文件文件夹，引用即可
      
## 具体下载demo，查看细节
