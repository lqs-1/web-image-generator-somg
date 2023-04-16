<template>
  <div>

    <el-table
        :data="newsList"
        height="800"
        style="width: 100%">
      <el-table-column
          label="新闻标题"
          width="800"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">

            <a :href="scope.row.link"  target="_blank" style="text-decoration: none"><el-tag size="medium">{{ scope.row.title }}</el-tag></a>
          </div>
        </template>
      </el-table-column>

      <el-table-column
          label="要闻时间"
          width="200"
          align="center">
        <template slot-scope="scope">
          <a :href="scope.row.link" style="text-decoration: none"><el-tag size="medium">{{ scope.row.time }}</el-tag></a>
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
    name: "CnPeopleNews",
    data() {
      return {
        newsList:[]
      }
    },

    mounted() {

    },

    created() {
      window.document.title = "人民网滚动要闻"

      this.requestNewsList()
    },

    methods: {

      requestNewsList(){
        this.chart.get("/news/cnPeopleNews")
            .then(resp =>{
              if (resp.data.code == 200){
                this.$message.success(resp.data.msg)
                this.newsList = resp.data.resultList
                this.requestText = ""
              }else {
                this.$message.error(resp.data.msg)
              }
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
