<template>
    <div class="main"
         v-loading="loading"
         element-loading-text="生成中"
         element-loading-spinner="el-icon-loading"
         element-loading-background="rgba(0, 0, 0, 0.8)">
      <el-form ref="form"
               :rules="rules"
               :model="scaleData"
               class="scaleFormTable">
        <h3 class="scaleTitle">图片缩放</h3>

        <el-form-item>
          <el-upload
              class="upload-demo"
              ref="upload"
              name="image"
              :headers="header"
              action="http://nobibibi.top:8888/image/image"
              :limit="1"
              accept="image/*"
              :auto-upload="true"
              :on-success="uploadSuccess">
            <el-button slot="trigger" size="small" type="primary">选取文件</el-button>
          </el-upload>
        </el-form-item>


        <el-form-item prop="scale">
          <el-input type="number" v-model="scaleData.scale" placeholder="大于1放大 小于1缩小"/>
        </el-form-item>



        <a :href="'http://nobibibi.top:8888/image/scale?imagePath=' +  scaleData.imagePath + '&scale=' + scaleData.scale + '&contentType=' + scaleData.contentType" style="text-decoration: none">
        <el-button type="primary" style="width: 100%">
            生成
        </el-button>
        </a>

        <hr>
        <el-button type="primary" style="width: 100%" @click="reset">重新选择</el-button>
        <hr>
      </el-form>
    </div>
</template>


<script>
  export default {
    name: "Scale",
    data() {
      return {
        header: {
          token: localStorage.getItem("token")
        },
        loading: false,
        scaleData:{
          scale:null,
          contentType:null,
          imagePath:null
        },


        rules:{
          scale: [{required: true, message: '请输入缩放参数', trigger:"blur"}],
        }

      }
    },

    mounted() {

    },

    created() {
      window.document.title = "图片缩放"
    },

    methods: {

      reset(){
        this.scaleData = {}
        this.$refs.upload.fileList = []
      },

      // 文件上传成功
      uploadSuccess(response){
        if (response.code >= 10000 && response.code < 20000){
          this.scaleData.contentType = response.image.contentType
          this.scaleData.imagePath = response.image.imagePath
          console.log(this.scaleData)
          this.$message.success(response.msg)
        }else{
          this.$message.error(response.msg)
        }
      },
  }




  }
</script>

<style scoped>
/*.main {*/
/*  width: 100%;*/
/*  height: 100%;*/
/*  position: fixed;*/
/*  background-size: 100% 100%;*/
/*  background-repeat: space;*/
/*}*/

.scaleFormTable{
  border-radius: 15px;
  background-clip: padding-box;
  margin: 180px auto;
  width: 350px;
  padding: 15px 35px 15px 35px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
}

.scaleTitle{
  margin: 0 auto 40px auto;
  text-align: center;
}




</style>
