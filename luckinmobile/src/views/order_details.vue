<template>
  <div>
    <!-- 订单详情页 -->
    <header id="header" class="mui-bar mui-bar-nav">
			<router-link to="/order" class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></router-link>
			<h1 class="mui-title">订单详情</h1>
      <span class="mui-icon mui-icon-bars"></span>
		</header>
    <!-- 内容 -->
    <div class="content">
      <!-- one -->
      <div class="good-luck">
        <h4>{{ordList[0].state}}</h4>
        <p>感谢你的光临 Good Luck!</p>
        <div>
          <button>再来一单</button>
          <button>去评价</button>
        </div>
      </div>
      <!-- two -->
      <div class="address">
        <h5>{{ordList[0].store}}</h5>
        <p>龙华区民治街道民强社区711号优城北区一层大堂</p>
      </div>
      <!-- three -->
      <div class="order">
        <!-- 订单时间 -->
        <div class="ord-time">
          <p>订单：11301478156{{ordList[0].id}}</p>
          <p>{{ordList[0].ltime}}</p>
        </div>
        <!-- 订单详情 -->
        <div class="ord-del">
          <ul>
            <!-- 可多个商品 -->
            <li>
              <div>
                <p>{{ordList[0].lname}}</p>
                <span>&times;1</span>
                <p>￥{{ordList[0].price}}</p>
              </div>
              <h5>大师咖啡</h5>
            </li>
          </ul>
        </div>
        <!-- 订单实付 -->
        <div class="payment">
          <p>共1件商品</p>
          <p>实付<span>￥{{ordList[0].price}}</span></p>
        </div>
      </div>
      <!-- four -->
      <div class="shop-time">
        <p>取餐时间</p>
        <p>{{ordList[0].ltime}}</p>
      </div>
    </div>
    <!-- 重用广告 -->
    <my-advert></my-advert>
  </div>
</template>

<script>
import myAdvert from '../components/advert'

export default {
  // 接父元素传的参数
  props:["id"],
  data(){
    return {
      ordList: [{
        lname:'',
        ltime:'',
        price:'',
        state:'',
        store:''
      }],
    }
  },
  methods: {
    // ajax请求
    loadList(){
      // console.log(this.id);
      this.axios.get('getList',
      {
        params:{ id:this.id }
      }
      ).then(res=>{
        // console.log(res.data.msg);
        var rows = res.data.msg;
        this.ordList = rows;
      })
    }
  },
  components: {
    myAdvert
  },
  created(){
    this.loadList();
  }
}
</script>

<style lang="scss" scoped>
// 重用padding
@mixin lrpadd {
  padding-left: 10px;
  padding-right: 10px;
}

// 头部样式修改
#header {
  background: #fff;
  >a{
    color: #000;
    &:active {
      color: #000;
    }
  }
  >span { position: absolute; right: 12px; }
}

// 内容
.content {
  margin-top: 60px;
  width: 100%; height: auto;
  // one
  >.good-luck {
    @include lrpadd;
    margin-top: 10px;
    width: 100%; height: 160px;
    background: #fff;
    display: flex;
    flex-direction: column;
    align-items: center;
    >h4 { margin-top: 45px; 
      margin-bottom: 10px;
    }
    >p { color: #000; font-size: 0.8rem; }
    button {
      padding: 0;
      width: 85px; height: 33px;
      &:last-child {
        color: rgb(158, 158, 231);
        border: 1px solid rgb(158, 158, 231);
      }
    }
    button+button { margin-left: 10px; }
  }
  // two
  >.address {
    @include lrpadd;
    margin-top: 10px;
    width: 100%; height: 65px;
    background: #fff;
    display: flex;
    flex-direction: column;
    justify-content: center;
    >h5 { color: #000; font-size: 1.1rem; font-weight: 500;
      margin-top: 13px;
    }
    >p { color: rgb(163, 163, 163); font-size: 0.8rem; }
  }
  // three
  >.order {
    @include lrpadd;
    margin-top: 10px;
    width: 100%;
    background: #fff;
    // 订单时间
    >.ord-time {
      border-bottom: 1px solid rgb(233, 233, 233);
      height: 36px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      >p { color: #000; margin:0; }
    }
    // 订单详情
    >.ord-del {
      width: 100%;
      >ul {
        width: 100%;
        list-style: none;
        margin: 0;
        padding: 0;
        >li {
          padding-top: 10px;
          padding-bottom: 10px;
          width: 100%; height: 70px;
          margin-bottom: 10px;
          display: flex;
          flex-direction: column;
          justify-content: space-between;
          border-bottom: 1px solid #000;
          >div {
            display: flex;
            justify-content: space-between;
            >p{
              color: #000;
              &:first-child {
                margin-right: 200px;
              }
            }
            >span { font-size: 0.9rem; }
          }
          >h5 { color: #6767b9; }
        }
      }
    }
    // 实付金额
    >.payment {
      width: 100%; height: 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      >p {
        margin: 0;
        margin-top: -10px;
        color: #000;
        >span {
          margin-left: 5px;
          font-size: 1.3rem;
        }
      }
    }
  }
  // four
  >.shop-time {
    @include lrpadd;
    margin-top: 20px;
    margin-bottom: 10px;
    width: 100%; height: 40px;
    background: #fff;
    display: flex;
    justify-content: space-between;
    align-items: center;
    >p {
      margin: 0;
      color: #000;
    }
  }
}
</style>

