<template>
  <div>
    <el-container style="position:absolute;left:0;right:0;top:0;bottom:0;overflow: auto;">
      <el-header class="header">
        <div>
          <div class="loginImg">
            <img src="/logo/logo.png" width="50" height="50">
          </div>
        </div>


          <div class="user_info">
            <!--            <img :src="user.topic" class="user_topic">-->
              <el-dropdown v-if="token != null" @command="userCommandHandler">
                <div>
                  <el-avatar src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"></el-avatar>

                </div>
                <el-dropdown-menu slot="dropdown">
                  <el-dropdown-item command="logout">注销登录</el-dropdown-item>
<!--                  <el-dropdown-item command="alterPwd">修改密码</el-dropdown-item>-->
                </el-dropdown-menu>
              </el-dropdown>
            <el-button type="primary" round v-else @click="toLogin">去登录</el-button>


          </div>
      </el-header>
      <el-container>
        <el-aside width="300px" style="background-color: #245953; height: 90vh">
          <el-menu @select="userItemHandler"
                   background-color="#282726"
                   text-color="#fff"
                   active-text-color="#A37C27"
                   :default-active="activeIndex"
          >

            <el-menu-item  index="/index"><i class="el-icon-first-aid-kit"></i>系统首页</el-menu-item>


            <el-submenu v-for="(menu,index) in menus" :index="menu.menuIndex.toString()" :key="index">
              <hr color="#583e2e">
              <template slot="title"><i class="el-icon-user"></i>{{ menu.menuName }}</template>

              <el-menu-item v-for="(menuItem, index) in menu.menuItems" :index="menuItem.menuPath.toString()" :key="index" >{{ menuItem.menuName }}</el-menu-item>

            </el-submenu>

<!--            <el-submenu index="2">-->
<!--              <template slot="title"><i class="el-icon-user"></i>用户管理</template>-->
<!--              <hr color="#999">-->
<!--              <el-menu-item index="/user/userList" >用户列表</el-menu-item>-->
<!--              <hr color="#999">-->
<!--              <el-menu-item index="/user/roleList">角色列表</el-menu-item>-->
<!--              <hr color="#999">-->
<!--              <el-menu-item index="/user/permissionList">权限列表</el-menu-item>-->
<!--            </el-submenu>-->

          </el-menu>
        </el-aside>
        <el-main>
          <router-view/>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>

export default {
  name: "Main",
  data() {
    return {
      menus: [],
      token: null,
      activeIndex: '/index',
      currentIndex: '/index',
    }
  },

  mounted() {
    this.activeIndex = this.$route.path
  },

  created() {
    window.document.title = "主页面"
    this.activeIndex = "/index"
    // this.$router.replace("/userList")
    this.checkLogin()
    // console.log(this.user)
    // console.log("hah")
  },

  methods: {
    userItemHandler(index) {
      this.$router.push(index)
      // location.reload()
    },


    checkLogin() {

      // if (localStorage.getItem("token") == null){
      //   this.toLogin();
      // }
      if (localStorage.getItem("token") != null) {

          this.token = localStorage.getItem("token")

          this.menus = JSON.parse(localStorage.getItem("menus"))


      }

    },

    toLogin(){
      this.$router.replace("/")
    },


    userCommandHandler(command){
      if (command == 'logout') {
        this.httpRequest.get("/user/logout").then(response => {

          localStorage.clear()

          this.$router.replace("/")

        })
      }
    },
  }


}
</script>

<style scoped>
.header {
  color: black;
  width: 100%;
  height: 100%;
  font-size: 20px;
  display: flex;
  align-items: center;
  font-family: Arial;
  background-color: #245953;
  background-image: linear-gradient(to right, #bf30ac 0%, #0f9d58 100%);
}

.user_info {
  position: absolute;
  right: 50px;
}

el-aside::-webkit-scrollbar {
  width: 0;
}
</style>
