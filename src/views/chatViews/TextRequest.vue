<template>
  <div>
    <div style="background-color: #F0DAD2; width: 90%; height: 75vh;  margin:0 auto; overflow: auto;word-wrap:break-word;word-break:break-all; border-radius:5px">

      <ul v-for="sessson in sessionList" :key="sessson.response + idUU">
        <li v-clipboard:copy="sessson.request" v-clipboard:success="onCopy" style="font-family: 楷体;list-style-type: none;margin-bottom: 5px;border-radius:2px; margin-top: 8px;width: 95%;background-color: #B45B3E">{{sessson.request}}</li>

        <li  v-clipboard:copy="sessson.response" v-clipboard:success="onCopy" style="font-family: 楷体;list-style-type: none;border-radius:2px; margin-top: 8px;width: 95%;background-color: #00B271"><vue-markdown>{{sessson.response}}</vue-markdown></li>

      </ul>

    </div>
    <div style="width: 90%; height: 10vh;  margin:20px auto; word-wrap:break-word;word-break:break-all;">
<!--      <div style="width: 90%; height: 10vh; overflow: auto; float: left;display: inline-block">-->
<!--        <el-input-->
<!--            type="textarea"-->
<!--            rows="4"-->
<!--            placeholder="请输入问题"-->
<!--            v-model="requestText">-->
<!--        </el-input>-->
<!--      </div>-->
<!--      <div  style="width: 10%; height: 10vh; border-radius:10px;float: left;display: inline-block">-->
<!--        <el-button type="primary" :loading="isResponse"  size="large" @click="onRequest()">提问</el-button>-->
<!--      </div>-->

      <el-input placeholder="请输入问题" v-model="requestText" clearable @clear="clearRequestText">
        <el-button :loading="isResponse" slot="append" icon="el-icon-search" @click="onRequest">提问</el-button>
      </el-input>
    </div>
  </div>
</template>


<script>
  import VueMarkdown from 'vue-markdown';
  import uuid from "uuid";
  export default {
    name: "TextRequest",
    components:{
      VueMarkdown
    },
    data() {
      return {
        requestText:null,
        isResponse:false,
        sessionList: [],
        idUU: "",
        methodss: "onRequest()"

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
        if (this.requestText == null) {
          this.$message.info("请输入问题")
        }else {
          this.isResponse = true
          this.chart.post("/chat/session", {"request": this.requestText})
              .then(resp =>{
                this.sessionList.push({"request": this.requestText, "response": resp.data.responseText})
                this.requestText = ""
                this.isResponse = false
              })
        }
      },

      // http://127.0.0.1:5000/chat/sse?request='你是什么人'

      onRequestSSE() {
        // 创建EventSource对象，连接到SSE的后端URL

        this.idUU = Date.now()

        const eventSource = new EventSource("http://nobibibi.top:5000/chat/session-sse?request=" + this.requestText);

        this.sessionList.push({"request": this.requestText, "response": ""})
        this.requestText = ""
        this.isResponse = true


        // 监听message事件，接收从服务器发送的数据
        // 监听'servermessage'事件
        eventSource.addEventListener('message', event => {
          // console.log("eeee" + event.data)
          this.sessionList[this.sessionList.length -1].response = this.sessionList[this.sessionList.length -1].response + event.data
          console.log(this.sessionList)

        });


        // 监听错误事件，处理可能的连接错误
        eventSource.addEventListener("error", error => {
          // console.error("SSE Error:", error);
          eventSource.close();
          this.isResponse = false
        });
      },



      clearRequestText() {
       this.requestText = null
      },

    }


  }
</script>

<style scoped>


div::-webkit-scrollbar {
  width: 0;
}

</style>
