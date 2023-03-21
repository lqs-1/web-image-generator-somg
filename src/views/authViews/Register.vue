<template>
  <div class="main"
       v-loading="loading"
       element-loading-text="注册中"
       element-loading-spinner="el-icon-loading"
       element-loading-background="rgba(0, 0, 0, 0.8)">
    <el-form ref="form"
             :rules="rules"
             :model="registerForm"
             class="loginFormTable">
      <h3 class="loginTitle">用户注册</h3>
      <el-form-item prop="username">
        <el-input type="text" v-model="registerForm.username" auto-complete="false" placeholder="请输入用户名"/>
      </el-form-item>
      <el-form-item prop="password">
        <el-input type="password" v-model="registerForm.password" auto-complete="false" placeholder="请输入密码"/>
      </el-form-item>
      <el-form-item label="性别" prop="sex">
        <el-select v-model="registerForm.sex" placeholder="请选择">
          <el-option label="男" value="男"></el-option>
          <el-option label="女" value="女"></el-option>
        </el-select>
      </el-form-item>
      <el-button type="primary" style="width: 100%" @click="registerHandler">注册</el-button>
    </el-form>
  </div>
</template>

<script>
export default {
  name: "Register",
  data(){
    return{
      loading: false,
      registerForm:{
        username: "",
        password: "",
        sex: ""
      },

      rules:{
        username: [{required: true, message: '请输入用户名', trigger:"blur"}],
        password: [{required: true, message: '请输入密码', trigger:"blur"}],
        sex: [{required: true, message: '性别不能为空', trigger:"blur"}]
      }
    }
  },

  created() {
    window.document.title = "用户注册"
  },

  methods:{
    // 登录请求
    registerHandler(){
      this.$refs.form.validate((valid) => {
        if (valid){
          this.loading = true
          this.httpRequest.post('/user/register', this.registerForm)
              .then((response) => {
                this.loading = false
                if (response.data.code > 20000 ){
                  this.$router.replace("/register")
                }
                this.$router.replace("/")

              }).catch((error) => {
            this.$router.replace("/register");
          });
        }else{
          this.$router.replace("/register")
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
