<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2024/1/8
  Time: 19:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>排班信息管理</title>
  <link href="//cdn.staticfile.org/layui/2.9.3/css/layui.css" rel="stylesheet">
</head>

<body>
<div class="layui-padding-3">
  <h2 style="padding-bottom: 20px">
    排班信息管理
  </h2>
  <table class="layui-table" lay-skin="line" id="test" lay-filter="test"></table>
</div>

<script type="text/html" id="barDemo">
  <div class="layui-clear-space">
    <a class="layui-btn layui-btn-xs" lay-event="delete">取消排班</a>
  </div>
</script>

<script src="https://cdn.staticfile.org/layui/2.9.0/layui.js"></script>
<script>
  layui.use(['table', 'dropdown'], function(){
    var table = layui.table;
    var dropdown = layui.dropdown;
    var form = layui.form;

    // 创建渲染实例
    table.render({
      elem: '#test',
      url: 'http://localhost:8080/PalmHospitalService_war_exploded/ScheduleServlet', // 此处为静态模拟数据，实际使用时需换成真实接口
      toolbar: '#toolbarDemo',
      height: 'full-200', // 最大高度减去其他容器已占有的高度差
      css: [ // 重设当前表格样式
        '.layui-table-tool-temp{padding-right: 1000px;}'
      ].join(''),
      cellMinWidth: 80,
      totalRow: false, // 开启合计行
      page: false,
      cols: [[
        {type: 'checkbox', fixed: 'left'},
        {field:'sid',width:220, title: '排班ID', sort:true},
        {field:'dname',width:220, title: '医生姓名'},
        {field:'departname',width:220, title: '科室名称'},
        {field:'time',width:250, title: '排班时间'},
        {field:'price', title: '挂号价格',width:220},
        {fixed: 'right', title:'操作', width: 80, minWidth: 80, toolbar: '#barDemo'}
      ]],


      done: function(){
        var id = this.id;
        // 下拉按钮测试
        dropdown.render({
          elem: '#dropdownButton', // 可绑定在任意元素中，此处以上述按钮为例
          data: [{
            id: 'add',
            title: '添加'
          },{
            id: 'update',
            title: '编辑'
          },{
            id: 'delete',
            title: '删除'
          }],
          // 菜单被点击的事件
          click: function(obj){
            var checkStatus = table.checkStatus(id)
            var data = checkStatus.data; // 获取选中的数据
            switch(obj.id){
              case 'add':
                layer.open({
                  title: '添加',
                  type: 1,
                  area: ['80%','80%'],
                  content: '<div style="padding: 16px;">自定义表单元素</div>'
                });
                break;
              case 'update':
                if(data.length !== 1) return layer.msg('请选择一行');
                layer.open({
                  title: '编辑',
                  type: 1,
                  area: ['80%','80%'],
                  content: '<div style="padding: 16px;">自定义表单元素</div>'
                });
                break;
              case 'delete':
                if(data.length === 0){
                  return layer.msg('请选择一行');
                }
                layer.msg('delete event');
                break;
            }
          }
        });
      },
      error: function(res, msg){
        console.log(res, msg)
      }
    });

    // 状态 - 开关操作
    form.on('switch(demo-templet-status)', function(){
      var value = this.checked ? 1:0
      var id = this.value;
      var name = this.name;
      var url1
      console.log(name)
      switch (name){
        case 'src':
          url1 = '/api/man/update/src'
          break
        case 'dst':
          url1 = '/api/man/update/dst'
          break
        case 'delivery':
          url1 = '/api/man/update/delivery'
          break;
      }

      console.log(url1)
      url1 += '?id='+id+'&value='+value

      console.log(url1)

      fetch(url1, {
        method: 'GET'
      })
              .then(response => {
                if (!response.ok) {
                  throw new Error('Network response was not ok');
                }
                return response;
              })
              .then(data => {
                console.log('Success:', data);
              })
              .catch(error => {
                console.error('Error:', error);
              });
    });

    // 工具栏事件
    table.on('toolbar(test)', function(obj){
      var id = obj.config.id;
      var checkStatus = table.checkStatus(id);
      // var othis = lay(this);
      switch(obj.event){
        case 'getCheckData':
          var data = checkStatus.data;
          console.log(data)
          if(data.length!==0)
            layer.alert(layui.util.escape(JSON.stringify(data)));
          else
            layer.msg('请选择行', {icon: 0});
          break;
        case 'getData':
          var getData = table.getData(id);
          console.log(getData);
          layer.alert(layui.util.escape(JSON.stringify(getData)));
          break;
      }
    });
    // 表头自定义元素工具事件 --- 2.8.8+
    table.on('colTool(test)', function(obj){
      var event = obj.event;
      console.log(obj);
      if(event === 'email-tips'){
        layer.alert(layui.util.escape(JSON.stringify(obj.col)), {
          title: '当前列属性配置项'
        });
      }
    });

    // 触发单元格工具事件
    table.on('tool(test)', function(obj){ // 双击 toolDouble
      var data = obj.data; // 获得当前行数据
      console.log(data)
      if(obj.event === 'delete'){
        layer.confirm('确定取消排班 [排班ID: '+ data.sid +'] ', function(index){
          const url1 = "http://localhost:8080/PalmHospitalService_war_exploded/DeleteSchedulesServlet?sid=" + data.sid;
          // 使用 Fetch API 发起 DELETE 请求
          fetch(url1, {
            method: 'GET',
          })
                  .then(response => {
                    if (!response.ok) {
                      throw new Error('Network response was not ok');
                    }
                  })
                  .then(() => {
                    obj.del(); // 删除对应行（tr）的DOM结构
                  })
                  .catch(error => {
                    // 请求失败时的处理
                    console.error('There has been a problem with your fetch operation:', error);
                  });

          // obj.del();
          layer.close(index);
          // 向服务端发送删除指令
        })
      }
    });

    // 触发表格复选框选择
    table.on('checkbox(test)', function(obj){
      console.log(obj)
    });

    // 触发表格单选框选择
    table.on('radio(test)', function(obj){
      console.log(obj)
    });

    // 行单击事件
    table.on('row(test)', function(obj){
      obj.setRowChecked({
        type: 'checkbox' // radio 单选模式；checkbox 复选模式
      });

    });
    // 行双击事件
    table.on('rowDouble(test)', function(obj){
      console.log(obj);
    });

    // 单元格编辑事件
    table.on('edit(test)', function(obj){
      var field = obj.field; // 得到字段
      var value = obj.value; // 得到修改后的值
      var data = obj.data; // 得到所在行所有键值


      // 值的校验
      if(field === 'email'){
        if(!/^([a-zA-Z0-9_\\.\-])+\\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(obj.value)){
          layer.tips('输入的邮箱格式不正确，请重新编辑', this, {tips: 1});
          return obj.reedit(); // 重新编辑 -- v2.8.0 新增
        }
      }

      // 使用 Fetch API 发起 POST 请求
      fetch('/api/man/update', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json', // 设置请求头，告知后端发送的是 JSON 数据
        },
        body: JSON.stringify(data),
      })
              .then(response => {
                if (!response.ok) {
                  layer.msg('编辑失败', {icon: 3});
                  throw new Error('Network response was not ok');
                }
              })
              .then(data => {
                // 请求成功后的操作，根据后端返回的数据进行处理
                console.log('Response:', data);
                layer.msg('编辑成功', {icon: 1});
                // 其他更新操作
                var update = {};
                update[field] = value;
                obj.update(update);
              })
              .catch(error => {
                console.error('There has been a problem with your fetch operation:', error);
              });
    });

    // 搜索提交
    form.on('submit(demo-table-search)', function(data){
      var field = data.field; // 获得表单字段
      // 执行搜索重载
      table.reload('test', {
        page: {
          curr: 1 // 重新从第 1 页开始
        },
        where: field // 搜索的字段
      });
      // layer.msg('搜索成功<br>此处为静态模拟数据，实际使用时换成真实接口即可');
      return false; // 阻止默认 form 跳转
    });
  });
</script>

</body>
</html>
