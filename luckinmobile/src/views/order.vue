<template>
  <div>
    <!-- 订单 -->
    <mt-header title="订单列表"></mt-header>
    <!-- 选项卡 -->
    <div class="order-card">
      <table></table>
      <!-- 选项卡标题 -->
      <ul class="order-card-title">
        <li v-for="(item,index) of otitle" :key="index" @click="titleChange(index)">
          <span :class="{active:isActive==index}">{{item}}</span>
        </li>
      </ul>
      <!-- 选项卡内容 -->
      <ul class="order-card-cont">
        <li v-for="(item,index) of oNcontList" :key="index" @click="runDel(item.id,$event)">
          <!-- head -->
          <div class="card-head">
            <span>订单号</span>:
            <span>11301478156{{item.id}}</span>
            <span>{{item.state}}</span>
          </div>
          <!-- cont -->
          <div class="card-main">
            <div class="card-main-left">
              <h5>{{item.store}}</h5>
              <p>{{item.lname}}</p>
              <span>￥{{item.price}}</span>
            </div>
            <div class="card-main-rig">
              <p>{{item.ltime}}</p>
              <button class="btn-block"><router-link to="/">再来一单</router-link></button>
              <button class="btn-blue">去评价</button>
            </div>
          </div>
        </li>
      </ul>
    </div>
    <!-- 底部占位 -->
    <div class="low-fot"></div>
  </div>
</template>

<script>
// import '../../lib/mui/js/mui'

export default {
  data() {
    return {
      otitle: ['全部','未完成','已完成'],
      isActive: 0,  // 默认第一个选项卡标题为选中状态
      // 包含原始数据的原数组
      ocontList: [],
      // 创建新数组来保存筛选过的数据
      oNcontList: []
    }
  },
  methods: {
    // ajax 请求所有列表详情页
    loadList(){
      var uid = sessionStorage.getItem("uid");
      if(uid) console.log(uid);
      var url =`
        http://127.0.0.1:3000/getAllList
      `;
      // 去除url中的空格
      // url = url.replace(/\s*/g,"");
      url = url.trim();
      console.log(url)
      this.axios.get(url,{
        params:{ uid }
      }).then(res=>{
        // console.log(res.data.msg)
        var rows = res.data.msg;
        console.log(rows);
        this.ocontList = rows;
        this.oNcontList = this.ocontList;
      })
    },
    // 显示当前切换到的title
    titleChange(index){
      this.isActive = index;
      // this.loadList(); 
    },
    // 跳转详情页
    runDel(id,e){
      // console.log(id);
      this.$router.push(`/Details/${id}`);
      // this.$router.push(`/index`);
    }
  },
  created() {
    // 为后续要处理的数组传值
    // this.oNcontList = this.ocontList;
    this.loadList();
  },
  watch: {
    // otitle(){
    //   this.loadList();
    // },
    isActive(e){
      // console.log(this.ocontList);
      
      // console.log(this.oNcontList)
      // var a=[];
      // console.log(e); 0 1 2
      if(e==0){
        // console.log(this.ocontList);
        this.oNcontList = this.ocontList;
      }else{
        // this.loadList();
        // console.log(this.otitle[e])
        // console.log(this.oNcontList);
        this.oNcontList = [];
        // console.log(this.ocontList);
        this.ocontList.forEach((elem,i,arr)=>{
          // console.log(e);
          // if(elem.state=="未完成"){
          //   this.oNcontList.push(elem)
          //   console.log(this.oNcontList);
          // }else if(elem.state=="已完成"){
          //   console.log(2);
          // }
          if(elem.state==this.otitle[e]){
            // console.log(this.otitle[e]);
            this.oNcontList.push(elem);
          }
        });
        // console.log(this.oNcontList);
        // this.oNcontList = this.ocontList;
        // 切换到未完成时ocon里也只剩下未完成的部分，所以再转到第三个已完成时返回空数组
        // console.log(this.ocontList);
        // this.loadList();
      }
      // console.log(this.ocontList);
    }
  }
}
</script>

<style scoped lang="scss">
/* 头部 */
.mint-header {
  width: 100%;
  position: fixed;
  z-index: 999;
  background: #fff;
  color: #000;
  font-size: 1rem;
}

/* 选项卡 */
.order-card {
  // 标题
  >.order-card-title {
    position: fixed;
    z-index: 999;
    top: 40px;
    width: 100%; height: 42px;
    background: #fff;
    margin: 0;
    padding: 0;
    border-top: 1px solid #efefef;
    list-style: none;
    display: flex;
    justify-content: space-around;
    >li {
      height: 42px;
      font-size: 0.9rem;
      float: left;
      >span { line-height: 42px; text-align: center; }
    }
  }
  // 内容
  >.order-card-cont {
    margin:0; padding: 0;
    margin-top: 90px;
    list-style: none;
    >li {
      width: 100%; height: 110px;
      margin-bottom: 8px;
      padding-left: 12px; padding-right: 12px;
      background: #fff;
      // ...
      >.card-head {
        width: 100%; height: 30px;
        border-bottom: 1px solid rgb(197, 197, 197);
        font-size: 0.6rem;
        color: #000;
        line-height: 30px;
        >span {
          &:last-child {
            float: right;
          }
        }
      }
      // ...
      >.card-main {
        width: 100%; height: 80px;
        >.card-main-left {
          width: 50%; height: inherit;
          float: left;
          >h5 { margin-top: 10px; color: #000; font-size: 1rem; }
          >p { color: rgb(68, 68, 68); font-size: 0.7rem; margin: 0;}
          >span { font-size: 0.8rem; }
        }
        >.card-main-rig {
          width: 50%; height: inherit;
          float: left;
          >p { float: right; margin-top: 8px; }
          >button { border-radius: 3px; background: transparent; cursor: pointer; 
            >a {
              color: rgb(75, 75, 75);
            }
          }
          >.btn-block {
            margin-left: 20px; margin-right: 5px;
            border: 1px solid rgb(151, 151, 151);
          }
          >.btn-blue {
            color: rgb(7, 135, 185);
            border: 1px solid rgb(7, 135, 185);
          }
        }
      }
    }
  }
  // 选中状态
  .active {
    color: rgb(7, 135, 185);
    padding-bottom: 5px;
    border-bottom: 2px solid rgb(7, 135, 185);
  }
}

// 给原本fixed布局的底部导航栏占位
.low-fot {
  position: relative;
  bottom: 0;
  width: 100%; height: 54px;
}
</style>