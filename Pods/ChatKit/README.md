# ChatKit 使用指南 · iOS

<p align="center">
![enter image description here](https://img.shields.io/badge/pod-v0.5.0-brightgreen.svg)  ![enter image description here](https://img.shields.io/badge/platform-iOS%207.0%2B-ff69b5618733984.svg) 
<a href="https://github.com/leancloud/ChatKit-OC/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</a>

在使用中有任何问题都可以到[我们的官方论坛](https://forum.leancloud.cn/c/jing-xuan-faq)提问题，会有专业工程师回复，平均响应时间在24小时内。

## 简介

[ChatKit](https://github.com/leancloud/ChatKit-OC) 是一个免费且开源的 UI 聊天组件，由 LeanCloud 官方推出，底层聊天服务基于 LeanCloud 的 IM 实时通信服务「LeanMessage」而开发。它可以帮助开发者快速集成 IM 服务，轻松实现聊天功能，提供完全自由的授权协议，支持二次开发。其最大特点是把聊天常用的一些功能配合 UI 一起提供给开发者。

## 获取项目 

```
git clone --depth=1 https://github.com/leancloud/ChatKit-OC
```

## 集成效果

从大量的使用场景来看，「最近联系人列表」和「聊天界面」这两个页面是开发者最常使用的，同时也是比较难处理的。

最近联系人页面实现的难点在于：

- 要根据最近打开的聊天窗口排序联系人列表；
- 对每一个最近聊天人／组需要显示最新的一条消息及时间；
- 需要实时更新未读消息的计数；

而聊天页面的实现难点则在于：

- 消息种类繁多，要有比较好的用户体验，界面以及异步处理方面有大量的开发工作；
- 音视频消息的录制和发送，需要对系统以及 LeanCloud 实时通信 API 比较熟悉；
- 推、拉展示本对话中的最新消息，需要对 LeanCloud 实时通信接口比较熟悉；

我们在 ChatKit 中重点完成了这两个页面的开发，大家可以看看效果：

最近联系人 | 语音消息，根据语音长度调整宽度 | 图片消息，尺寸自适应 
-------------|-------------|-------------|-------------
![enter image description here](http://i63.tinypic.com/1zxqjns.jpg)|![enter image description here](http://i68.tinypic.com/2rx9sfq.jpg)  | ![enter image description here](http://i64.tinypic.com/aw87wl.jpg) 

 地理位置消息| 失败消息本地缓存，可重发 |上传图片，进度条提示 
 -------------|-------------|-------------
![enter image description here](http://i65.tinypic.com/2vmuaf4.jpg) | ![enter image description here](http://i68.tinypic.com/n6b29v.jpg)| ![enter image description here](http://i66.tinypic.com/orrrxh.jpg)

图片消息支持多图联播，支持多种分享 |文本消息支持图文混排| 文本消息支持双击全屏展示 | 健壮的输入框
-------------|-------------|-------------|----
![enter image description here](http://i65.tinypic.com/wmjuvs.jpg) | ![enter image description here](http://i63.tinypic.com/2eoa4j6.jpg) | ![enter image description here](http://i63.tinypic.com/1z1z5ur.jpg) | ![enter image description here](http://image18-c.poco.cn/mypoco/myphoto/20160805/13/17338872420160805133757084.gif?408x758_110) 

## 项目结构

```
├── ChatKit  ＃核心库文件夹
│   ├── LCChatKit.h  # 这是整个库的入口，也是中枢，相当于”组件化方案“中的 Mediator。
│   ├── LCChatKit.m
│   └── Class
│       ├── Model
│       ├── Module
│       │   ├── Base
│       │   ├── Conversation
│       │   │   ├── Controller
│       │   │   ├── Model
│       │   │   ├── Tool
│       │   │   └── View
│       │   └── ConversationList
│       │       ├── Controller
│       │       ├── Model
│       │       └── View
│       ├── Resources  # 资源文件，如图片、音频等
│       ├── Tool
│       │   ├── Service
│       │   └── Vendor
│       └── View
└── ChatKit-OC  # Demo演示
    ├── ChatKit-OC.xcodeproj
    └── Example
        └── LCChatKitExample.h  #这是Demo演示的入口类，这个类中提供了很多胶水函数，可完成初步的集成
        └── LCChatKitExample.m
            ├── Model
            ├── Module
            │   ├── ContactList
            │   │   ├── Controller
            │   │   ├── Tool
            │   │   └── View
            │   ├── Login
            │   │   ├── Controller
            │   │   ├── Model
            │   │   └── View
            │   ├── Main
            │   │   ├── Controller
            │   │   └── View
            │   └── Other
```

 从上面可以看出，`ChatKit-OC` 项目包分为两个部分：

* `ChatKit` 是库的核心库文件夹。
* `ChatKit-OC` 为Demo 演示部分，其中 `LCChatKitExample` 这个类提供了很多胶水函数，可完成初步的集成。


 ## 使用方法

为了让这个库更易入手，避免引入过多公开的类和概念，我们采用了类似「组件化」的方式进行构建，即将你在使用 ChatKit 库时所需要用到的所有方法都放在了 `LCChatKit` 这一个类中。它是一个 Mediator，是整个库的入口，也是中枢。

 使用 ChatKit 大体有几个步骤：

 1. 在 `-[AppDelegate application:didFinishLaunchingWithOptions:]` 中调用 `-[LCChatKit setAppId:appKey:]` 来开启 LeanCloud 服务。
 2. 调用 `-[LCChatKit sharedInstance]` 来初始化一个单例对象。
 3. 调用 `-[[LCChatKit sharedInstance] openWithClientId:callback:]` 开启 LeanCloud 的 IM 服务 LeanMessage，开始聊天。
 4. 调用 `-[[LCChatKit sharedInstance] closeWithCallback:]` 关闭 LeanCloud 的 IM 服务，结束聊天。
 5. 实现 `-[[LCChatKit sharedInstance] setFetchProfilesBlock:]`，设置用户体系，里面要实现如何根据 userId 获取到一个 User 对象的逻辑。ChatKit 会在需要用到 User 信息时调用你设置的这个逻辑。 `LCCKUserSystemService.h` 文件中给出了例子，演示了如何集成 LeanCloud 原生的用户系统 `AVUser`。
 6. 如果你实现了 `-[[LCChatKit sharedInstance] setGenerateSignatureBlock:]` 方法，那么 ChatKit 会自动为以下行为添加签名：`open`（开启聊天）、`start`（创建对话）、`kick`（踢人）、`invite`（邀请）。反之不会。

下面按步骤进行详细的介绍。

### CocoaPods 导入

在文件 `Podfile` 中加入以下内容：

```shell
pod 'ChatKit'
```

然后使用 CocoaPods 进行安装。如果尚未安装 CocoaPods，运行以下命令进行安装：

```shell
gem install cocoapods
```

安装成功后就可以安装依赖了。建议使用如下方式：

```shell
 # 禁止升级 CocoaPods 的 spec 仓库，否则会卡在 Analyzing dependencies，非常慢
 pod update --verbose --no-repo-update
```

如果提示找不到库，则可去掉 `--no-repo-update`。

如果不想使用 CocoaPods 进行集成，也可以选择使用 [源码集成](https://github.com/leancloud/ChatKit-OC#手动集成)。

### 胶水函数快速集成

ChatKit 提供了一个快速集成的演示类 `LCChatKitExample`，路径如下：

```Objective-C
 ├── ChatKit  ＃核心库文件夹
 └──  ChatKit-OC  # Demo演示
    ├── ChatKit-OC.xcodeproj
    └── Example
        └── LCChatKitExample.h  # 这是 Demo 演示的入口类，这个类中提供了很多胶水函数，可完成初步的集成。
        └── LCChatKitExample.m
```

使用 `LCChatKitExample` 提供的函数即可完成从程序启动到登录再到登出的完整流程。

- 在 `-[AppDelegate didFinishLaunchingWithOptions:]` 等函数中调用下面这几个基础的入口胶水函数，可完成初步的集成。
- 胶水代码中包含了特地设置的 `#warning`，请仔细阅读这些 warning 的注释，根据实际情况调整代码，以符合你的需求。

```Objective-C
/*!
 *  入口胶水函数：初始化入口函数
 *
 *  程序完成启动，在 appdelegate 中的 `-[AppDelegate didFinishLaunchingWithOptions:]` 一开始的地方调用.
 */
+ (void)invokeThisMethodInDidFinishLaunching;

/*!
 * Invoke this method in `-[AppDelegate appDelegate:didRegisterForRemoteNotificationsWithDeviceToken:]`.
 */
+ (void)invokeThisMethodInDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

/*!
 * invoke This Method In `-[AppDelegate application:didReceiveRemoteNotification:]`
 */
+ (void)invokeThisMethodInApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo ;

/*!
 *  入口胶水函数：登入入口函数
 *
 *  用户即将退出登录时调用
 */
+ (void)invokeThisMethodAfterLoginSuccessWithClientId:(NSString *)clientId success:(LCCKVoidBlock)success failed:(LCCKErrorBlock)failed;

/*!
 *  入口胶水函数：登出入口函数
 *
 *  用户即将退出登录时调用
 */
+ (void)invokeThisMethodBeforeLogoutSuccess:(LCCKVoidBlock)success failed:(LCCKErrorBlock)failed;
+ (void)invokeThisMethodInApplicationWillResignActive:(UIApplication *)application;
+ (void)invokeThisMethodInApplicationWillTerminate:(UIApplication *)application;
```

### 最近联系人界面

主流的社交聊天软件，例如微信和 QQ 都会把最近联系人界面作为登录后的首页，可见其重要性。因此我们在 ChatKit 也提供了对话列表 `LCIMConversationListController` 页面，初始化方法非常简单：

```Objective-C
LCCKConversationListViewController *firstViewController = [[LCCKConversationListViewController alloc] init];
```

因为最近联系人的所有信息都由 ChatKit 内部维护，不需要传入额外数据，所以直接展示这个 ViewController 即可。最近联系人界面的数据，依赖于本地数据库。这些数据会在聊天过程中自动进行更新，你无需进行繁琐的数据库操作。

#### 由最近联系人进入聊天界面

按照上面的步骤，我们可以非常方便地打开最近联系人页面。但是我们会发现，点击其中的某个联系人／聊天群组，我们并不能直接进入聊天界面。要做到这一点，我们需要给 LCChatKit 设置上事件响应函数，示例代码如下：

```objective-c
[[LCChatKit sharedInstance] setDidSelectConversationsListCellBlock:^(NSIndexPath *indexPath, AVIMConversation *conversation, LCCKConversationListViewController *controller) {
    NSLog(@"conversation selected");
    LCCKConversationViewController *conversationVC = [[LCCKConversationViewController alloc] initWithConversationId:conversation.conversationId];
    [controller.navigationController pushViewController:conversationVC animated:YES];
}];
```

对于联系人列表页面，我们在 LCChatKit 可以响应如下四种操作：

```objective-c
/*!
 *  选中某个对话后的回调 (比较常见的需求)
 *  @param conversation 被选中的对话
 */
typedef void(^LCCKConversationsListDidSelectItemBlock)(NSIndexPath *indexPath, AVIMConversation *conversation, LCCKConversationListViewController *controller);
/*!
 *  设置选中某个对话后的回调
 */
- (void)setDidSelectConversationsListCellBlock:(LCCKConversationsListDidSelectItemBlock)didSelectItemBlock;

/*!
 *  删除某个对话后的回调 (一般不需要做处理)
 *  @param conversation 被选中的对话
 */
typedef void(^LCCKConversationsListDidDeleteItemBlock)(NSIndexPath *indexPath, AVIMConversation *conversation, LCCKConversationListViewController *controller);
/*!
 *  设置删除某个对话后的回调
 */
- (void)setDidDeleteConversationsListCellBlock:(LCCKConversationsListDidDeleteItemBlock)didDeleteItemBlock;

/*!
 *  对话左滑菜单设置block (最近联系人页面有复杂的手势操作时，可以通过这里扩展实现)
 *  @return  需要显示的菜单数组
 *  @param conversation, 对话
 *  @param editActions, 默认的菜单数组，成员为 UITableViewRowAction 类型
 */
typedef NSArray *(^LCCKConversationEditActionsBlock)(NSIndexPath *indexPath, NSArray<UITableViewRowAction *> *editActions, AVIMConversation *conversation, LCCKConversationListViewController *controller);
/*!
 *  可以通过这个block设置对话列表中每个对话的左滑菜单，这个是同步调用的，需要尽快返回，否则会卡住UI
 */
- (void)setConversationEditActionBlock:(LCCKConversationEditActionsBlock)conversationEditActionBlock;
```



### 聊天界面

<div class="callout callout-info">ChatKit 中的对话是一个 `AVIMConversation` 对象， LeanMessage
用它来管理对话成员，发送消息，不区分群聊、单聊。Demo 中采用了判断对话人数的方式来区分群聊、单聊。</div>

聊天界面有两种初始化方式：

```Objective-C
// 用于单聊，默认会创建一个只包含两个成员的 unique 对话(如果已经存在则直接进入，不会重复创建)
LCCKConversationViewController *conversationViewController = [[LCCKConversationViewController alloc] initWithPeerId:peerId];
```

```Objective-C
// 单聊或群聊，用于已经获取到一个对话基本信息的场合。
LCCKConversationViewController *conversationViewController = [[LCCKConversationViewController alloc] initWithConversationId:conversationId];
```

这里注意，通过 `peerId` 初始化，内部实现时，如果没有一个 unique 对话刚好包含这两个成员，则会先创建一个 unique 对话，所以调用该方法时可能会导致 _Conversation 表中自动增加一条记录。同理，通过 `conversationId` 初始化群聊，内部实现时，如果不是对话成员会先把当前用户加入对话，并开启群聊。

#### 响应聊天界面的几类操作

由于有了 ChatKit 的帮助，聊天界面的初始化和展示非常简单，但是这里面交互上还有很多地方需要自定义扩展。

- 内部异常对话无法创建

如果通过 peerId 打开对话，或者通过 conversationId 打开对话时，网络出现问题或 传入参数有误，那么对话根本无法进行，这时候我们可以通过给 LCCKConversationViewController 设定 conversationHandler 进行处理。示例代码如下：

```objective-c
[conversationVC setConversationHandler:^(AVIMConversation *conversation, LCCKConversationViewController *conversationController) {
    if (!conversation) {
        // 显示错误提示信息
        [conversationController alert:@"failed to create/load conversation."];
    } else {
        // 正常处理
    }
}];
```

- 对话详情页展示

在 QQ／微信之类的聊天应用中，聊天界面右上角会提供一个显示对话详细信息的按钮，点击可以打开对话详情页面，在那里可以进行改名、拉人、踢人、静音等操作。LCCKConversationViewController 中通过调用以下 API 也支持这一功能：

```objective-c
typedef void(^LCCKBarButtonItemActionBlock)(void);

typedef NS_ENUM(NSInteger, LCCKBarButtonItemStyle) {
    LCCKBarButtonItemStyleSetting = 0,
    LCCKBarButtonItemStyleMore,
    LCCKBarButtonItemStyleAdd,
    LCCKBarButtonItemStyleAddFriends,
    LCCKBarButtonItemStyleShare,
    LCCKBarButtonItemStyleSingleProfile,
    LCCKBarButtonItemStyleGroupProfile,
};

- (void)configureBarButtonItemStyle:(LCCKBarButtonItemStyle)style action:(LCCKBarButtonItemActionBlock)action;
```

示例代码如下：

```objective-c
[conversationController configureBarButtonItemStyle:LCCKBarButtonItemStyleGroupProfile action:^{
    ConversationDetailViewController *detailVC = [[ConversationDetailViewController alloc] init];// 自己实现的对话详情页
    detailVC.conversation = conversation;
    [conversationController.navigationController pushViewController:detailVC animated:YES];
}];
```

### 自定义消息

自定义消息分几种：

最简单的一种是：

暂态消息，且不需要显示自定义Cell的自定义消息。

请自行监听 `LCCKNotificationCustomMessageReceived` 通知，自行处理响应事件。

比如直播聊天室的弹幕消息、点赞出心这种暂态消息，不会存在聊天记录里，也不会有离线通知。

发送消息接口：


 ```Objective-C
 //  LCCKConversationViewController.h
/*!
 * 自定义消息位置发送
 */
- (void)sendCustomMessage:(AVIMTypedMessage *)customMessage;

/*!
 * 自定义消息位置发送
 */
- (void)sendCustomMessage:(AVIMTypedMessage *)customMessage
            progressBlock:(AVProgressBlock)progressBlock
                  success:(LCCKBooleanResultBlock)success
                   failed:(LCCKBooleanResultBlock)failed;
 ```


#### 需要显示自定义Cell的消息：

这里以Demo里的 VCard 名片消息为例：

第一步：定义自定义消息。

 [《iOS 实时通信开发指南》](https://leancloud.cn/docs/realtime_guide-ios.html#消息) 里面详细介绍了自定义消息的步骤。
 
 这里再介绍下 Demo 里的 VCard 消息的自定义过程：
 
定义一个`LCCKVCardMessage` 自定义消息，继承 `AVIMTypedMessage` ，并遵循、实现 `AVIMTypedMessageSubclassing` 协议：

 ```Objective-C
#pragma mark -
#pragma mark - Override Methods

#pragma mark -
#pragma mark - AVIMTypedMessageSubclassing Method

+ (void)load {
    [self registerSubclass];
}

+ (AVIMMessageMediaType)classMediaType {
    return kAVIMMessageMediaTypeVCard;
}

 ```


在初始化自定义消息时，需要注意，务必添加三个字段，ChatKit 内部会使用到。

字段名 | 作用 | 备注
-------------|-------------|-------------
degrade | 用来定义如何展示老版本未支持的自定义消息类型  | 添加到自定义消息的 attributes 字典属性下
typeTitle | 最近对话列表中最近一条消息的title，比如：最近一条消息是图片，可设置该字段内容为：`@"图片"`，相应会展示：`[图片]`） | 同上
summary | 用来显示在push提示中  | 同上，另外，这个字段是为了方便自定义推送内容，这需要借助云引擎实现。

以上三个字段需要添加到自定义消息的 attributes 字典属性下，ChatKit 给出了一个方法来方便添加 `-lcck_setObject:forKey:` ，用法如下：


 ```Objective-C
/*!
 * 有几个必须添加的字段：
 *  - degrade 用来定义如何展示老版本未支持的自定义消息类型
 *  - typeTitle 最近对话列表中最近一条消息的title，比如：最近一条消息是图片，可设置该字段内容为：`@"图片"`，相应会展示：`[图片]`。
 *  - summary 会显示在 push 提示中
 * @attention 务必添加这三个字段，ChatKit 内部会使用到。
 */
- (instancetype)initWithClientId:(NSString *)clientId {
    self = [super init];
    if (!self) {
        return nil;
    }
    [self lcck_setObject:@"名片" forKey:LCCKCustomMessageTypeTitleKey];
    [self lcck_setObject:@"这是一条名片消息，当前版本过低无法显示，请尝试升级APP查看" forKey:LCCKCustomMessageDegradeKey];
    [self lcck_setObject:@"有人向您发送了一条名片消息，请打开APP查看" forKey:LCCKCustomMessageSummaryKey];
    [self lcck_setObject:clientId forKey:@"clientId"];
    return self;
}
 ```



#### 自定义消息 Cell

继承 `LCCKChatMessageCell` ，并遵循、实现 `LCCKChatMessageCellSubclassing` 协议，重载父类方法:

这里注意 `+classMediaType` 返回的类型与自定义消息里返回的类型一致：


 ```Objective-C
#pragma mark -
#pragma mark - LCCKChatMessageCellSubclassing Method

+ (void)load {
    [self registerCustomMessageCell];
}

+ (AVIMMessageMediaType)classMediaType {
    return kAVIMMessageMediaTypeVCard;
}
 ```

重写父类的下列方法：

推荐使用 AutoLayout 进行布局，如果你在布局中对 `self.contentView` 进行了合理的约束，ChatKit 将自定计算 Cell 高度。如果你没有对 `self.contentView`
进行约束，那么你需要额外提供 Cell 的 Size 数据：

 - Auto layout 布局请请重载 `-systemLayoutSizeFittingSize:`
 - Frame layout 布局请重载 `-sizeThatFits:`

比如：

 ```Objective-C
- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, A+B+C+D+E+....);
}
 ```


具体用法请参考[文档](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)。

Demo 中的用法如下：

 ```Objective-C
#pragma mark -
#pragma mark - Override Methods

- (void)setup {
    [self.vCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(LCCK_MSG_SPACE_TOP, LCCK_MSG_SPACE_LEFT, LCCK_MSG_SPACE_BTM, LCCK_MSG_SPACE_RIGHT));
    }];
    [self updateConstraintsIfNeeded];
    [super setup];
}

- (void)configureCellWithData:(AVIMTypedMessage *)message {
    [super configureCellWithData:message];
    NSString *clientId;
    NSString *name = nil;
    NSURL *avatarURL = nil;
    clientId = [message.attributes valueForKey:@"clientId"];
    [[LCChatKit sharedInstance] getCachedProfileIfExists:clientId name:&name avatarURL:&avatarURL error:nil];
    if (!name) {
        name = clientId;
    }
    if (!name) {
        name = @"未知用户";
    }
    
    [self.vCardView configureWithAvatarURL:avatarURL title:name clientId:clientId];
}

 ```
 
 自定义Cell的点击事件，请在自定义cell中自行定义、响应，Demo中采用了添加 Tap 手势的方式。


#### 自定义输入框插件
用法与自定义消息和自定义cell类似：
继承 LCCKInputViewPlugin ，遵循、实现 `LCCKInputViewPluginSubclassing` 协议，

 ```Objective-C
#pragma mark -
#pragma mark - LCCKInputViewPluginSubclassing Method

+ (void)load {
    [self registerCustomInputViewPlugin];
}

+ (LCCKInputViewPluginType)classPluginType {
    return LCCKInputViewPluginTypeVCard;
}

 ```

UI自定义，需要实现 `LCCKInputViewPluginDelegate` 方法：


 ```Objective-C
#pragma mark -
#pragma mark - LCCKInputViewPluginDelegate Method

/**
 * 插件图标
 */
- (UIImage *)pluginIconImage {
    return [self imageInBundlePathForImageName:@"chat_bar_icons_location"];
}

/**
 * 插件名称
 */
- (NSString *)pluginTitle {
    return @"名片";
}

/**
 * 插件对应的 view，会被加载到 inputView 上
 */
- (UIView *)pluginContentView {
    return nil;
}

/**
 * 插件被选中运行
 */
- (void)pluginDidClicked {
    [super pluginDidClicked];
    [self presentSelectMemberViewController];
}

/**
 * 发送自定消息的实现
 */
- (LCCKIdResultBlock)sendCustomMessageHandler {
    if (_sendCustomMessageHandler) {
        return _sendCustomMessageHandler;
    }
    LCCKIdResultBlock sendCustomMessageHandler = ^(id object, NSError *error) {
        LCCKVCardMessage *vCardMessage = [LCCKVCardMessage vCardMessageWithClientId:object];
        [self.conversationViewController sendCustomMessage:vCardMessage progressBlock:^(NSInteger percentDone) {
        } success:^(BOOL succeeded, NSError *error) {
            [self.conversationViewController sendLocalFeedbackTextMessge:@"名片发送成功"];
        } failed:^(BOOL succeeded, NSError *error) {
            [self.conversationViewController sendLocalFeedbackTextMessge:@"名片发送失败"];
        }];
        //important: avoid retain cycle!
        _sendCustomMessageHandler = nil;
    };
    _sendCustomMessageHandler = sendCustomMessageHandler;
    return sendCustomMessageHandler;
}
 ```
 
 这里注意在 `-sendCustomMessageHandler` 定义时记得在Block执行结束时，执行 `_sendCustomMessageHandler = nil;` ，避免循环引用。


### 手动集成

如果你不想使用 CocoaPods 进行集成，也可以选择使用源码集成。步骤如下：

第一步：

将 [项目结构](https://github.com/leancloud/ChatKit-OC#项目结构) 中提到的 ChatKit 这个「核心库文件夹」拖拽到项目中。

第二步：

添加 ChatKit 依赖的第三方库以及对应版本：

- [AVOSCloud](sdk_down.html) v3.3.5
- [AVOSCloudIM](sdk_down.html) v3.3.5
- [MJRefresh](https://github.com/CoderMJLee/MJRefresh) 3.1.9
- [Masonry](https://github.com/SnapKit/Masonry) v1.0.1 
- [SDWebImage](https://github.com/rs/SDWebImage) v3.8.0
- [FMDB](https://github.com/ccgus/fmdb) 2.6.2 
- [UITableView+FDTemplateLayoutCell](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell) 1.5.beta


## 常见问题

**ChatKit 组件收费么？**<br/>
ChatKit 是完全开源并且免费给开发者使用，使用聊天所产生的费用以账单为准。

**接入 ChatKit 有什么好处？**<br/>
它可以减轻应用或者新功能研发初期的调研成本，直接引入使用即可。ChatKit 从底层到 UI 提供了一整套的聊天解决方案。

**如何兼容 iOS7 ？**<br/>
因为ChatKit中使用了 iOS8 的一个控件：UITableViewRowAction ，所以想要兼容 iOS7 就需要在你的 App 中添加一个 Lib：

 ```Objective-C
pod "CYLTableViewRowAction", "1.0.0"
 ```

Demo 中也是通过这个方式来兼容iOS7的。

如果不使用 Pod，你可以直接下载 [CYLTableViewRowAction](https://github.com/ChenYilong/CYLTableViewRowAction) 将里面的文件夹拖拽到项目中就可以了，不兼容 iOS7 的问题就解决了。


在使用中有任何问题都可以到[我们的官方论坛](https://forum.leancloud.cn/c/jing-xuan-faq)提问题，会有专业工程师回复，平均响应时间在24小时内。
