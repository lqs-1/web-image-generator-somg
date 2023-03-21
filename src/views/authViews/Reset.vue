<template>
  <div class="main"
       v-loading="loading"
       element-loading-text="修改中"
       element-loading-spinner="el-icon-loading"
       element-loading-background="rgba(0, 0, 0, 0.8)">
    <el-form ref="form"
             :rules="rules"
             :model="resetForm"
             class="loginFormTable">
      <h3 class="loginTitle">找回密码</h3>
      <el-form-item prop="username">
        <el-input type="text" v-model="resetForm.username" auto-complete="false" placeholder="请输入用户名"/>
      </el-form-item>
      <el-form-item prop="password">
        <el-input type="password" v-model="resetForm.password" auto-complete="false" placeholder="请输入新的密码"/>
      </el-form-item>

      <el-button type="primary" style="width: 100%" @click="toAlter">修改密码</el-button>
    </el-form>
  </div>
</template>

<script>
export default {
  name: "Reset",
  data(){
    return{
      loading: false,
      resetForm:{
        username: "",
        password: "",
      },
      rules:{
        username: [{required: true, message: '请输入用户名', trigger:"blur"}],
        password: [{required: true, message: '请输入密码', trigger:"blur"}],
      }
    }
  },

  created() {
    window.document.title = "修改密码"
  },

  methods:{
    toAlter(){
      this.$refs.form.validate((valid) => {
        if (valid){
          this.loading = true
          this.httpRequest.post('/user/alterPwd', this.resetForm)
              .then((response) => {
                this.loading = false
                if (response.data.code > 20000 ){
                  this.$router.replace("/reset")
                }
                this.$router.replace("/")

              }).catch((error) => {
            this.$router.replace("/reset");
          });
        }else{
          this.$router.replace("/reset")
        }
      })
    },

  }
}
</script>

<style scoped>
.main{
  width:100%;
  height:100%;
  position: fixed;
  background-size:100% 100%;
  background-repeat: space;
  background-image: url("../../../public/images/background.jpeg");
}

.loginFormTable{
  border-radius: 15px;
  background-clip: padding-box;
  margin: 180px auto;
  width: 350px;
  padding: 15px 35px 15px 35px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
}
.loginTitle{
  margin: 0 auto 40px auto;
  text-align: center;
}
.remember{
  text-align: left;
  margin: 0 0 15px 0;
}
</style>
