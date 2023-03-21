<template>
  <div class="user_list">
    <el-button type="primary" icon="el-icon-circle-plus" circle class="addRole" @click="showRoleAddForm"></el-button>
    <el-dialog
        title="添加角色"
        :visible="roleAddVisible"
        width="30%"
        :before-close="addHandleClose">
      <span>
          <el-form ref="addForm" :model="roleForm" label-width="80px" :rules="rules">
            <el-form-item label="角色名" prop="roleName">
              <el-input type="text" v-model="roleForm.roleName"></el-input>
            </el-form-item>
          </el-form>
      </span>
      <span slot="footer" class="dialog-footer">
    <el-button @click="roleAddVisible = false">取 消</el-button>
    <el-button type="primary" @click="addRole">添加</el-button>
  </span>
    </el-dialog>


    <el-button type="success" class="queryButton" @click="queryByName">角色查询</el-button>
    <el-input v-model="rolename" placeholder="请输入角色名" class="queryUser"></el-input>


    <el-table
        :data="roleList"
        height="700"
        style="width: 100%">
      <el-table-column
          label="角色编号"
          width="250"
          align="center">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.id }}</span>
        </template>
      </el-table-column>
      <el-table-column
          label="角色名称"
          width="300"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.roleName }}</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column
          label="操作"
          width="500"
          align="center">
        <template slot-scope="scope">
          <el-button
              size="mini"
              @click="handleEdit(scope.$index, scope.row)">编辑
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
        title="角色修改"
        :visible="roleEditVisible"
        width="30%"
        :before-close="editHandleClose">

      <span>
          <el-form ref="editForm" :model="roleForm" label-width="80px" :rules="rules">
            <el-form-item label="角色id" prop="id">
              <el-input v-model="roleForm.id" :disabled="true"></el-input>
            </el-form-item>
            <el-form-item label="角色名" prop="roleName">
              <el-input type="text" v-model="roleForm.roleName"></el-input>
            </el-form-item>
          </el-form>
      </span>

      <span slot="footer" class="dialog-footer">
    <el-button @click="roleEditVisible = false">取 消</el-button>
    <el-button type="primary" @click="editRole">修改</el-button>
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
  name: "RoleList",
  data() {
    return {
      roleList: [],
      roleAddVisible: false,
      roleEditVisible: false,
      rolename: "",
      roleForm: {
        id: "",
        roleName: ""
      },
      rules: {
        roleName: [{required: true, message: '请输入角色', trigger: "blur"}],
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
      }
    }
  },

  created() {
    window.document.title = "角色管理"
    this.changeCurrentPageHandler(this.pagination.currentPage)
  },

  methods: {


    changeCurrentPageHandler(currentPage) {
      this.httpRequest.get("role/rolePage?page=" + currentPage +
          "&limit=" + this.pagination.pageSize +
          "&rolename=" + this.rolename +
          "&orderFiled=id" +
          "&orderType=1")
          .then(response => {
            // console.log(response)
            this.pagination.currentPage = response.data.roleList.currentPage
            this.pagination.pageSize = response.data.roleList.pageSize
            this.pagination.total = response.data.roleList.totalSize
            this.pagination.totalPage = response.data.roleList.totalPage
            this.roleList = response.data.roleList.resultList
          })
    },

    queryByName() {
      this.changeCurrentPageHandler(1)
    },

    addHandleClose() {
      this.roleAddVisible = false
    },

    showRoleAddForm() {
      this.roleForm = {}
      this.roleAddVisible = true
    },


    addRole() {
      this.$refs.addForm.validate((valid) => {
        if (valid) {
          // console.log(this.userForm)
          this.httpRequest.post("role/addRole", this.roleForm).then(response => {
            this.changeCurrentPageHandler(1)
            this.roleForm = {}
            this.roleAddVisible = false
          })
        } else {
          message.error("请完善数据")
        }
      })
    },


    handleEdit(index, data) {
      // console.log(data)
      this.roleForm = data
      this.roleEditVisible = true

    },

    editHandleClose() {
      this.roleEditVisible = false
    },

    editRole() {
      this.$refs.editForm.validate((valid) => {
        if (valid) {
          // console.log(this.userForm)
          this.httpRequest.post("role/editRole", this.roleForm).then(response => {
            this.changeCurrentPageHandler(1)
            this.roleForm = {}
            this.roleEditVisible = false
          })
        } else {
          message.error("请完善数据")
        }
      })
    },


    handleDelete(index, data) {
      this.httpRequest.post("role/deleteRole", {"id": data.id}).then(response => {
        this.changeCurrentPageHandler(1)
      })
    }

  }


}
</script>

<style scoped>


.queryUser {
  width: 15%;
  position: absolute;
  right: 50px;
}

.queryButton {
  position: absolute;
  right: 400px;
}


</style>
