# mluckin
仿瑞幸咖啡app 移动端页面 Vue
## 技术栈
Vue.js(脚手架、vue-router、axios) + Scss + Mint-ui + MUI + Node.js + MySQL<br>
Node.js > 8<br>
Vue 3.7.0
## 运行项目
    git clone https://github.com/Yoyeo98137/mluckin.git
    cd mluckin
    cd luck_mserve  // 切换后端文件夹下载后端依赖
    npm install
    cd ..
    cd luckinmobile  // 切换前端文件夹下载前端依赖
    npm install
    // 先打开服务器还有mysql(本人用的xampp)
    // 需要先导入数据库，luck_mserve下的mluck.sql文件
    // 服务器端口3000
    npm run serve
    访问 http://localhost:8080
    // 用户登录  tom 456789/Arser 123456
## 功能实现
√ 轮播图、组件复用<br>
√ 菜单页选项卡切换、点击商品右下角 + 号添加购物车<br>
√ 订单页选项卡切换，筛选全部、未完成、已完成状态的订单显示，点击指定订单跳转指定订单详情页<br>
√ 购物车页猜你喜欢随机显示三个商品信息，点击换一批再次随机显示不同商品，点击去喝一杯跳转菜单页<br>
√ 购物车页点击单选框计算商品合计价格，当商品数量为1时点击 - 号删除指定商品<br>
√ 用户页表单验证、服务器用session保存用户id<br>
√ 用户页利用webStorage保存(使用了单次会话保存)指定用户凭证，让其他页面能够对指定用户的数据进行查询和操作<br>
√ 服务器cors解决跨域<br>
× 菜单页监听商品滚动位置并执行选项卡切换<br>
× 购物车商品数量加减、支付功能<br>
× 猜你喜欢随机显示的商品没有实现去重
## 制作目的
加深常用功能购物车的做法实践<br>
提升移动端页面制作能力<br>
强化Vue开发、组件化开发理念
## 制作时间
2019年3月
