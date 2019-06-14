<template>
  <div>
    <!-- 购物车页面 -->
    <mt-header title="购物车"></mt-header>
    <!-- 购物车中没有商品时 -->
    <div class="shop-emp" v-show="carList.length==0">
      <div>
        <img src="http://127.0.0.1:3000/img/shopcar.jpg">
        <p>你的购物车有点寂寞</p>
        <button><router-link to="/">去喝一杯</router-link></button>
      </div>
    </div>
    <!-- 重用广告 -->
    <my-advert v-show="carList.length>0"></my-advert>
    <!-- 购物车存在商品时 -->
    <div class="shop-cart">
      <!-- 购物车中的商品列表 -->
      <ul v-show="carList.length>0">
        <li v-for="(item,index) of carList" :key="index" @change="sCale(index,$event)" :data-price="item.price">
          <input type="checkbox">
          <div class="shop-item">
            <h4>{{item.cname}}</h4>
            <span>{{item.ceng}}</span>
          </div>
          <p>￥{{item.price}}</p>
          <button @click="shopSub" :data-id="item.id">-</button>
          <span>{{item.count}}</span>
          <button @click="shopAdd($event)" :data-count="item.count">+</button>
        </li>
      </ul>
    </div>
    <!-- 购物车金额结算 -->
    <div class="shop-calc" v-show="carList.length>0">
      <div>
        <span>应付合计</span>
        <p>￥{{shopCalc}}</p>
      </div>
      <button @click="buyNow">去结算</button>
    </div>
    <!-- 随机显示商品 -->
    <div class="shop-random">
      <span>猜你喜欢</span>
      <!-- 点击函数不生效？ -->
      <span @click="loadRan">
        <span class="mui-icon mui-icon-refreshempty"></span>
        换一批
      </span>
      <ul>
        <!-- <li>{{newDomList[0].cofName}}</li>
        <li>{{newDomList[1]}}</li>
        <li>{{newDomList[2]}}</li> -->
        <li>
          <img :src="cofImg">
          <h4>{{newDomList[0].cofName}}</h4>
          <span>{{newDomList[0].cofEng}}</span>
          <p>￥{{newDomList[0].cofPri}}</p>
          <button>+</button>
        </li>
        <li>
          <img :src="cofImg">
          <h4>{{newDomList[1].cofName}}</h4>
          <span>{{newDomList[1].cofEng}}</span>
          <p>￥{{newDomList[1].cofPri}}</p>
          <button>+</button>
        </li>
        <li>
          <img :src="cofImg">
          <h4>{{newDomList[2].cofName}}</h4>
          <span>{{newDomList[2].cofEng}}</span>
          <p>￥{{newDomList[2].cofPri}}</p>
          <button>+</button>
        </li>
      </ul>
    </div>
    <!-- 底部占位 -->
    <div class="low-fot"></div>
  </div>
</template>

<script>
import myAdvert from '../components/advert'

export default {
  data() {
    return {
      // 原商品数组
      ranDomList: [
        // 第一种
        { cofName: '橘金气泡美式', cofEng: 'Mandarine Soda Americano', cofPri: '24', cofSty: 0 },
        { cofName: '卡布奇诺瑞纳冰', cofEng: 'Cappuccino Exfreezo', cofPri: '27', cofSty: 0 },
        // 第二种
        { cofName: '拿铁', cofEng: 'Latte', cofPri: '24', cofSty: 1 },
        { cofName: '香草', cofEng: 'Vanilla Latte', cofPri: '27', cofSty: 1 },
        { cofName: '焦糖拿铁', cofEng: 'Caramel Latte', cofPri: '27', cofSty: 1 },
        // 第三种
        { cofName: '桃桃芝士红宝石茶', cofEng: 'Peach Cheese Ruby Tea', cofPri: '27', cofSty: 2 },
        { cofName: '桃桃芝士绿宝石茶', cofEng: 'Peach Cheese Ruby Tea', cofPri: '27', cofSty: 2 },
        { cofName: '桃桃芝士黄宝石茶', cofEng: 'Peach Cheese Ruby Tea', cofPri: '27', cofSty: 2 },
        // 第四种
        { cofName: '小雪荔枝瑞纳冰', cofEng: 'Lychee Exfreezo', cofPri: '27', cofSty: 3 },
        { cofName: '小雪柚子瑞纳冰', cofEng: 'Lychee Exfreezo', cofPri: '27', cofSty: 3 },
        // 第五种
        { cofName: 'NFC鲜榨橙汁', cofEng: 'NFC Fresh Orange Juice', cofPri: '24', cofSty: 4 },
        { cofName: 'NFC鲜榨西瓜汁', cofEng: 'NFC Fresh Orange Juice', cofPri: '24', cofSty: 4 },
        { cofName: 'NFC鲜榨柠檬汁', cofEng: 'NFC Fresh Orange Juice', cofPri: '24', cofSty: 4 },
        // 第六种
        { cofName: '石榴蔓越莓苏打水', cofEng: 'Pomegranate Cranberry Soda', cofPri: '21', cofSty: 5 },
        // 第七种
        { cofName: '夏日柠檬风味鸡肉沙拉', cofEng: 'Lemon Flavored Chicken', cofPri: '38', cofSty: 6 },
        // 第八种
        { cofName: '京味烤鸭鲜蔬卷', cofEng: 'Duck & Vegetable Wrap', cofPri: '15', cofSty: 7 },
        { cofName: '京味烤鸭', cofEng: 'Duck & Vegetable', cofPri: '28', cofSty: 7 },
        // 第九种
        { cofName: 'Beatz冻干黄桃脆片', cofEng: 'Beatz Freeze Dried Peach', cofPri: '13', cofSty: 8 },
        { cofName: 'Beatz热干绿桃脆片', cofEng: 'Beatz Freeze Dried Peach', cofPri: '13', cofSty: 8 },
      ],
      // 随机处理后的数组
      newDomList: [],
      // 商品数量
      shopCount: 1,
      // 购物车列表
      carList: [],
      // 商品价格结算
      shopCalc: 0,
      cofImg: 'http://127.0.0.1:3000/img/coffee-sm.jpg'
    }
  },
  methods: {
    // 商品列表单选框勾上后执行
    sCale(i,e){
      // console.log(e.target.dataset.price)
      // console.log(i)
      var cale = document.querySelector('.shop-calc>div>p').innerHTML;
      cale = Number(cale.substr(1));
      cale = this.carList[i].price;
      if(e.target.checked){
        // 获取自定义属性
        // console.log(this.carList[i].price)
        // DOM
        this.shopCalc += cale;
      }else{
        // console.log(this.carList[i].price);
        this.shopCalc -= cale;
      }
    },
    // 去结算
    buyNow(){
      var inp = document.querySelectorAll('.shop-cart>ul>li>input');
      if(this.shopCalc==0){
        this.$toast('请勾选你需要购买的商品')
      }else{
        this.$messagebox.confirm(`确认支付${this.shopCalc}元吗？`).
          then(action=>{
            this.$toast('支付成功！');
            for(var elem of inp){
              elem.checked = false;
            }
            this.shopCalc = 0;
          }).catch(result=>{
            this.$toast('支付取消！');
            for(var elem of inp){
              elem.checked = false;
            }
            this.shopCalc = 0;
          });
      }
    },
    // '换一批'
    reFresh(){
      this.loadRan();
    },
    // 底部商品刷新
    loadRan(){
      // console.log(`111`);
      // 底部推荐商品随机展示
      var arr = [];
      for(var i=0;i<3;i++){
        var index = Math.floor(Math.random(this.ranDomList)*this.ranDomList.length);
        // this.ranDomList.splice(index,1);
        this.newDomList.push(this.ranDomList[index]);
        // console.log(this.newDomList);
      }
      // console.log(arr);
      if(this.newDomList.length<=3)
      this.newDomList.sort((a,b)=>a-b);
      else this.newDomList.splice(0,3)

      console.log(this.newDomList);
      let set = new Set(this.newDomList);
      console.log(set)
    },
    // -
    shopSub(e){
      if(this.shopCount>1){
        this.shopCount--;
      }else{
        this.shopRemove(e);
      }
    },
    // +
    shopAdd(e){
      this.shopCount++;
      console.log(e.target.dataset.count++);
    },
    // 删除单条购物车数据
    shopRemove(e){
      this.$messagebox.confirm("是否删除当前商品?")
        .then(action=>{
          var id = e.target.dataset.id;
          console.log(id)
          var url = `
            http://127.0.0.1:3000/removeCarItem?id=${id}
          `;
          this.axios.get(url).then(result=>{
            if(result.data.code==1){
             this.$toast("删除成功");
             //数据库己经删除成功
             //网页内容显示新内容[删除后];
             this.loadAjax();
             this.$router.push('/shopping');
            }else{
              this.$toast("删除失败");
            }
          })
        }).catch(result=>{
            console.log("取消")
        });
    },
    // ajax请求
    loadAjax(){
      var uid = sessionStorage.getItem("uid");
      // if(uid) console.log(uid);
      var url = `
        http://127.0.0.1:3000/getCart
      `;
      url = url.trim();
      this.axios.get(url,{
        params: {uid}
      }).then(result=>{
        var rows = result.data.msg;
        this.carList = rows;
        // console.log(this.carList);
      })
    }
  },
  created() {
    // 加载随机推荐商品功能
    this.loadRan();
    this.loadAjax();
  },
  components: {
    myAdvert
  }
}
</script>

<style scoped lang="scss">
/* 头部 */
.mint-header {
  background: #fff;
  color: #000;
  font-size: 1rem;
}

/* 当购物车没有商品时 */
.shop-emp {
  // 存在商品时隐藏
  // display: none !important;
  width: 100%; height: 300px;
  display: flex;
  justify-content: center;
  align-items: center;
  >div {
    text-align: center;
    >img {
      width: 80px; height: 80px;
      margin-bottom: 20px;
    }
    >button {
      border: 1px solid #7da7d1;
      >a {
        color: #7da7d1;
        // color: #16af39;
      }
    }
  }
}

// 当购物车存在商品时
.shop-cart {
  >ul {
    margin-top: 3px;
    padding: 0;
    width: 100%; height: auto;
    list-style: none;
    >li {
      padding-left: 10px;
      padding-right: 10px;
      width: 100%; height: 60px;
      display: flex;
      justify-content: space-around;
      align-items: center;
      >input[type='checkbox'] {
        width: 22px; height: 22px;
        margin-right: 8px;
      }
      >.shop-item {
        width: 190px; height: inherit;
        display: flex;
        flex-direction: column;
        justify-content: center;
        >h4 {
          margin: 0;
          font-weight: 500;
          width: inherit;
          overflow: hidden;
          text-overflow:ellipsis;
          white-space: nowrap;
        }
        >span {
          font-size: 0.8rem; color: rgb(148, 148, 148); 
        }
      }
      >p {
        margin: 0;
        margin-right: 10px;
        font-size: 1.3rem;
        color: #000;
      }
      >span { font-size: 1.1rem; color: #5d98c2; 
        margin-left: 7px; margin-right: 7px;
      }
      >button { padding: 2px 8px; 
        background: #83bfeb; color: #fff;
      }
    }
    >li+li { border-top: 1px solid #ccc; }
  }
}

// 购物车商品价格计算模块
.shop-calc {
  padding-left: 15px;
  position: fixed;
  z-index: 999;
  bottom: 54px;
  width: 100%; height: 70px;
  background: #fff;
  border-bottom: 1px solid rgb(231, 231, 231);
  display: flex;
  justify-content: space-between;
  align-items: center;
  >div { width: 200px; 
    display: flex;
  }
  span { font-size: 0.9rem; }
  p { font-size: 1.3rem; color: #000; 
    margin: 0;
    margin-left: 10px;
  }
  >button {
    padding: 0;
    width: 130px; height: inherit;
    font-size: 1.2rem;
    border: none;
    border-radius: 0 !important;
    color: #fff;
    background: #7da6d2;
  }
}

// 随机显示商品
.shop-random {
  margin-top: 40px;
  margin-bottom: 110px;
  width: 100%; height: 180px;
  >span { font-size: 0.8rem; 
    padding-left: 10px;
    padding-right: 10px;
    &:nth-child(2) {
      float: right;
      >.mui-icon {
        font-size: 18px;
      }
    }
  }
  >ul {
    margin-top: 5px;
    display: flex;
    justify-content: space-between;
    padding-left: 10px;
    padding-right: 10px;
    list-style: none;
    width: 100%; height: 100%;
    >li {
      width: 105px; height: 100%;
      position: relative;
      border-radius: 4px;
      background: #ffffff;
      >img {
        border-radius: 4px;
        width: 100%; height: 110px;
      }
      >h4 {
        margin: 0;
        margin-top: 5px;
        font-size: 0.9rem;
        display: block;
        width: 100px;
        overflow: hidden;
        text-overflow:ellipsis;
        white-space: nowrap;
        padding-left: 3px;
        padding-right: 3px;
        color: rgb(78, 78, 78);
      }
      >span { font-size: 0.2rem; color: rgb(148, 148, 148); 
        display: block;
        width: 100px;
        overflow: hidden;
        text-overflow:ellipsis;
        white-space: nowrap;
        padding-left: 3px;
        padding-right: 3px;
      }
      >p {
        margin-left: -3px;
        margin-top: 0px; color: #e47d66;
        font-size: 1rem;
        padding-left: 3px;
        padding-right: 3px;
      }
      >button {
        position: absolute;
        bottom: 3px; right: 3px;
        padding: 1px 6px;
        background: #7e69f3;
        border-radius: 50%;
        border: none;
        color: #fff;
      }
    }
  }
}

// 给原本fixed布局的底部导航栏占位
.low-fot {
  position: relative;
  bottom: 0;
  width: 100%; height: 54px;
}
</style>


