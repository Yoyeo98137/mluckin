<template>
  <div id="adv">
    <!-- 广告 -->
    <img :src="advert">
  </div>
</template>

<script>
export default {
  data() {
    return {
      advert: [ 'http://127.0.0.1:3000/img/adver.jpg' ]
    }
  }
}
</script>

<style scoped>
#adv {
  margin-top: 5px;
  width: 100%; height: 90px;
}
img {
  width: 100%;
}
</style>


