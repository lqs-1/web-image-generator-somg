<template>
  <div class="user_list">
    <el-button type="primary" icon="el-icon-circle-plus" circle class="addRole" @click="showRoleAddForm"></el-button>
    <el-dialog
        title="添加权限"
        :visible="permissionAddVisible"
        width="30%"
        :before-close="addHandleClose">
      <span>
          <el-form ref="addForm" :model="permissionForm" label-width="80px" :rules="rules">
            <el-form-item label="权限名" prop="permissionName">
              <el-input type="text" v-model="permissionForm.permissionName"></el-input>
            </el-form-item>
          </el-form>
      </span>
      <span slot="footer" class="dialog-footer">
    <el-button @click="permissionAddVisible = false">取 消</el-button>
    <el-button type="primary" @click="addPermission">添加</el-button>
  </span>
    </el-dialog>


    <el-button type="success" class="queryButton" @click="queryByName">权限查询</el-button>
    <el-input v-model="permissionname" placeholder="请输入权限名" class="queryUser"></el-input>


    <el-table
        :data="permissionList"
        height="700"
        style="width: 100%">
      <el-table-column
          label="权限编号"
          width="250"
          align="center">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.id }}</span>
        </template>
      </el-table-column>
      <el-table-column
          label="权限名称"
          width="300"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.permissionName }}</el-tag>
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
        title="权限修改"
        :visible="permissionEditVisible"
        width="30%"
        :before-close="editHandleClose">

      <span>
          <el-form ref="editForm" :model="permissionForm" label-width="80px" :rules="rules">
            <el-form-item label="权限id" prop="id">
              <el-input v-model="permissionForm.id" :disabled="true"></el-input>
            </el-form-item>
            <el-form-item label="权限名" prop="roleName">
              <el-input type="text" v-model="permissionForm.permissionName"></el-input>
            </el-form-item>
          </el-form>
      </span>

      <span slot="footer" class="dialog-footer">
    <el-button @click="permissionEditVisible = false">取 消</el-button>
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
  name: "PermissionList",
  data() {
    return {
      permissionList: [],
      permissionAddVisible: false,
      permissionEditVisible: false,
      permissionname: "",
      permissionForm: {
        id: "",
        permissionName: ""
      },
      rules: {
        permissionName: [{required: true, message: '请输入权限名', trigger: "blur"}],
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
    window.document.title = "权限管理"
    this.changeCurrentPageHandler(this.pagination.currentPage)
  },

  methods: {

    changeCurrentPageHandler(currentPage) {
      this.httpRequest.get("permission/permissionPage?page=" + currentPage +
          "&limit=" + this.pagination.pageSize +
          "&permissionname=" + this.permissionname +
          "&orderFiled=id" +
          "&orderType=1")
          .then(response => {
            // console.log(response)
            this.pagination.currentPage = response.data.permissionList.currentPage
            this.pagination.pageSize = response.data.permissionList.pageSize
            this.pagination.total = response.data.permissionList.totalSize
            this.pagination.totalPage = response.data.permissionList.totalPage
            this.permissionList = response.data.permissionList.resultList
          })
    },

    queryByName() {
      this.changeCurrentPageHandler(1)
    },

    addHandleClose() {
      this.permissionAddVisible = false
    },

    showRoleAddForm() {
      this.permissionForm = {}
      this.permissionAddVisible = true
    },


    addPermission() {
      this.$refs.addForm.validate((valid) => {
        if (valid) {
          // console.log(this.userForm)
          this.httpRequest.post("permission/addPermission", this.permissionForm).then(response => {
            this.changeCurrentPageHandler(1)
            this.permissionForm = {}
            this.permissionAddVisible = false
          })
        } else {
          message.error("请完善数据")
        }
      })
    },


    handleEdit(index, data) {
      // console.log(data)
      this.permissionForm = data
      this.permissionEditVisible = true

    },

    editHandleClose() {
      this.permissionEditVisible = false
    },

    editRole() {
      this.$refs.editForm.validate((valid) => {
        if (valid) {
          // console.log(this.userForm)
          this.httpRequest.post("permission/editPermission", this.permissionForm).then(response => {
            this.changeCurrentPageHandler(1)
            this.permissionForm = {}
            this.permissionEditVisible = false
          })
        } else {
          message.error("请完善数据")
        }
      })
    },


    handleDelete(index, data) {
      this.httpRequest.post("permission/deletePermission", {"id": data.id}).then(response => {
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
