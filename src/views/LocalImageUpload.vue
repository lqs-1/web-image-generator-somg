<template>
  <div class="main" element-loading-background="rgba(0, 0, 0, 0.8)">
    <el-form ref="form" class="uploadImageFormTable">
      <h3 class="uploadImageTitle">本地文件上传</h3>

      <el-form-item>
        <el-upload
            class="upload-demo"
            drag
            :action="uploadUrl"
            :on-success="uploadSuccess"
            name="image"
            multiple>
          <i class="el-icon-upload"></i>
          <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        </el-upload>
      </el-form-item>

      <el-button type="primary" style="width: 100%" @click="linkListVisible=true">生成链接</el-button>
      <br>
      <br>
      <br>
      <el-button type="primary" style="width: 100%" @click="refreshPage">重新选择</el-button>

    </el-form>



    <el-dialog
        title="链接列表"
        :visible="linkListVisible"
        width="80%"
        :before-close="addHandleClose">
      <span>
        <el-table
        :data="fileList"
        style="width: 100%">
          <el-table-column
              prop="img"
              label="img"
              width="100">
                <template slot-scope="scope">
                  <img  :src="scope.row.img" alt="" style="width: 50px;height: 50px">
                </template>
          </el-table-column>
          <el-table-column
              prop="url"
              label="url"
              width="1000">
          </el-table-column>
          <el-table-column
              label="copy">
              <template slot-scope="scope">
                   <button type="button"
                           v-clipboard:copy="scope.row.url"
                           v-clipboard:success="onCopy">
                     Copy!
                   </button>
              </template>
          </el-table-column>
        </el-table>
      </span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="linkListVisible = false">取 消</el-button>
      </span>
    </el-dialog>



  </div>
</template>

<script>
export default {
  name: "LocalImageUpload",
  data(){
    return{
      uploadUrl: 'http://localhost:8888/somg/web-image-generate/single',
      fileList:[],
      linkListVisible: false
    }
  },
  created() {
    window.document.title = "localImageUpload"
  },
  methods:{
    // 文件上传成功
    uploadSuccess(response){
      if (response.code >= 10000 && response.code < 20000){
        this.$message.success(response.msg)
        let imgObject = {"img": response.webImageUrl, "url": response.webImageUrl}
        this.fileList.push(imgObject)
      }else{
        this.$message.error(response.msg)
      }
    },

    // 图片链接生成对话框
    addHandleClose() {
      this.linkListVisible = false
    },

    // 复制消息提示
    onCopy(){
      this.$message.success("Copy Success")
    },

    // 重新加载页面
    refreshPage(){
      location.reload()
    }


  }
}
</script>


<style scoped>
.main{
  width:100%;
  height:100%;
  /*position: fixed;*/
  background-size:100% 100%;
  background-repeat: space;
}
.uploadImageFormTable{
  border-radius: 15px;
  background-clip: padding-box;
  margin: 180px auto;
  width: 350px;
  padding: 15px 35px 15px 35px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
}
.uploadImageTitle{
  margin: 0 auto 40px auto;
  text-align: center;
}
</style>
