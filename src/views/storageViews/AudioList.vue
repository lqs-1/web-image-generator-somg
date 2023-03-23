<template>
  <div class="file_list">

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
          label="上传时间"
          width="150"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.uploadTime }}</el-tag>
          </div>
        </template>
      </el-table-column>

      <el-table-column
          label="文件名"
          width="150"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.fileName }}</el-tag>
          </div>
        </template>
      </el-table-column>


      <el-table-column
          label="文件类型"
          width="150"
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
  name: "AudioList",
  data() {
    return {
      deleteLoading: false,

      fileList: [],

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
    window.document.title = "音频文件列表"
    this.changeCurrentPageHandler(this.pagination.currentPage)
  },

  methods: {

    changeCurrentPageHandler(currentPage) {
      this.httpRequest.get("storage/allAudioPage?page=" + currentPage +
          "&limit=" + this.pagination.pageSize +
          "&orderFiled=id" +
          "&orderType=1")
          .then(response => {
            // console.log(response)
            this.pagination.currentPage = response.data.audioList.currentPage
            this.pagination.pageSize = response.data.audioList.pageSize
            this.pagination.total = response.data.audioList.totalSize
            this.pagination.totalPage = response.data.audioList.totalPage
            this.fileList = response.data.audioList.resultList
          })
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



</style>
