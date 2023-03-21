<template>
  <div class="file_list">
    <el-button type="primary" icon="el-icon-circle-plus" circle class="uploadFiles" @click="showFileAddForm"></el-button>
    <el-dialog
        title="上传图片"
        :visible="uploadFilesVisible"
        width="30%"
        :before-close="addHandleClose">
      <span>
          <el-tabs v-model="activeName" type="card">
          <el-tab-pane label="单个上传" name="first">
          <el-upload
              class="upload-demo"
              ref="uploadSingle"
              :headers="header"
              name="file"
              align="center"
              :action="singleUploadUrl"
              :on-success="uploadSuccess">
             <el-button size="small" type="primary">点击上传</el-button>
          </el-upload>

          </el-tab-pane>
          <el-tab-pane label="批量上传" name="second">
             <el-upload class="upload-demo"
                         drag
                         ref="uploadMulti"
                         align="center"
                         :action="multiUploadUrl"
                         name="files"
                         :headers="header"
                        :on-success="uploadSuccess"
                         multiple>
              <i class="el-icon-upload"></i>
              <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
            </el-upload>

          </el-tab-pane>
  </el-tabs>
      </span>
      <span slot="footer" class="dialog-footer">
    <el-button @click="addHandleClose">取 消</el-button>
  </span>
    </el-dialog>


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
  name: "FileList",
  data() {
    return {
      deleteLoading: false,
      header: {
        token: localStorage.getItem("token")
      },
      multiUploadUrl: "http://nobibibi.top:8888/somg/web-file-generate/multi",
      // multiUploadUrl: "http://localhost:8888/somg/web-file-generate/multi",
      singleUploadUrl: "http://nobibibi.top:8888/somg/web-file-generate/single",
      // singleUploadUrl: "http://localhost.111:8888/somg/web-file-generate/single",
      activeName: 'first',
      fileList: [],
      uploadFilesVisible: false,

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
    window.document.title = "文件列表"
    this.changeCurrentPageHandler(this.pagination.currentPage)
  },

  methods: {

    changeCurrentPageHandler(currentPage) {
      this.httpRequest.get("storage/allFilePage?page=" + currentPage +
          "&limit=" + this.pagination.pageSize +
          "&orderFiled=id" +
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


    addHandleClose() {
      this.$refs.uploadMulti.clearFiles()
      this.$refs.uploadSingle.clearFiles()

      this.uploadFilesVisible = false
      this.changeCurrentPageHandler(1)
    },

    showFileAddForm() {
      this.uploadFilesVisible = true
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


    // 文件上传成功
    uploadSuccess(response){
      if (response.code >= 10000 && response.code < 20000){
        this.$message.success(response.msg)
      }else{
        this.$message.error(response.msg)
      }
    },



  }


}
</script>

<style scoped>



</style>
