<template>
  <div>
    <!-- 首页 -->
    <div id="top-swipe">
      <mt-swipe :auto="4000" :show-indicators="true">
      <mt-swipe-item v-for="(item,index) of indexBanner" :key="index">
        <img :src="item">
        <!-- <img src="img/1.jpg" /> -->
        <!-- 右上角扫一扫 -->
        <span class="mui-icon-extra mui-icon-extra-sweep"></span>
      </mt-swipe-item>
      </mt-swipe>
    </div>
    <!-- 首页列表 -->
    <ul class="mui-table-view">
      <li class="mui-table-view-cell mui-media" v-for="(item,index) of indexList" :key="index">
        <router-link to="javascript:;">
          <img class="mui-media-object mui-pull-right" :src="item.limg">
          <div class="mui-media-body">
            <span>{{item.lsp}}</span>
            <p class='mui-ellipsis'>{{item.lp}}</p>
          </div>
        </router-link>
      </li>
    </ul>
    <!-- 广告 -->
    <my-advert></my-advert>
    <!-- 底部占位 -->
    <div class="low-fot"></div>
  </div>
</template>

<script>
import myAdvert from '../components/advert'

export default {
  data(){
    return {
      selected: '首页',
      indexBanner: [
        'http://127.0.0.1:3000/img/banner1.jpg',
        'http://127.0.0.1:3000/img/banner2.jpg',
        'http://127.0.0.1:3000/img/banner3.jpg'
      ],
      indexList: [{
        limg: '',lsp: '优城A座店',lp: '距您682m'
      },{
        limg: '',lsp: '现在下单',lp: 'ORDER NOW'
      },{
        limg: '',lsp: '咖啡钱包',lp: 'COFFEE WALLET'
      },{
        limg: '',lsp: '送他咖啡',lp: 'SEND COFFEE'
      },{
        limg: '',lsp: '企业账户',lp: 'EBTERPRISE ACCOUNT'
      }]
    }
  },
  components: {
    myAdvert,
  }
}
</script>

<style lang="scss" scoped>

// 首页
// 设置轮播高度
#top-swipe>.mint-swipe{
  height: 280px;
  >.mint-swipe-items-wrap {
    >.mint-swipe-item {
      >img { width: 100%; }
    }
  }
}
.mint-swipe-item {
  >span {
    position: absolute;
    top: 20px; right: 23px;
  }
}
// 首页列表
.mui-table-view {
  &::after { display: none; }
  >.mui-table-view-cell {
    height: 56px;
    padding: 11px 16px;
    .mui-media-body {
      font-size: 1rem;
      >.mui-ellipsis {
        font-size: 0.4rem;
        color: rgb(185, 185, 185);
      }
    }
    &:last-child{
      &::after {
      display: none;
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

