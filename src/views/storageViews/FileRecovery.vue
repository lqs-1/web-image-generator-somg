<template>
  <div>

    <el-button type="success" class="queryButton" @click="queryFile">文件查询</el-button>
    <el-input v-model="key" placeholder="请输入关键字" class="queryFile"></el-input>
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
          label="上传时间"
          width="300"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.uploadTime }}</el-tag>
          </div>
        </template>
      </el-table-column>


      <el-table-column
          label="文件名"
          width="300"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{scope.row.fileName}}</el-tag>
          </div>
        </template>
      </el-table-column>


      <el-table-column
          label="文件类型"
          width="300"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.fileType }}</el-tag>
          </div>
        </template>
      </el-table-column>

      <el-table-column
          label="到期时间"
          width="200"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.expire }}小时</el-tag>
          </div>
        </template>
      </el-table-column>


      <el-table-column
          label="操作"
          width="300"
          align="center">
        <template slot-scope="scope">
          <el-button
              size="mini"
              @click="recoveryFile(scope.$index, scope.row)">恢复
          </el-button>


          <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">彻底删除
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
    name: "FileRecovery",
    data() {
      return {
        fileList: [],
        deleteLoading: false,

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
        },

        key:""

      }
    },

    mounted() {

    },

    created() {
      window.document.title = "文件恢复"
      this.changeCurrentPageHandler(this.pagination.currentPage)
    },

    methods: {
      queryFile() {
        this.changeCurrentPageHandler(1)
      },

      changeCurrentPageHandler(currentPage) {
        this.httpRequest.get("storage/allDeleteFile?page=" + currentPage +
            "&limit=" + this.pagination.pageSize +
            "&orderFiled=id" + "&key=" + this.key +
            "&orderType=1")
            .then(response => {
              // console.log(response)
              this.pagination.currentPage = response.data.fileList.currentPage
              this.pagination.pageSize = response.data.fileList.pageSize
              this.pagination.total = response.data.fileList.totalSize
              this.pagination.totalPage = response.data.fileList.totalPage
              this.fileList = response.data.fileList.resultList
            })
      },

      recoveryFile(index, data) {
        this.deleteLoading = true
        this.httpRequest.post("storage/fileRecovery/" + data.id).then(response => {
          this.changeCurrentPageHandler(1)
        })
        this.deleteLoading = false
      },

      handleDelete(index, data) {
        this.deleteLoading = true
        this.httpRequest.post("storage/trueDeleteFile/" + data.id).then(response => {
          this.changeCurrentPageHandler(1)
        })
        this.deleteLoading = false
      },

    }


  }
</script>

<style scoped>

.queryButton {
  position: absolute;
  right: 400px;
}

.queryFile {
  width: 15%;
  position: absolute;
  right: 50px;
}


</style>
