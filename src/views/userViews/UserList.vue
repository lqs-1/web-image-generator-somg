<template>
  <div class="user_list">
    <el-button type="primary" icon="el-icon-circle-plus" circle class="addUser" @click="showUserAddForm"></el-button>

    <el-dialog
        title="用户添加"
        :visible="userAddVisible"
        width="30%"
        :before-close="addHandleClose">

      <span>
          <el-form ref="addForm" :model="userForm" label-width="80px" :rules="rules">
            <el-form-item label="用户名" prop="username">
              <el-input type="text" v-model="userForm.username"></el-input>
            </el-form-item>

            <el-form-item label="密码" prop="password">
              <el-input type="password" v-model="userForm.password"></el-input>
            </el-form-item>

            <el-form-item label="邮箱" prop="email">
              <el-input type="email" v-model="userForm.email"></el-input>
            </el-form-item>

            <el-form-item label="性别" prop="sex">
              <el-select v-model="userForm.sex" placeholder="请选择">
                <el-option label="男" value="男"></el-option>
                <el-option label="女" value="女"></el-option>
              </el-select>
            </el-form-item>
          </el-form>
      </span>

      <span slot="footer" class="dialog-footer">
    <el-button @click="userAddVisible = false">取 消</el-button>
    <el-button type="primary" @click="addUser">添加</el-button>
  </span>
    </el-dialog>


    <el-dialog
        title="菜单授权"
        :visible="menuAuthVisible"
        width="80%"
        :before-close="authHandleClose">
      <span>
       <el-table
           ref="multipleTable"
           :data="menuList"
           tooltip-effect="dark"
           align="center"
           style="width: 100%"
           border
           height="400"
           @selection-change="handleSelectionChange">
    <el-table-column
        type="selection"
        width="55">
    </el-table-column>
    <el-table-column
        label="菜单名字"
        width="300">
      <template slot-scope="scope">
        <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.menuName }}</el-tag>
          </div>
      </template>
    </el-table-column>
    <el-table-column
        label="菜单路径"
        width="400">
       <template slot-scope="scope">
         <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.menuPath }}</el-tag>
          </div>
       </template>
    </el-table-column>
  </el-table>
      </span>
      <span slot="footer" class="dialog-footer">
    <el-button @click="menuAuthVisible = false">取 消</el-button>
    <el-button type="primary" @click="addMenu">添加</el-button>
  </span>
    </el-dialog>


    <el-button type="success" class="queryButton" @click="queryByName">用户查询</el-button>
    <el-input v-model="username" placeholder="请输入用户名" class="queryUser"></el-input>
    <el-divider></el-divider>
    <el-table
        :data="userList"
        height="700"
        style="width: 100%">
      <el-table-column
          label="用户编号"
          width="80"
          align="center">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.id }}</span>
        </template>
      </el-table-column>
      <el-table-column
          label="姓名"
          width="150"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.username }}</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column
          label="密码"
          width="500"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.password }}</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column
          label="性别"
          width="50"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="">{{ scope.row.sex }}</el-tag>
          </div>
        </template>
      </el-table-column>


      <el-table-column
          label="创建时间"
          width="150"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="">{{ scope.row.createTime }}</el-tag>
          </div>
        </template>
      </el-table-column>

      <el-table-column
          label="登录时间"
          width="150"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="">{{ scope.row.loginTime }}</el-tag>
          </div>
        </template>
      </el-table-column>


      <el-table-column
          label="操作"
          width="450"
          align="center">
        <template slot-scope="scope">
          <el-button
              size="mini"
              @click="handleEdit(scope.$index, scope.row)">编辑
          </el-button>
          <el-button
              size="mini"
              @click="authEdit(scope.$index, scope.row)">菜单授权
          </el-button>
          <el-button
              size="mini"
              @click="resetPassWord(scope.$index, scope.row)">重置密码
          </el-button>
          <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <!--  用户修改-->
    <el-dialog
        title="用户修改"
        :visible="userEditVisible"
        width="30%"
        :before-close="editHandleClose">

      <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
        <el-tab-pane label="基本信息" name="first">
                <span>
          <el-form ref="editForm" :model="userForm" label-width="80px" :rules="rules">
            <el-form-item label="用户id" prop="id">
              <el-input v-model="userForm.id" :disabled="true"></el-input>
            </el-form-item>
            <el-form-item label="用户名" prop="username">
              <el-input type="text" v-model="userForm.username"></el-input>
            </el-form-item>

            <el-form-item label="密码" prop="password">
<!--              <el-input type="password" v-model="userForm.password"></el-input>-->
              <el-input v-model="userForm.password" :disabled="true"></el-input>
            </el-form-item>

            <el-form-item label="性别" prop="sex">
              <el-select v-model="userForm.sex" placeholder="请选择">
                <el-option label="男" value="男"></el-option>
                <el-option label="女" value="女"></el-option>
              </el-select>
            </el-form-item>
          </el-form>
      </span>

        </el-tab-pane>
        <el-tab-pane label="角色管理" name="second">
          <div class="checkScrol">
            <table class="datatable">
              <thead>
              <tr>
                <th>选择</th>
                <th>角色id</th>
                <th>角色名</th>
              </tr>
              </thead>
              <tbody>
              <tr v-for="c in roleList">
                <td>
                  <input :id="c.id" v-model="roleIds" type="checkbox" :value="c.id">
                </td>
                <td><label :for="c.id">{{c.id}}</label></td>
                <td><label :for="c.id">{{c.roleName}}</label></td>
              </tr>
              </tbody>
            </table>
          </div>
        </el-tab-pane>


        <el-tab-pane label="权限管理" name="third">
          <div class="checkScrol">
            <table class="datatable">
              <thead>
              <tr>
                <th>选择</th>
                <th>权限id</th>
                <th>权限名</th>
              </tr>
              </thead>
              <tbody>
              <tr v-for="c in permissionList">
                <td>
                  <input :id="c.id" v-model="permissionIds" type="checkbox" :value="c.id">
                </td>
                <td><label :for="c.id">{{c.id}}</label></td>
                <td><label :for="c.id">{{c.permissionName}}</label></td>
              </tr>
              </tbody>
            </table>
          </div>
        </el-tab-pane>
      </el-tabs>

      <span slot="footer" class="dialog-footer">
    <el-button @click="userEditVisible = false">取 消</el-button>
    <el-button type="primary" @click="editUser">修改</el-button>
  </span>
    </el-dialog>

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
  name: "UserList",
  data() {
    return {
      userList: [],
      userAddVisible: false,
      userEditVisible: false,
      menuAuthVisible: false,
      username: "",
      userForm: {
        id: "",
        username: "",
        password: "",
        sex: "",
        email:""
      },
      rules: {
        username: [{required: true, message: '请输入用户名', trigger: "blur"}],
        password: [{required: true, message: '请输入密码', trigger: "blur"}],
        sex: [{required: true, message: '请选择性别', trigger: "blur"}],
        email: [{required: true, message: '邮箱必填', trigger: "blur"}]
      },
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
      activeName: 'first',
      roleIds: [],
      userId:null,
      roleList: [],
      menuList: [],
      multipleTable: [],
      permissionList: [],
      permissionIds: [],
    }
  },

  created() {
    window.document.title = "用户管理"
    this.changeCurrentPageHandler(this.pagination.currentPage)
  },

  methods: {

    handleSelectionChange(val) {
      this.multipleTable = val;
    },

    getAllMenuList(){
      this.httpRequest.get("menu/menuList")
          .then(response => {
            this.menuList = response.data.menuList
          });
    },
    // 表单默认选中
    SelectionChange(checkedMenus) {
      this.$nextTick(() => {
        if (checkedMenus != null){
          checkedMenus.forEach(row => {
            this.$refs.multipleTable.toggleRowSelection(this.menuList.find(item => { return row.id == item.id}),true)
          })
        }
      })
    },

    changeCurrentPageHandler(currentPage) {
      this.httpRequest.get("user/userPage?page=" + currentPage +
          "&limit=" + this.pagination.pageSize +
          "&username=" + this.username +
          "&orderFiled=id" +
          "&orderType=1")
          .then(response => {
            this.pagination.currentPage = response.data.userList.currentPage
            this.pagination.pageSize = response.data.userList.pageSize
            this.pagination.total = response.data.userList.totalSize
            this.pagination.totalPage = response.data.userList.totalPage
            this.userList = response.data.userList.resultList
          })
    },

    queryByName() {
      this.changeCurrentPageHandler(1)
    },

    addHandleClose() {
      this.userAddVisible = false
    },

    showUserAddForm() {
      this.userForm = {}
      this.userAddVisible = true
    },

    resetPassWord(index, data){
      this.httpRequest.post("user/resetPassWord/" + data.id)
          .then(response => {
            this.changeCurrentPageHandler(1)
          })
    },


    addMenu(){

      var menuIds = []
      this.multipleTable.forEach(item => {
        menuIds.push(item.id)
      })

      let param = {
        "userId": this.userId,
        "menuIds": menuIds
      }

      this.httpRequest.post("menu/alterMenuAuth", param)
          .then(response => {
            this.menuAuthVisible = false
            this.changeCurrentPageHandler(1)
            this.menuList = []
            this.multipleTable = []
          })
    },


    addUser() {
      this.$refs.addForm.validate((valid) => {
        if (valid) {
          // console.log(this.userForm)
          this.httpRequest.post("user/addUser", this.userForm).then(response => {
            this.changeCurrentPageHandler(1)
            this.userForm = {}
            this.userAddVisible = false
          })
        } else {
          message.error("请完善数据")
        }
      })
    },


    authEdit(index, data){
      this.menuAuthVisible = []
      this.menuList = []
      this.getAllMenuList()

      this.httpRequest.get("menu/currentUserMenuAuth?userId=" + data.id).then(response => {
        this.SelectionChange(response.data.checkedMenuList)
      });

      this.userId = data.id;
      this.menuAuthVisible = true
    },


    handleEdit(index, data) {
      // console.log(data)
      this.userForm = data
      this.userEditVisible = true
      this.httpRequest.get("role/roleList")
          .then(response => {
            // console.log(response)
            this.roleList = response.data.roleList
          })
      // console.log(this.userForm)
      this.httpRequest.get("user/roleList?id=" + this.userForm.id)
          .then(response => {
            // console.log(response)
            this.roleIds = response.data.roleIds
          })

      this.httpRequest.get("permission/permissionList")
          .then(response => {
            // console.log(response)
            this.permissionList = response.data.permissionList
          })
      // console.log(this.userForm)
      this.httpRequest.get("user/permissionList?id=" + this.userForm.id)
          .then(response => {
            // console.log(response)
            this.permissionIds = response.data.permissionIds
          })


    },

    editHandleClose() {
      this.userEditVisible = false
      this.roleIds = []
      this.roleList = []
    },

    authHandleClose(){
      this.menuAuthVisible = false
      this.menuList = []
      this.multipleTable = []
    },

    editUser() {
      this.$refs.editForm.validate((valid) => {
        if (valid) {
          // console.log(this.userForm)

          let params = {
              "id": this.userForm.id,
              "username": this.userForm.username,
              "password": this.userForm.password,
              "sex": this.userForm.sex,
              "roleIds": this.roleIds,
              "permissionIds": this.permissionIds
          }

          this.httpRequest.post("user/editUser", params).then(response => {
            this.changeCurrentPageHandler(this.pagination.currentPage)
            // this.pagination.currentPage = 1
            this.userForm = {}
            this.roleIds = []
            this.userEditVisible = false
          })
        } else {
          message.error("请完善数据")
        }
      })
    },


    handleDelete(index, data) {
      this.httpRequest.post("user/deleteUser", {"id": data.id}).then(response => {
        this.changeCurrentPageHandler(1)
      })
    },

    handleClick(tab, event) {

    },




  }


}
</script>

<style scoped>
.addUser {
  margin-left: 20px;
}

.queryUser {
  width: 15%;
  position: absolute;
  right: 50px;
}

.queryButton {
  position: absolute;
  right: 400px;
}
.datatable {
  position: relative;
  box-sizing: border-box;
  -webkit-box-flex: 1;
  width: 100%;
  max-width: 100%;
  font-size: 14px;
  color: rgb(96, 98, 102);
  overflow: hidden;
  flex: 1 1 0%;
}
.datatable td, .datatable th {
  padding: 12px 0;
  min-width: 0;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  text-overflow: ellipsis;
  vertical-align: middle;
  position: relative;
  text-align: left;
}


</style>
