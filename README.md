# ZjuWebportalLogin 浙江大学网络网页认证python脚本

学校的网页认证在今年(2020)夏天的时候改了，以前只要用curl命令把帐号密码发到认证服务器就可以登录了。但是现在不行了，现在的逻辑是，浏览器对帐号密码进行一定的处理，然后不用post帐号密码，现在直接把加密过的账号密码放在链接上发到认证服务器就可以认证通过了。

所以为了能实现掉线自动认证重新上线，我先是想自己编代码，无奈没有学过js，看代码看的头疼。然后在网上找到一个其他项目，和这个非常像，以我的对认证过程的分析，应该是可以用的，我去掉了需要第三方库，稍微修改了一下就能用了。哈哈哈。

ZS校区认证地址是这个，其他校区的需要修改一下，这个文件的认证地址，和个人账号密码。

如果有需求，寒假期间为了保持自己的电脑在线可以试试这个脚本。

### 在使用之前，请务必修改你的帐号密码，以及登录地址。
![修改登录地址，填写登录帐号](https://github.com/Marerc/ZjuWebportalLogin/blob/main/DomainOrIpLocation.png)

# 普通用法

python3 login.py -doi 10.92.110.107 -u 222222 -p 333333

# 高级用法(仅限linux支持crontab的发行版)

crontab -e 中添加定时语句，定时检验网络是否掉线，网络掉线后重新登录，**地址**需要修改一下的。

> */5 * * * * path/to/your/location/ZjuWebportalLogin/onlineMornitoring.sh 

上面语句的意思是，每5分钟执行这个脚本，这个脚本的作用是：
1. 检测网络是否在线，如果在线不执行任何操作，如果不在线，执行登录脚本。
2. 检测日志文件是否大于1M，如果日志文件大于1M，删除，否则不操作。


参考文章：
	https://blog.csdn.net/qq_41797946/article/details/89417722

