# STONews

AppleId: appledev@bankorus.com   
PassWord: Dev4#bankorus 

管理AppleId 去添加验证手机  https://appleid.apple.com/account/manage 

Identifiers:
Bankorus SecurityTokenRatings Test	      com.Bankoruc.SecurityTokenRatingsTest

Bankorus STO Rating	                      com.Bankoruc.SecurityTokenRatings	


Profiles: 
Bankorus STO Rating Distribution	      iOS	App Store	

SecurityTokenRatings Test	              iOS	Development	

1.  https://developer.apple.com/account 进行登录  
2.  点击 Certificates, Identifiers & Profiles
3.  下载对应的Certificates 和 Profiles 进行测试或者发布


后台配置:
采用Wordpress作为后台
测试环境：http://10.3.9.116:8080/wp-login.php
测试账号: admin      密码: 7csrgNugdhChPxIQNG

正式环境：https://app.securitytokenratings.info/wp-login.php
正式账号: stadmin    密码: Q62n%s2B7ue!T$@^fsy



post分为不同的categories;
如需添加对应的post, 应先为post分配不同的categories, 然后在wordpress管理后台按照对应的格式编辑post  即可在app中进行展示;
格式在wordpress管理后台查看, 或者对app进行抓包.

Projects: 父category为Projects 子category分为Listed和Unlisted(已发布项目 和 未发布项目)

New: 父category为News, 如果是Banner图, 那么子category为Banner

Community: Project Discussion Area:为所有category为Projects的合集   Topic Discussion Area:category为 Topic Discussion Area 

Settings: 国际化支持, 目前仅可支持中英选择, 可在项目中Localizable.strings 和 InfoPlist.strings中添加支持语言


