<template>
  <div>

    <el-table
        :data="newsList"
        height="800"
        style="width: 100%">
      <el-table-column
          label="新闻标题"
          width="1000"
          align="center">
        <template slot-scope="scope">
          <a :href="scope.row.link"  target="_blank" style="text-decoration: none"><el-tag size="medium">{{ scope.row.title }}</el-tag></a>
        </template>
      </el-table-column>
      <el-table-column
          label="操作"
          width="500"
          align="center">
        <template slot-scope="scope">
          <el-button
              size="mini"
              @click="toShowNews(scope.$index, scope.row)">去看新闻
          </el-button>
        </template>
      </el-table-column>
    </el-table>

  </div>
</template>


<script>
  export default {
    name: "CnTouTiaoNews",
    data() {
      return {
        newsList:[]
      }
    },

    mounted() {

    },

    created() {
      window.document.title = "头条热点要闻"
      this.requestNewsList()
    },

    methods: {

      requestNewsList(){
        this.chart.get("/news/cnTouTiaoNews")
            .then(resp =>{
              this.newsList = resp.data.result_list
            })
      },



      toShowNews(index, data) {
        location.href = data.link
      },

    }


  }
</script>

<style scoped>

</style>
