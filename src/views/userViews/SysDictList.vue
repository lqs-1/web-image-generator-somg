<template>
  <div>

    <el-button type="primary" icon="el-icon-circle-plus" circle class="addSysDict"
               @click="showSysDictAddForm"></el-button>
    <el-dialog
        title="添加字典"
        :visible="sysDictAddVisible"
        width="30%"
        :before-close="addHandleClose">
      <span>
          <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
          <el-tab-pane label="添加根字典" name="first">
           <el-form ref="addForm" :model="SysDic" label-width="80px">
              <el-form-item label="字典编码" prop="dictCode">
                <el-input type="text" v-model="SysDic.dictCode"></el-input>
              </el-form-item>

              <el-form-item label="字典描述" prop="dictDesc">
                <el-input type="text" v-model="SysDic.dictDesc"></el-input>
              </el-form-item>
          </el-form>

          </el-tab-pane>
          <el-tab-pane label="添加子字典" name="second">
<el-form ref="addForm" :model="SysDic" label-width="80px">
            <el-form-item label="字典编码" prop="dictCode">
              <el-input type="text" v-model="SysDic.dictCode"></el-input>
            </el-form-item>

            <el-form-item label="字典值" prop="dictValue">
              <el-input type="text" v-model="SysDic.dictValue"></el-input>
            </el-form-item>

            <el-form-item label="字典描述" prop="dictDesc">
              <el-input type="text" v-model="SysDic.dictDesc"></el-input>
            </el-form-item>

             <el-form-item label="所属父级" prop="parenIndex">
              <el-select v-model="SysDic.parentCode" placeholder="请选择">
                <el-option
                    v-for="item in allParentDict"
                    :key="item.dictCode"
                    :label="item.dictDesc"
                    :value="item.dictCode"
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
    <el-button type="primary" @click="addDict">添加</el-button>
  </span>
    </el-dialog>


    <el-table
        :data="dictList"
        height="700"
        style="width: 100%">
      <el-table-column
          label="字典编号"
          width="250"
          align="center">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.id }}</span>
        </template>
      </el-table-column>
      <el-table-column
          label="字典编码"
          width="300"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.dictCode }}</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column
          label="字典描述"
          width="300"
          align="center">
        <template slot-scope="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.dictDesc }}</el-tag>
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
  name: "SysDictList",
  data() {
    return {
      dictList: [],
      allParentDict: [],
      SysDic: {},
      activeName: 'first',
      sysDictAddVisible: false,
      parentMenuList: [],
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
    window.document.title = "系统字典"
    this.changeCurrentPageHandler(1)
  },

  methods: {


    handleDelete(index, data) {
      this.httpRequest.post("sysDict/deleteMenu", {"id": data.id}).then(response => {
        this.changeCurrentPageHandler(1)
      })
    },


    changeCurrentPageHandler(currentPage) {
      // this.httpRequest.get("menu/menusPage?page=" + currentPage +
      //     "&limit=" + this.pagination.pageSize +
      //     "&orderFiled=id" +
      //     "&orderType=1")
      //     .then(response => {
      //       this.pagination.currentPage = response.data.dictList.currentPage
      //       this.pagination.pageSize = response.data.dictList.pageSize
      //       this.pagination.total = response.data.dictList.totalSize
      //       this.pagination.totalPage = response.data.dictList.totalPage
      //       this.dictList = response.data.dictList.resultList
      //       // console.log(response)
      //     })

    },


    addDict() {

      let params = {
        "dictCode": this.SysDic.dictCode,
        "dictValue": this.SysDic.dictValue,
        "dictDesc": this.SysDic.dictDesc,
        "parentCode": this.SysDic.parentCode,
      }

      this.httpRequest.post('sysDict/addDict', params)
          .then((response) => {
            this.sysDictAddVisible = false
            this.SysDic = {}
            this.changeCurrentPageHandler(1)
          })
    },


    getAllParentDict() {

      this.httpRequest.get('sysDict/parentSysDictList')
          .then((response) => {
            this.allParentDict = response.data.sysDictList
          })
    },

    showSysDictAddForm() {
      this.getAllParentDict()
      this.sysDictAddVisible = true
    },

    addHandleClose() {
      this.sysDictAddVisible = false
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
