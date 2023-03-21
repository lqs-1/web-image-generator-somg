<template>
  <div>

    <el-button type="primary" icon="el-icon-circle-plus" circle class="addMenuAuth" @click="showMenuAuthAddForm"></el-button>
    <el-dialog
        title="添加菜单"
        :visible="menuAuthAddVisible"
        width="30%"
        :before-close="addHandleClose">
      <span>
          <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
          <el-tab-pane label="添加根菜单" name="first">
             <el-form ref="addForm" :model="Menu" label-width="80px">
            <el-form-item label="菜单名字" prop="pmenuName">
              <el-input type="text" v-model="Menu.pmenuName"></el-input>
            </el-form-item>

            <el-form-item label="菜单路径" prop="pmenuPath">
              <el-input type="text" v-model="Menu.pmenuPath"></el-input>
            </el-form-item>
          </el-form>

          </el-tab-pane>
          <el-tab-pane label="添加子菜单" name="second">
<el-form ref="addForm" :model="Menu" label-width="80px" >
            <el-form-item label="菜单名字" prop="menuName">
              <el-input type="text" v-model="Menu.menuName"></el-input>
            </el-form-item>

            <el-form-item label="菜单路径" prop="menuPath">
              <el-input type="text" v-model="Menu.menuPath"></el-input>
            </el-form-item>

             <el-form-item label="所属父级" prop="parenIndex">
              <el-select v-model="Menu.parentIndex" placeholder="请选择">
                <el-option
                    v-for="item in allParentMenus"
                    :key="item.menuIndex"
                    :label="item.menuName"
                    :value="item.menuIndex"
                    :disabled="item.disabled">
    </el-option>
              </el-select>
            </el-form-item>

          </el-form>

          </el-tab-pane>
  </el-tabs>
      </span>
      <span slot="footer" class="dialog-footer">
    <el-button @click="addHandleClose">取 消</el-button>
    <el-button type="primary" @click="addMenu">添加</el-button>
  </span>
    </el-dialog>





    <el-table
        :data="menuList"
        height="700"
        style="width: 100%">
      <el-table-column
          label="菜单编号"
          width="250"
          align="center">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.id }}</span>
        </template>
      </el-table-column>
      <el-table-column
          label="菜单名称"
          width="300"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.menuName }}</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column
          label="菜单路径"
          width="300"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.menuPath }}</el-tag>
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
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>


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
    name: "MenuList",
    data() {
      return {
        menuList:[],
        allParentMenus:[],
        Menu:{},
        activeName: 'first',
        menuAuthAddVisible:false,
        parentMenuList:[],
        checkedParentMenu: '',

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

      }
    },

    mounted() {

    },

    created() {
      window.document.title = "菜单管理"
      this.changeCurrentPageHandler(1)
    },

    methods: {


      handleDelete(index, data) {
        this.httpRequest.post("menu/deleteMenu", {"id": data.id}).then(response => {
          this.changeCurrentPageHandler(1)
        })
      },


      changeCurrentPageHandler(currentPage) {
        this.httpRequest.get("menu/menusPage?page=" + currentPage +
            "&limit=" + this.pagination.pageSize +
            "&orderFiled=id" +
            "&orderType=1")
            .then(response => {
              this.pagination.currentPage = response.data.menuList.currentPage
              this.pagination.pageSize = response.data.menuList.pageSize
              this.pagination.total = response.data.menuList.totalSize
              this.pagination.totalPage = response.data.menuList.totalPage
              this.menuList = response.data.menuList.resultList
              // console.log(response)
            })

      },


      addMenu(){

        let params = {
          "pmenuName": this.Menu.pmenuName,
          "pmenuPath": this.Menu.pmenuPath,
          "menuName": this.Menu.menuName,
          "menuPath": this.Menu.menuPath,
          "parentIndex": this.Menu.parentIndex,
        }

        this.httpRequest.post('menu/addMenu', params)
            .then((response) => {
              this.menuAuthAddVisible = false
              this.Menu = {}
              this.changeCurrentPageHandler(1)
            })
      },


      getAllParentMenus(){

        this.httpRequest.get('menu/allParentMenus')
            .then((response) => {
                this.allParentMenus = response.data.allParentMenus
            })
      },

      showMenuAuthAddForm () {
        this.getAllParentMenus()
        this.menuAuthAddVisible = true
      },

      addHandleClose() {
        this.menuAuthAddVisible = false
        this.changeCurrentPageHandler(1)
      },

      handleClick(tab, event) {
        console.log(tab, event);
      },

    }


  }
</script>

<style scoped>

</style>
