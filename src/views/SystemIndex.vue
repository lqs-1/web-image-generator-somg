<template>
  <div>
    <h2 align="center" style="font-family: 楷体">系统视图</h2>
    <!-- 为 ECharts 准备一个定义了宽高的 DOM -->
    <div id="statisticalOne" style="width: 600px;height:400px; float: left; left: 10%; margin-top: 10%"></div>
    <div id="statisticalTwo" style="width: 600px;height:400px; float: left; left: 10%; margin-top: 10%"></div>
  </div>
</template>

<script>
export default {
  name: "SystemIndex",

  data() {
    return {
      allStatisticalData:[],
      currentStatisticalData:[]
      }
    },

  created() {
    window.document.title = "系统首页"


  },

  beforeMount() {

  },

  beforeCreate() {


  },
  async mounted() {
    await this.requestAllStatisticalData()
    await this.requestCurrentStatisticalData()

    if (localStorage.getItem("token") != null){
      this.statisticalOne();
    }
    this.statisticalTwo()

  },

  methods:{

    async requestAllStatisticalData(){
      await this.httpRequest.get("/allStatistical/allStatisticalData?currentUser=" + false)
          .then(response => {
            if (response != null){
              this.allStatisticalData = response.data.statisticalAllDataList
            }

          })
    },


    async requestCurrentStatisticalData(){
      await this.httpRequest.get("/allStatistical/allStatisticalData?currentUser=" + true)
          .then(response => {
            if (response != null){
              this.currentStatisticalData = response.data.statisticalAllDataList
            }

          })
    },



    statisticalOne(){
      var statisticalOne = this.$echarts.init(document.getElementById('statisticalOne'));


      // 指定图表的配置项和数据
      var option = {
        title: {
          text: '整站用户数据',
          subtext: '统计',
          left: 'center'
        },
        tooltip: {
          trigger: 'item'
        },
        legend: {
          orient: 'vertical',
          left: 'left'
        },
        series: [
          {
            name: '所有',
            type: 'pie',
            radius: '60%',
            data: this.allStatisticalData,
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }
        ]
      };

      // 使用刚指定的配置项和数据显示图表。
      statisticalOne.setOption(option);
    },


    statisticalTwo(){
      var statisticalTwo = this.$echarts.init(document.getElementById('statisticalTwo'));


      // 指定图表的配置项和数据
      var option = {
        title: {
          text: '当前用户数据',
          subtext: '统计',
          left: 'center'
        },
        tooltip: {
          trigger: 'item'
        },
        legend: {
          orient: 'vertical',
          left: 'right'
        },
        series: [
          {
            name: '我的',
            type: 'pie',
            radius: '60%',
            data: this.currentStatisticalData,
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }
        ]
      };

      // 使用刚指定的配置项和数据显示图表。
      statisticalTwo.setOption(option);
    },


  }



}
</script>

<style scoped>

</style>
