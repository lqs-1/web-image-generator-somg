<template>
  <div>
    <el-table
        :data="tableData"
        style="width: 100%"
        :row-class-name="tableRowClassName">
        <el-table-column
            align="center"
            prop="interfaceName"
            label="地址"
            width="700">
        </el-table-column>
      <el-table-column
          align="center"
          prop="desc"
          label="备注"
          width="700">
      </el-table-column>
    </el-table>

  </div>
</template>


<script>
export default {
  name: "DocumentView",
  data() {
    return {
      tableData: [
        {
          interfaceName: 'http://www.nobibibi.top/#/doc',
          desc: '端口文档地址',
        },
        {
          interfaceName: 'http://www.nobibibi.top',
          desc: '工具网站地址 游客登录账号guest 密码initsomg',
        },
        {
          interfaceName: 'http://www.nobibibi.top:8888',
          desc: '图片上传体验地址',
        },
        {
          interfaceName: 'http://www.nobibibi.top/logs',
          desc: '系统日志地址',
        },
        {
          interfaceName: 'http://www.nobibibi.top/somg',
          desc: '缩放图片存放地址',
        },
        {
          interfaceName: 'http://www.nobibibi.top:8888/swagger-ui/index.html',
          desc: '系统接口文档地址',
        },
        {
          interfaceName: 'http://www.nobibibi.top:1314',
          desc: 'ssh网页版地址',
        },
        {
          interfaceName: 'http://www.nobibibi.top:10824',
          desc: 'Chat2DB地址',
        },
      ]
    }
  },

  mounted() {

  },

  created() {
    window.document.title = "端口文档"

  },

  methods: {
    tableRowClassName({row, rowIndex}) {
      if (rowIndex === 1) {
        return 'warning-row';
      } else if (rowIndex === 3) {
        return 'success-row';
      }
      return '';
    }
  }


}
</script>

<style scoped>
.el-table .warning-row {
  background: oldlace;
}

.el-table .success-row {
  background: #f0f9eb;
}
</style>
