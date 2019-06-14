<template>
  <div>
    <!-- 用户模块 -->
    <!-- 用户未登录时 -->
    <div class="user-login" v-show="isLogin==0">
      <h4>请登录</h4>
      <input v-model="uname" type="text" placeholder="请输入账号">
      <input v-model="upwd" type="password" placeholder="请输入密码">
      <button @click="loadAjax" type="button" class="mui-btn mui-btn-primary mui-btn-outlined">登录</button>
    </div>
    <!-- 用户模块顶部 -->
    <div class="user-card" v-show="isLogin==1">
      <div class="user-card-left">
        <img :src="userModel[0].uimg">
        <p>{{uname}}</p>
        <span class="mui-icon mui-icon-arrowright"></span>
      </div>
      <div class="user-card-rig">
        <span class="mui-icon mui-icon-chatbubble"></span>
      </div>
    </div>
    <!-- 用户页列表 -->
    <ul class="mui-table-view" v-show="isLogin==1">
      <li class="mui-table-view-cell" v-for="(item,index) in userList" :key="index">
        <!-- 加伪类放图片 -->
        <router-link to="/" class="mui-navigate-right">{{item.ucont}}</router-link>
      </li>
    </ul>
    <!-- 广告 -->
    <my-advert v-show="isLogin==1"></my-advert>
  </div>
</template>

<script>
import myAdvert from '../components/advert'

export default {
  data() {
    return {
      uname: '',
      upwd: '',
      uimg: '',
      isLogin: 0,
      userList: [
        // 放伪类图片
        {upic: '',ucont: '咖啡钱包'},
        {upic: '',ucont: '个人资料'},
        {upic: '',ucont: '优惠券'},
        {upic: '',ucont: '兑换优惠'},
        {upic: '',ucont: '发票管理'},
        {upic: '',ucont: '帮助反馈'}
      ],
      userModel: [{ uimg: 'http://127.0.0.1:3000/img/user1.jpg' }],
      ugo: '&gt'
    }
  },
  methods: {
    loadAjax(){
      var n = this.uname;
      var p = this.upwd;
      //3:创建二个正则表达式
      var nreg = /^[a-zA-Z0-9]{3,10}$/;
      var preg = /^[a-zA-Z0-9]{3,8}$/;
      //4:判断用户名格式不正确 提示出错
      if(!nreg.test(n)){
         this.$toast("用户名格式不正确");
         return;
      }
      //5:判断密码格式不正确  提示出错
      if(!preg.test(p)){
         this.$toast("密码格式不正确");
         return;
      }

      var url = `http://127.0.0.1:3000/login`;
      var obj = {uname:n,upwd:p}

      this.axios.get(url,{params:obj}).then(res=>{
        // console.log(res.data.msg)
        if(res.data.code == 1){
          console.log(res.data.msg[0].uid);
          // 接收session保留的用户uid
          console.log(res.data.uid);
          sessionStorage.setItem("uid",res.data.uid);
          this.isLogin = 1;
        }else{
          this.$messagebox("消息",
          res.data.msg);
        }
      })
    }
  },
  created() {
    // console.log(this.isLogin)
    // var uid = sessionStorage.getItem("uid");

    // if(uid){
    //   this.isLogin = 1
    // }else{
    //   this.isLogin = 0
    // }
  },
  components: {
    myAdvert
  }
}
</script>

<style scoped lang="scss">
// 用户未登录时 
.user-login {
  margin-top: 200px;
  margin-bottom: 30px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  >h4 {
    margin-bottom: 26px;
  }
  >input {
    width: 80%;
  }
  >button { width: 18%; }
}

// 用户模块顶部
.user-card {
  // display: none;
  position: relative;
  &::before {
    content: '';
    display: table;
  }
  width: 100%; height: 140px;
  background: #5d4138;
  >.user-card-left {
    margin-top: 30px;
    margin-left: 26px;
    width: auto; height: 80px;
    >img {
      width: 80px; height: inherit;
      border-radius: 50%;
      float: left;
    }
    >p {
      margin-left: 12px;
      line-height: 80px;
      color: #fff; font-size: 0.8rem;
      float: left;
    }
    >span {
      color: rgba(167, 167, 167,0.6);
      margin-right: 36px;
      line-height: 80px;
      float: right;
      cursor: pointer;
    }
  }
  >.user-card-rig {
    position: absolute;
    top: 10px; right: 10px;
    width: 30px; height: 30px;
    color: #fff;
  }
}

// 用户页列表
.mui-table-view {
  // display: none;
  &::after {
    background-color: transparent;
  }
  background: transparent;
  >.mui-table-view-cell {
    background: #fff;
    >a { font-size: 0.8rem; color: rgb(146, 146, 146); }
    &:nth-child(5){
      &::after {
        background: transparent;
      }
    }
    &:last-child{
      margin-top: 20px;
    }
  }
}
</style>


