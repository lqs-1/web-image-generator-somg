<template>
  <div>
    <div style="background-color: #F0DAD2; width: 90%; height: 70vh;  margin:0 auto; overflow: auto;word-wrap:break-word;word-break:break-all; border-radius:10px">

      <ul v-for="sessson in sessionList" :key="sessson.request">
        <li style="list-style-type: none;margin-bottom: 5px;border-radius:5px; margin-top: 5px;width: 95%;background-color: #B45B3E">问：{{sessson.request}}</li>

        <li  v-clipboard:copy="sessson.response" v-clipboard:success="onCopy" style="list-style-type: none;border-radius:5px; margin-top: 5px;width: 95%;background-color: #00B271">答:<vue-markdown>{{sessson.response}}</vue-markdown></li>

      </ul>

    </div>
    <div style="width: 90%; height: 10vh;  margin:10px auto; word-wrap:break-word;word-break:break-all;">
      <div style="width: 90%; height: 10vh; overflow: auto; float: left;display: inline-block">
        <el-input
            type="textarea"
            rows="4"
            placeholder="请输入问题"
            v-model="requestText">
        </el-input>
      </div>
      <div  style="width: 10%; height: 10vh; border-radius:10px;float: left;display: inline-block">
        <el-button type="primary" :loading="isResponse"  size="large" @click="onRequest()">提问</el-button>
      </div>
    </div>
  </div>
</template>


<script>
  import VueMarkdown from 'vue-markdown';
  export default {
    name: "TextRequest",
    components:{
      VueMarkdown
    },
    data() {
      return {
        requestText:"",
        isResponse:false,
        sessionList: []

      }
    },

    mounted() {

    },

    created() {

      window.document.title = "文字问答"

    },

    methods: {
      // 复制消息提示
      onCopy(){
        this.$message.success("Copy Success")
      },

      onRequest(){
        this.isResponse = true
        this.chart.post("/session", {"request": this.requestText})
            .then(resp =>{
              if (resp.data.code == 200){
                this.$message.success(resp.data.msg)
                this.sessionList.push({"request": this.requestText, "response": resp.data.responseText})
                this.requestText = ""
              }else {
                this.$message.error(resp.data.msg)
              }
              this.isResponse = false
            })




      },

    }


  }
</script>

<style scoped>
.el-button {
  display: block;
  margin-top: 20px;
  margin-left: 20px;

}

</style>
