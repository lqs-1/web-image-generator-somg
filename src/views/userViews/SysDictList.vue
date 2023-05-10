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

    <el-select class="dictSelector" v-model="type" placeholder="请选择字典类型">
      <el-option
          v-for="item in dictType"
          :key="item.value"
          :label="item.desc"
          :value="item.value"
          :disabled="item.disabled"
          @click.native="changeCurrentPageHandler(1)">
      </el-option>
    </el-select>

    <el-select class="dictSelector" v-if="isSon" v-model="parentId" placeholder="请选择根字典">
      <el-option
          v-for="item in allParentDict"
          :key="item.dictCode"
          :label="item.dictDesc"
          :value="item.id"
          :disabled="item.disabled"
          @click.native="changeCurrentPageHandler(1)">
      </el-option>
    </el-select>


    <el-table
        :data="dictList"
        height="700"
        style="width: 100%">
      <el-table-column
          label="字典编号"
          width="300"
          align="center">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.id }}</span>
        </template>
      </el-table-column>
      <el-table-column
          label="字典编码"
          width="400"
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
              @click="handleEdit(scope.$index, scope.row)">修改
          </el-button>
          <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>


    <!--  字典编辑-->
    <el-dialog
        title="字典编辑"
        :visible="dictEditVisible"
        width="30%"
        :before-close="editHandleClose">

      <span>
          <el-form ref="editForm" :model="currentDict" label-width="80px">
            <el-form-item label="字典id" prop="id">
              <el-input v-model="currentDict.id" :disabled="true"></el-input>
            </el-form-item>
            <el-form-item label="字典编码" prop="dictCode">
              <el-input type="text" v-model="currentDict.dictCode"></el-input>
            </el-form-item>
            <el-form-item label="字典值" prop="dictValue" v-if="type==1">
              <el-input type="text" v-model="currentDict.dictValue"></el-input>
            </el-form-item>
            <el-form-item label="字典描述" prop="dictDesc">
              <el-input type="text" v-model="currentDict.dictDesc"></el-input>
            </el-form-item>
          </el-form>
      </span>

      <span slot="footer" class="dialog-footer">
    <el-button @click="dictEditVisible = false">取 消</el-button>
    <el-button type="primary" @click="editDict">修改</el-button>
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
  name: "SysDictList",
  data() {
    return {
      dictList: [],
      allParentDict: [],
      SysDic: {},
      dictType: [
        {desc: "根字典", value: "0"},
        {desc: "子字典", value: "1"},
      ],
      type: "",
      isSon: false,
      parentId: "",
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

      dictEditVisible: false,
      currentDict: {}

    }
  },

  mounted() {

  },

  created() {
    window.document.title = "系统字典"
    this.type = "0"
    this.changeCurrentPageHandler(1)
  },

  methods: {


    handleDelete(index, data) {
      this.httpRequest.post("sysDict/deleteDict/" + data.id).then(response => {
        this.changeCurrentPageHandler(1)
      })
    },

    editHandleClose() {
      this.dictEditVisible = false
    },


    handleEdit(index, data) {
      console.log(data)
      this.currentDict = data
      this.dictEditVisible = true

    },


    editDict() {

      // console.log(this.userForm)
      this.httpRequest.post("sysDict/editDict", this.currentDict).then(response => {
        this.changeCurrentPageHandler(1)
        this.currentDict = {}
        this.dictEditVisible = false
      })
  },


  changeCurrentPageHandler(currentPage) {

    // console.log(this.type)
    if (this.type == 1 && this.isSon == false) {
      this.dictList = []
      this.isSon = true
      this.getAllParentDict()
    }
    if (this.type == 0 && this.isSon == true) {
      this.parentId = ""
      this.isSon = false
    }

    if (this.type == 0 || (this.parentId != "" && this.type == 1)) {
      this.httpRequest.get("sysDict/selectDict?page=" + currentPage +
          "&limit=" + this.pagination.pageSize +
          "&orderFiled=id" +
          "&orderType=1" + "&type=" + this.type + "&parentId=" + this.parentId)
          .then(response => {
            this.pagination.currentPage = response.data.dictList.currentPage
            this.pagination.pageSize = response.data.dictList.pageSize
            this.pagination.total = response.data.dictList.totalSize
            this.pagination.totalPage = response.data.dictList.totalPage
            this.dictList = response.data.dictList.resultList
            // console.log(response)
          })
    }

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

  // 字典类型发生改变
  selectType() {

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
    // console.log(tab, event);
  },

}


}
</script>

<style scoped>

.dictSelector{
  float: right;
}

</style>
