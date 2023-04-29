<template>
  <div class="log_list">
    <el-button type="success" class="queryButton" @click="queryLog">日志查询</el-button>
    <el-input v-model="keyword" placeholder="请输入关键字" class="queryLog"></el-input>
    <el-table
        :data="logList"
        height="700"
        style="width: 100%">
      <el-table-column
          label="日志编号"
          width="100"
          align="center">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.id }}</span>
        </template>
      </el-table-column>

      <el-table-column
          label="用户id "
          width="100"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.userId }}</el-tag>
          </div>
        </template>
      </el-table-column>

      <el-table-column
          label="用户名"
          width="300"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.userName }}</el-tag>
          </div>
        </template>
      </el-table-column>

      <el-table-column
          label="时间"
          width="300"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.time }}</el-tag>
          </div>
        </template>
      </el-table-column>

      <el-table-column
          label="服务"
          width="300"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.serverName }}</el-tag>
          </div>
        </template>
      </el-table-column>

      <el-table-column
          label="行为"
          width="300"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{scope.row.action}}</el-tag>
          </div>
        </template>
      </el-table-column>

    </el-table>

    <el-pagination
        @current-change="changeCurrentPageHandler"
        :current-page="pagination.currentPage"
        :page-size="pagination.pageSize"
        :page-count="pagination.totalPage"
        layout="prev, pager, next"
        :total="pagination.total">
    </el-pagination>
  </div>
</template>


<script>
  export default {
    name: "SysLogList",
    data() {
      return {
        logList:[],
        keyword:"",

        pagination: {
          // 每页多找个
          pageSize: 10,
          // 总页数
          totalPage: 0,
          // 获取页码
          activePage: 0,
          // 总条数
          total: 0,
          // 当前页
          currentPage: 1,
        }
      }
    },

    mounted() {

    },

    created() {
      window.document.title = "系统日志"
      this.changeCurrentPageHandler(this.pagination.currentPage)
    },

    methods: {

      changeCurrentPageHandler(currentPage) {
        this.httpRequest.get("sysLog/logPage?page=" + currentPage +
            "&limit=" + this.pagination.pageSize +
            "&orderFiled=id" + "&keyword=" + this.keyword +
            "&orderType=1")
            .then(response => {
              // console.log(response)
              this.pagination.currentPage = response.data.logList.currentPage
              this.pagination.pageSize = response.data.logList.pageSize
              this.pagination.total = response.data.logList.totalSize
              this.pagination.totalPage = response.data.logList.totalPage
              this.logList = response.data.logList.resultList
            })
      },

      queryLog() {
        this.changeCurrentPageHandler(1)
      },

    }


  }
</script>

<style scoped>
.queryLog {
  width: 15%;
  position: absolute;
  right: 50px;
}
</style>
