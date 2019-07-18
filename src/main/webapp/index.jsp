<%--
  Created by IntelliJ IDEA.
  User: liangqi
  Date: 2019/5/19
  Time: 21:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>展示所有员工信息</title>
    <script src="${APP_PATH}/static/js/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <%
        //request.getServletContext().setAttribute("APP_PATH", request.getContextPath());
        application.setAttribute("APP_PATH", request.getContextPath());//在ServletContext域对象中存放项目名称。
    %>
</head>
<body>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <!--模态框首部-->
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <!--模态框主体-->
            <div class="modal-body">
                <form class="form-horizontal">
                    <!--员工姓名境况框  //要求empName不能修改，只能展示-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                           <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <!--显示电子邮件Input-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <!--性别信息Input-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <!--部门信息Select-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门ID即可-->
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <!-- 模态框的 关闭、保存Button-->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <!--模态框首部-->
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <!--模态框主体-->
            <div class="modal-body">
                <form class="form-horizontal">
                    <!--员工姓名Input-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <!--显示电子邮件Input-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <!--性别信息Input-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <!--部门信息Select-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门ID即可-->
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <!-- 模态框的 关闭、保存Button-->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>




<!--使用bootstrap搭建显示页面-->
<div class="container">
    <!--标题行-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--显示按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn" data-toggle="modal" data-target="#myModal">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!--分页条-->
    <div class="row">
        <!--分页信息-->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!--导航条信息-->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>


<!-- 发送Ajax请求 -->
<script type="text/javascript">
    // 1、页面加载完成以后，直接去发送Ajax请求、得到分页数据
    $(function () {
        //页面一加载，就去首页。
        to_page(1);
    });

    //定义一个全局变量，记录总的记录数
    var totalRecord;

    //定义全局变量，记录当前的页面是第几页
    var currentPage;

    /**
     * 2、发送请求，跳转到指定数据页进行展示。
     */
    function to_page(pn){
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function(result){ //result：响应成功后服务器传给浏览器的 JSON格式的字符串数据。
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示 分页信息
                build_page_info(result);
                //3、解析并显示 导航条
                build_page_nav(result);
            }
        });
    }
    /**
     * 2.1构建显示员工数据
     * @param result //result是：服务器返回的JSON格式的字符串 Msg。
     */
    function build_emps_table(result) {
        //每一次展示数据之前，都要清空table表格中的元素。
        $("#emps_table tbody").empty();
        //从JSON字符串中 取出
        var emps = result.extend.pageInfo.list;
        // 遍历员工数据 //每遍历一个对象获取的信息，就传给function回调函数。index：对象的索引。item：代表对象。
        $.each(emps,function (index,item) {
            var checkboxTd = $("<td><input type='checkbox' class='checkbox_item'></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var gender = item.gender=='M'?"男":"女";
            var genderTd = $("<td></td>").append(gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //给编辑按钮 添加一个自定义的属性，来表示当前员工的id。
            editBtn.attr("edit-id",item.empId);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //给删除按钮 添加一个自定义属性，员工id
            delBtn.attr("del_id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append() 每次调用结束后返回的还是当前对象。
            $("<tr></tr>").append(checkboxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    /**
     * 2.2构建显示分页信息
     * @param result
     */
    function build_page_info(result) {
        //清空分页信息
        $("#page_info_area").empty();
        //显示 分页信息
        $("#page_info_area").append("当前是第 " + result.extend.pageInfo.pageNum
            +" 页,总共是 " + result.extend.pageInfo.pages
            +" 页,总记录数为：" + result.extend.pageInfo.total +" 。");
        //记录总的记录数
        totalRecord = result.extend.pageInfo.total;
        //记录当前页面是第几页
        currentPage = result.extend.pageInfo.pageNum;
    }
    
    /**
     * 2.3构建显示 导航条
     * @param result
     */
    function build_page_nav(result) {
        //清空导航条元素数据
        $("#page_nav_area").empty();

        //创建一个ul
        var ul = $("<ul></ul>").addClass("pagination");
        //构造 首位页、前一页后一页li
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePage = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));

        //判断有没有前一页，没有就让按钮禁用
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePage.addClass("disabled");
        }else{
            //给首页、前一页li添加单击事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePage.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }

        var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

        //判断有没有下一页
        if(result.extend.pageInfo.hasNextPage == false){
            lastPageLi.addClass("disabled");
            nextPage.addClass("disabled");
        }else{
            //给末页、下一页li添加单击事件
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nextPage.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
        }
        //添加首页和前一页li 到ul中
        ul.append(firstPageLi).append(prePage);

        // 遍历页码li 1 2 3,添加到ul中
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            //遍历的页码是 当前页码，则高亮显示。
            if(item == result.extend.pageInfo.pageNum){
                numLi.addClass("active");
            }
            //给页码li添加单击事件
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });

        //添加下一页 和 末页li
        ul.append(nextPage).append(lastPageLi);
        //把ul 添加到nav元素中
        var navEle = $("<nav></nav>").append(ul);
        //把nav加入到 导航条区域
        navEle.appendTo("#page_nav_area");
    }

    /**
     * 3、点击新增按钮，弹出模态框
     */
    $("#emp_add_modal_btn").click(function () {
        //每次弹出模态框之前，清除表单数据 和 所有提示信息及样式。
        reset_form("#empAddModal form");

        //发送Ajax请求，查询出部门信息，生成option元素显示在下拉列表中。
        getDepts("#empAddModal select");

        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static" // 点击模态框的其他位置，模态框不会关闭。
        });
    });
    //3.1每次弹出模态框之前，清除表单数据 和 所有提示信息及样式。
    function reset_form(ele){
        //1.清除表单数据
        $(ele)[0].reset();//获取表单对象，把表单对象转为JS的DOM对象，调用DOM对象的reset方法，重置表单数据。
        //2.清空表单的文字提示 和样式提示。
        $(ele).find(".help-block").text("");
        $(ele).find("*").removeClass("has-success has-error")

    }
    //3.2发送Ajax请求，查出所有的部门信息，生成option元素在下拉列表中。
    // 返回的部门信息的JSON数据。
            // {
            // "code":100,
            // "msg":"执行成功...",
            // "extend":
            //      {"depts": // 值是数组
            //          [
            //              {"deptId":1,"deptName":"开发部"},
            //              {"deptId":2,"deptName":"测试部"}
            //          ]
            //      }
            // }
    //部门select中，显示的是每个部门的deptName，提交数据时，提交的是部门的deptId。
    function getDepts(ele) {
        //每次重新生成<select>元素中的<option>元素时，都要先清空<select>元素中的内容，等待重新生成。
        $(ele).empty();
        //发送Ajax请求，生成<select>元素中的option。
        $.ajax({
            url:"${APP_PATH}/depts", //发送请求给/depts
            type:"GET",
            success:function (result) {
                //result的结果是返回的json格式的字符串数据。
                $.each(result.extend.depts,function () { // 回调函数中可以不传递参数，在函数中使用this代表当前遍历的每一个Department对象。
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    /**
     * 3.3点击保存按钮，保存员工。
     * $("#empAddModal form").serialize(); // 返回的结果为：deptName=小美 & emial=123@qq.com
     *      提取表单的数据为key-value的形式，用于Ajax请求。
     * */
    $("#emp_save_btn").click(function () {
        //1.前端校验。先对要提交给服务器的 数据格式进行前端校验。//定义一个校验方法
        /*if(!validate_add_form()){ // 格式不正确，返回false，结束方法。
            return false;
        }*/
        //2.发送Ajax校验。对用户名的数据的合法性进行后端校验。(数据是否可用)
        if($(this).attr("ajax-va") == "error"){
            return false;
        }

        //3.发送Ajax请求保存员工。将模态框中填写的表单数据交给服务器进行保存
        $.ajax({
            url:"${APP_PATH}/emps",
            type:"POST",
            data:$("#empAddModal form").serialize(),//把表单数据进行序列化为key-value形式。
            success:function (result) {
                //后端验证通过
                if (result.code == 100) {
                    //员工保存成功之后，关闭模态框并跳转到最新数据行 .modal('hide')
                    //1.关闭模态框
                    $("#empAddModal").modal('hide');
                    //2.来到最后一页，显示刚才保存的数据
                    to_page(totalRecord);
                } else {//后端验证不通过
                    //哪个字段验证不通过，就显示哪个字段的错误信息.//验证通过，返回值为undefined，验证不通过，返回值为字段的错误信息
                    if(undefined != result.extend.errorFields.email){
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);

                    }
                }
            }
        });
    });
    //3.4校验表单数据的格式是否正确
    function validate_add_form(){
        //拿到要校验的数据，使用正则表达式.
        //1.校验用户名（此部分校验，在与Ajax数据校验一起完成）
        //2.校验邮箱数据格式。并展示对应的样式。
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        var regEmailBool = true;
        if(!regEmail.test(email)){
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            regEmailBool = false;
        }else{
            show_validate_msg("#email_add_input","success","");
        }
        //每项信息都验证成功，返回true。
        return regEmailBool;
    }
    //3.5抽取：给每个表单元素添加校验的文字提示 和样式提示。//在添加校验提示之前，清除他的所有的校验样式。
    function show_validate_msg(ele,status,msg) {
        //在添加校验提示之前，清除他的所有的校验样式。
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next().text("");
        //验证开始。
        if("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next().text(msg);
        }else if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next().text(msg);
        }
    }
    //3.6校验数据库中是否有该empName。
    $("#empName_add_input").change(function () {
        //发送Ajax请求 校验用户名是否可用
        var empName = this.value;//获取表单的内容时，用value属性。
        $.ajax({
            url:"${APP_PATH}/checkUser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if(result.code == 100){//Name可用。
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });

    //4、更新操作
    //4.1、给编辑按钮绑定单击事件。
    //(button元素是在页面加载完成之后，发送的Ajax请求，才创建的button元素),因此，我们给元素绑定事件的时候，该元素还不存在，因此绑定不上。
    //【办法】 1）可以在创建button元素时，给button元素绑定事件。//不同模块间耦合度太大（不推荐）。
    //      2）可以使用live()方法，最新改用on()替代这个元素，在任何时候创建的button元素 都能够响应这个事件。
    $(document).on("click",".edit_btn",function () {
        //1、查出部门信息，并显示部门列表
        getDepts("#empUpdateModal select");
        //2、查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        //3、把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("update-id",$(this).attr("edit-id"));
        //4、再弹出模态框。
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop:"static", // 点击模态框的其他位置，模态框不会关闭。
        });
    });
    /**
     * 4.2、查询指定id的员工信息，并展示到模态框的表单中。
     */
    function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emp/" + id,
            type:"GET",
            success:function (result) {
                //在模态框的表单中展示数据
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    /**
     * 4.3、点击Update更新按钮，更新员工信息
     * 方式一：1、把POST请求，转为PUT请求。
     *      type:"POST",
     *      data:$("#empUpdateModal form").serialize() + "&_method=PUT",
     *      然后Controller写PUT方法。
     *      2、web.xml中配置过滤器。
     *
     * 方式二：直接发送PUT请求。
     *      1、type:"PUT",
     *      2、在web.xml中配置另一个过滤器。
     */
    $("#emp_update_btn").click(function () {

        alert($("#empUpdateModal form").serialize());
        //1、验证邮箱格式是否合法 并展示对应的样式。
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_add_input","success","");
        }

        //2、发送Ajax请求，保存修改过的数据。
        $.ajax({
            url:"${APP_PATH}/emp/" + $(this).attr("update-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                //1.关闭模态框
                $("#empUpdateModal").modal('hide');
                //2.来到最后一页，显示刚才保存的数据
                to_page(currentPage);
            }
        });
    });


    /**
     * 5.删除员工
     */
    //5.1给所有的删除按钮绑定
    $(document).on("click",".delete_btn",function () {
        //1、弹出确认删除对话框   $(this)———>哪个按钮触发的事件，$(this)就代表的是哪个按钮。
        var empName = $(this).parents("tr").find("td:eq(1)").text();
        if(confirm("确认删除【" + empName + "】吗？")){
            //当点击的确认，就发送ajax请求删除即可。
            $.ajax({
                url:"${APP_PATH}/emp/" + $(this).parents("tr").find("td:eq(1)").text(),
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //返回到当前页面
                    to_page(currentPage);
                }
            });
        }
    });
    //5.2表头的checkbox 全选/全不选功能。
    $("#check_all").click(function () {
        /**
         attr获取checked的结果总是undefined。
         //获取自定义属性的值使用：attr();
         //而获取和修改dom元素 原生的属性使用：prop();
         */
        //当点击全选按钮时,表格中的每行数据都要是全选状态。
        $(".checkbox_item").prop("checked",$(this).prop("checked"));

    });
    //5.3给每一条记录的checkbox都添加事件
    $(document).on("click",".checkbox_item",function () {
        //判断当前记录是否都被勾选了。若都勾选了，则勾选全选框。
        if($(".checkbox_item:checked").length == $(".checkbox_item").length){
            $("#check_all").prop("checked",true);
        }else{
            $("#check_all").prop("checked",false);
        }
    });
    //5.4点击删除按钮  ， 批量删除记录.//遍历每一个勾选的checkbox  $(this)————>代表每一个checkbox元素。
    $("#emp_delete_all_btn").click(function () {
        //获取要删除的多个员工的Name、id。
        var empNames = "";
        var empIds = "";
        $.each($(".checkbox_item:checked"),function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        empNames = empNames.substring(0,empNames.length-1);
        empIds = empIds.substring(0,empIds.length-1);
        alert(empIds);
        if(confirm("确定要删除【" + empNames + " 】 吗？")){
            //确认删除，则发送Ajax请求，进行删除
            $.ajax({
                url:"${APP_PATH}/emp/" + empIds,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //更新删除后的数据展示
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
