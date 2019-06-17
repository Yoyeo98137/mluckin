<template>
  <nav class="mui-bar mui-bar-tab">
   <!-- <keep-alive>  -->
    <div v-for="(item,index) of navList" :key="index"
     class="mui-tab-item" :class="{'mui-active':isActive==item.lid}"
      @click="loadNav($event,item.lid)" :data-index="index">
      <span class="mui-icon" :class="item.className">
        <span v-show="index==3" class="mui-badge">{{carCount}}</span>
      </span>
      <span class="mui-tab-label">{{item.title}}</span>
    </div>
  </nav>
</template>

<script>
export default {
  data() {
    return {
      carCount: 0,
      isActive: 0,
      navList: [
        {
          lid:0,
          title: '首页',
          path: '/',
          className: 'mui-icon-home'
        },
        {
          lid:1,
          title: '菜单',
          path: '/menu',
          className: 'mui-icon-extra mui-icon-extra-cate'
        },
        {
          lid:2,
          title: '订单',
          path: '/order',
          className: 'mui-icon-email'
        },
        {
          lid:3,
          title: '购物车',
          path: '/shopping',
          className: 'mui-icon-extra mui-icon-extra-cart'
        },
        {
          lid:4,
          title: '我的',
          path: '/user',
          className: 'mui-icon-contact'
        }
      ]
    }
  },
  watch: {
    // $route(to,from){
    //   console.log(to.path)
    // }
  },
  methods: {
    loadNav(e,i){
      // console.log(i);
      // console.log(e.target.dataset.index);
      this.$router.push(`${this.navList[i].path}`);
      // console.log(i);
      // console.log(this.isActive==i);
      this.isActive = i;
      // console.log("aaaaa");
      // console.log(this.isActive);
      this.loadAjax();
    },
    loadAjax(){
      var uid = sessionStorage.getItem("uid");
      var url = `getCart`;
      url = url.trim();
      this.axios.get(url,{
        params: {uid}
      }).then(result=>{
        var rows = result.data.msg;
        // console.log(rows.length);
        this.carCount = rows.length;
      })
    }
  },
  created(){
    this.loadAjax();
  }
}
</script>

<style lang="scss" scoped>
.mui-bar-tab .mui-tab-item.mui-active {
  color: #1f22bb;
}
.mui-bar {
  box-shadow: none;
}
.mui-bar-tab .mui-tab-item {
  padding-top: 4px;
}
</style>


