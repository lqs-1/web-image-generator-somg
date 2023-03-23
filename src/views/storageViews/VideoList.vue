<template>
  <div class="file_list">

    <el-table
        :data="fileList"
        height="800"
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
          label="预览"
          align="center"
          width="100">
        <template slot-scope="scope">
          <div class="video">
            <el-dialog title="预览详情" width="50%" style="height: 100%" append-to-body top="10px" :visible.sync="dialogVisible" @closed="closeDialog">
              <video  width="100%" :src="playvideo" :poster="playvideo" controls="controls" id="video" preload></video>
            </el-dialog>
            <!-- 页面table显示的video标签 -->
            <video :src="scope.row.file" width="100%" preload></video>
            <i class="el-icon-video-play playIcon" @click="handleCheck(scope.row.file)"></i>
          </div>
        </template>
      </el-table-column>


      <el-table-column
          label="网络地址"
          width="900"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium" >{{ scope.row.file }}</el-tag>
          </div>
        </template>
      </el-table-column>


      <el-table-column
          label="文件类型"
          width="200"
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
  name: "VideoList",
  data() {
    return {
      dialogVisible: false, // 视频播放弹窗
      playvideo: null, // 存储用户点击的视频播放链接
      playvideoName: null, // 存储正在播放视频的名称

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
    window.document.title = "视频文件列表"
    this.changeCurrentPageHandler(this.pagination.currentPage)
  },

  methods: {

    // 查看
    handleCheck(file) {
      this.playvideo = file // 存储用户点击的视频播放链接
      this.playvideoName = file // 存储用户点击的视频播放链接
      this.dialogVisible = true
    },


    closeDialog(){
      this.playvideo = ""
      this.playvideoName = ""
      this.dialogVisible = false
    },




    changeCurrentPageHandler(currentPage) {
      this.httpRequest.get("storage/allVideoPage?page=" + currentPage +
          "&limit=" + this.pagination.pageSize +
          "&orderFiled=id" +
          "&orderType=1")
          .then(response => {
            // console.log(response)
            this.pagination.currentPage = response.data.videoList.currentPage
            this.pagination.pageSize = response.data.videoList.pageSize
            this.pagination.total = response.data.videoList.totalSize
            this.pagination.totalPage = response.data.videoList.totalPage
            this.fileList = response.data.videoList.resultList
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
.iframeCss {
  border: none;
}
.videoPlayBox {
  width: 100%;
  height: 100vh;
  background-color: rgb(0,0,0);
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
}
#my-video{
  object-fit: cover;
  object-position: center center;
}
</style>
