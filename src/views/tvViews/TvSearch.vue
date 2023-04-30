<template>
  <div>
    <center>
      <div style="height: 5vh; width: 40%">
        <el-input placeholder="请输入影视名" v-model="searchKey" clearable @clear="clearListAndKey">
          <el-button  :loading="isResponse" slot="append" icon="el-icon-search" @click="getGoodsList"></el-button>
        </el-input>
      </div>
    </center>

    <div style="width: 100%; height: 80vh;  margin:0 auto; overflow: auto;word-wrap:break-word;word-break:break-all">
      <div style="background-color: #F0DAD2;margin: 20px 20px auto; width: 180px; height: 300px; float: left; overflow: auto;word-wrap:break-word;word-break:break-all; border-radius:10px"  v-for="(tv,index) in tvList"  :key="index">
        <a :href="tv.play_link" target="_blank" style="text-decoration: none"><img :src="tv.img_link" style="width: 100%; height: 80%"></a>
        <center><strong>{{tv.title}}</strong></center>
      </div>
    </div>




  </div>
</template>


<script>
  export default {
    name: "TvSearch",
    data() {
      return {
        searchKey: "",
        isResponse: false,

        tvList: []

      }
    },

    mounted() {
    },

    created() {
      window.document.title = "影视搜索"

    },

    methods: {

      getGoodsList(){
        this.tvList=[]
        this.isResponse = true

        this.chart.get("/play/searchMovies?searchKey=" + this.searchKey)
            .then(resp => {
              if (resp.data.code > 10000 && resp.data.code < 20000){
                this.$message.success(resp.data.msg)
                this.tvList = resp.data.result_list
              }else {
                this.$message.error(resp.data.msg)
              }
            })
        this.isResponse = false
      },

      clearListAndKey(){
        this.tvList = []
        this.searchKey = ""
      },

    }


  }
</script>

<style scoped>

div::-webkit-scrollbar {
  width: 0;
}

</style>
