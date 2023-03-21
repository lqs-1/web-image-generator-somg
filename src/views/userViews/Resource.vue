<template>
  <div class="file_list">
    <el-button type="success" class="queryButton" @click="queryByName">资源查询</el-button>
    <el-input v-model="username" placeholder="请输入用户名" class="queryUserName"></el-input>
    <el-table
        :data="fileList"
        height="700"
        style="width: 100%">
      <el-table-column
          label="文件编号"
          width="80"
          align="center">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.id }}</span>
        </template>
      </el-table-column>

      <el-table-column
          label="所属用户 "
          width="80"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.userName }}</el-tag>
          </div>
        </template>
      </el-table-column>

      <el-table-column
          label="网络地址"
          width="700"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.file }}</el-tag>
          </div>
        </template>
      </el-table-column>


      <el-table-column
          label="文件类型"
          width="500"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.fileType }}</el-tag>
          </div>
        </template>
      </el-table-column>


      <el-table-column
          label="操作"
          width="250"
          align="center">
        <template slot-scope="scope">
          <el-button
              size="mini"
              v-clipboard:copy="scope.row.file"
              v-clipboard:success="onCopy">
            复制
          </el-button>

          <el-button
              size="mini"
              @click="showFile(scope.$index, scope.row)">
            查看
          </el-button>

          <el-button
              size="mini"
              type="danger"
              :loading="deleteLoading"
              @click="handleDelete(scope.$index, scope.row)">删除
          </el-button>
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
  name: "Resource",
  data() {
    return {
      fileList: [],
      username:"",

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

  created() {
    window.document.title = "整站资源"
    this.changeCurrentPageHandler(this.pagination.currentPage)
  },

  methods: {

    changeCurrentPageHandler(currentPage) {
      this.httpRequest.get("storage/superAdminAllFilePage?page=" + currentPage +
          "&limit=" + this.pagination.pageSize +
          "&orderFiled=id" + "&username=" + this.username +
          "&orderType=1")
          .then(response => {
            // console.log(response)
            this.pagination.currentPage = response.data.allFileList.currentPage
            this.pagination.pageSize = response.data.allFileList.pageSize
            this.pagination.total = response.data.allFileList.totalSize
            this.pagination.totalPage = response.data.allFileList.totalPage
            this.fileList = response.data.allFileList.resultList
          })
    },

    queryByName() {
      this.changeCurrentPageHandler(1)
    },


    handleDelete(index, data) {
      this.deleteLoading = true
      this.httpRequest.post("storage/deleteFile", {"id": data.id, "file": data.file}).then(response => {
        this.changeCurrentPageHandler(1)
      })
      this.deleteLoading = false
    },

    // 复制消息提示
    onCopy(){
      this.$message.success("Copy Success")
    },


    showFile(index, data){
      location.href=data.file
    },

  }


}
</script>

<style scoped>
.queryUserName {
  width: 15%;
  position: absolute;
  right: 50px;
}
</style>
