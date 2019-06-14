<template>
  <div>
    <!-- 菜单 -->
    <mt-header title="选择咖啡和小食"></mt-header>
    <!-- 海报 -->
    <div class="menu-banner">
      <img :src="bgAdv">
    </div>
    <!-- 菜单 -->
    <div class="my-menu">
      <!-- 菜单左侧分区 -->
      <div class="my-menu-name">
        <ul>
          <li v-for="(item,index) of menuList" :key="index" :class="{active:isActive==index}" @click="change(index)">
            {{item}}
          </li>
        </ul>
      </div>
      <!-- 菜单右侧显示所有内容 -->
      <div class="my-menu-cont">
        <ul v-for="(item,index) of menuList" :key="index">
          <!-- 分类标题 -->
          <p>{{menuList[index]}}</p>
          <li v-for="(eitem,eindex) of mcontList" :key="eindex" v-show="eitem.cofSty==index">
            <img :src="cofImg" @click="imgDetails">
            <h4>{{eitem.cofName}}</h4>
            <span>{{eitem.cofEng}}</span>
            <p>￥{{eitem.cofPri}}</p>
            <button :data-count="eindex" @click="addShop($event)">+</button>
          </li>
        </ul>
      </div>
    </div>
    <!-- 底部占位 -->
    <div class="low-fot"></div>
    <!-- 遮罩层 -->
    <div class="cof-mask">
      <div>
        <img src="http://127.0.0.1:3000/img/coffee.jpg">
        <span @click="times">&times;</span>
        <div>
          <p>规格</p>
          <span>Lorem ipsum dolor sit amet consectetur 
            adipisicing elit.</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  data() {
    return {
      bgAdv: [ 'http://127.0.0.1:3000/img/bg-adver.jpg' ],
      isActive: 0,
      menuList: [
        '人气Top','大师咖啡','小鹿茶',
        '瑞纳冰','鲜榨果蔬汁','经典饮品',
        'BOSS午餐','健康轻食','幸运小食'
      ],
      mcontList: [
        // 第一种
        { cofName: '橘金气泡美式', cofEng: 'Mandarine Soda Americano', cofPri: '24', cofSty: 0 },
        { cofName: '卡布奇诺瑞纳冰', cofEng: 'Cappuccino Exfreezo', cofPri: '27', cofSty: 0 },
        // 第二种
        { cofName: '拿铁', cofEng: 'Latte', cofPri: '24', cofSty: 1 },
        { cofName: '香草', cofEng: 'Vanilla Latte', cofPri: '27', cofSty: 1 },
        { cofName: '焦糖拿铁', cofEng: 'Caramel Latte', cofPri: '27', cofSty: 1 },
        // 第三种
        { cofName: '桃桃芝士红宝石茶', cofEng: 'Peach Cheese Ruby Tea', cofPri: '27', cofSty: 2 },
        { cofName: '桃桃芝士红宝石茶', cofEng: 'Peach Cheese Ruby Tea', cofPri: '27', cofSty: 2 },
        { cofName: '桃桃芝士红宝石茶', cofEng: 'Peach Cheese Ruby Tea', cofPri: '27', cofSty: 2 },
        // 第四种
        { cofName: '小雪荔枝瑞纳冰', cofEng: 'Lychee Exfreezo', cofPri: '27', cofSty: 3 },
        { cofName: '小雪荔枝瑞纳冰', cofEng: 'Lychee Exfreezo', cofPri: '27', cofSty: 3 },
        // 第五种
        { cofName: 'NFC鲜榨橙汁', cofEng: 'NFC Fresh Orange Juice', cofPri: '24', cofSty: 4 },
        { cofName: 'NFC鲜榨橙汁', cofEng: 'NFC Fresh Orange Juice', cofPri: '24', cofSty: 4 },
        { cofName: 'NFC鲜榨橙汁', cofEng: 'NFC Fresh Orange Juice', cofPri: '24', cofSty: 4 },
        // 第六种
        { cofName: '石榴蔓越莓苏打水', cofEng: 'Pomegranate Cranberry Soda', cofPri: '21', cofSty: 5 },
        { cofName: '石榴蔓越莓苏打水', cofEng: 'Pomegranate Cranberry Soda', cofPri: '21', cofSty: 5 },
        // 第七种
        { cofName: '夏日柠檬风味鸡肉沙拉', cofEng: 'Lemon Flavored Chicken', cofPri: '38', cofSty: 6 },
        // 第八种
        { cofName: '京味烤鸭鲜蔬卷', cofEng: 'Duck & Vegetable Wrap', cofPri: '15', cofSty: 7 },
        { cofName: '京味烤鸭鲜蔬卷', cofEng: 'Duck & Vegetable Wrap', cofPri: '15', cofSty: 7 },
        // 第九种
        { cofName: 'Beatz冻干黄桃脆片', cofEng: 'Beatz Freeze Dried Peach', cofPri: '13', cofSty: 8 },
        { cofName: 'Beatz冻干黄桃脆片', cofEng: 'Beatz Freeze Dried Peach', cofPri: '13', cofSty: 8 },
      ],
      cofImg: 'http://127.0.0.1:3000/img/coffee-sm.jpg'
    }
  },
  methods: {
    // 添加购物车
    addShop(e){
      var num = e.target.dataset.count;
      // console.log(this.mcontList[num].cofName,this.mcontList[num].cofEng,this.mcontList[num].cofPri);
      var url = "http://127.0.0.1:3000/addCart";
      var cofName = this.mcontList[num].cofName;
      var cofEng = this.mcontList[num].cofEng;
      var cofPri = this.mcontList[num].cofPri;
      var uid = sessionStorage.getItem("uid");

      url = url.trim();
      var obj = {
        uid,
        cofName,
        cofEng,
        cofPri,
      }
      if(uid) {
        this.$messagebox.confirm(`确认购买${cofName}吗？`).
          then(action=>{
            this.axios.get(url,{params:obj}).then(res=>{
              if(res.data.code==1){
                this.$toast("添加成功");
                console.log('添加成功')
              }else{
                // this.$toast("请先登录");
                console.log(res)
              }
            })
          }).catch(result=>{
            console.log('取消')
          });
      }else {
        this.$toast("请先登录");
      }
    },
    change(index){
      this.isActive = index;
    },
    // 图片点击
    imgDetails(){
      var mask = document.querySelector('.cof-mask');
      mask.style.display = 'flex';
    },
    times(){
      var mask = document.querySelector('.cof-mask');
      mask.style.display = 'none';
    }
  },
  mounted(){
    window.addEventListener('scroll',function(){
      var top = document.documentElement.scrollTop || document.body.scrollTop || window.pageYOffset
      
    })
  }
}
</script>

<style scoped lang="scss">

/* 头部 */
.mint-header {
  width: 100%;
  position: fixed;
  background: #fff;
  color: #000;
  font-size: 1rem;
  z-index: 999;
}

/* 海报 */
.menu-banner {
  position: fixed;
  top: 40px;
  z-index: 999;
  width: 100%; height: 135px;
  >img {
    width: 100%;
  }
}

/* 菜单 */
.my-menu {
  width: 100%; height: auto;
  // 左侧标题
  // 清除子元素浮动
  overflow: hidden;
  background: #f7f7f7;
  >.my-menu-name {
    top: 175px;
    position: fixed;
    &::before {
      content: '';
      display: table;
    }
    width: 30%; height: auto;
    background: #f7f7f7;
    // 选中状态类
    .active {
      color: #000;
      background: #fff;
    }
    >ul {
      margin: 0; padding: 0;
      width: 100%; list-style: none;
      >li {
        width: 100%; height: 40px;
        line-height: 40px;
        text-align: center;
        color: rgb(173, 173, 173);
        font-family: '幼圆';
        font-size: 0.9rem; font-weight: bold;
      }
      >li+li {
        border-top: 1px solid rgb(236, 236, 236);
      }
    }
  }
  // 右侧内容
  >.my-menu-cont {
    position: relative;
    top: 175px;
    margin-bottom: 173px;
    float: right;
    width: 70%; height: auto;
    background: #fff;
    >ul {
      position: relative;
      margin: 0; padding: 0;
      padding-left: 10px;
      padding-right: 10px;
      padding-bottom: 22px;
      margin-bottom: -7px;
      width: 100%; height: auto;
      list-style: none;
      >p {
        margin: 0;
        line-height: 36px;
        color: #000; font-weight: bold;
      }
      >li {
        margin-bottom: 10px;
        width: 100%; height: 80px;
        border-bottom: 1px solid rgb(240, 240, 240);
        position: relative;
        >img {
          float: left;
          margin-right: 8px;
          width: 70px; height: 70px;
          border-radius: 10px;
        }
        >h4 {
          margin: 0;
          font-size: 0.9rem;
        }
        >span { font-size: 0.2rem; color: rgb(148, 148, 148); }
        >p {
          margin-top: 15px; color: #000;
          font-size: 1rem;
        }
        >button {
          position: absolute;
          bottom: 5px; right: 5px;
          padding: 1px 6px;
          background: #7e69f3;
          border-radius: 50%;
          border: none;
          color: #fff;
        }
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

// 遮罩层
.cof-mask {
  display: none;
  width: 100%; height: 100%;
  background: rgba(26, 26, 26,0.5);
  position: fixed;
  top: 0; left: 0;
  z-index: 1111;
  // display: flex;
  justify-content: center;
  align-items: center;
  >div {
    width: 320px; height: 320px;
    background: rgb(255, 255, 255);
    border-radius: 5px;
    position: relative;
    // x
    >span {
      display: block;
      width: 20px; height: 20px;
      text-align: center;
      border: 1px solid rgb(194, 194, 194);
      color: rgb(194, 194, 194);
      border-radius: 50%;
      font-size: 1.2rem;
      line-height: 19px;
      float: right;
      position: absolute;
      top: 10px; right: 10px;
    }
    >img {
      width: 100%;
    }
    >div {
      padding-left: 10px;
      padding-right: 10px;
      width: 100%; height: auto;
      >p {
        font-size: 0.8rem;
        color: #000;
        padding-top: 17px;
        padding-bottom: 17px;
        border-bottom: 1px solid rgb(233, 233, 233);
      }
      >span {
        width: 100%;
      }
    }
  }
}
</style>
