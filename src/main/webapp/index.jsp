<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


<%--员工添加的model--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@ultrapower.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="true">男
                            </label>
                            <input type="radio" name="gender" id="gender2_add_input" value="F">女
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--<input type="text" name="did" class="form-control" id="deptname_add_select" >--%>
                            <select class="form-control" name="dId"></select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="col-md-4 col-md-offset-10">
        <button class="btn btn-primary btn-sm" id="emp_add_model_btn">新增</button>
        <button class="btn btn-danger btn-sm">删除</button>
    </div>
</div>
<dev class="row">
    <dev class="col-md-12">
        <table class="table table-striped table-hover" id="emps_table">
            <thead>
            <tr>
                <th>##</th>
                <th>empName</th>
                <th>gender</th>
                <th>email</th>
                <th>deptName</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </dev>
</dev>
<div class="col-md-6" id="page_info_area"></div>
<div class="row">
    <div class="col-md-6" id="page_nav_area">

    </div>

</div>
<script type="text/javascript" >
    var pageTotal;
    //1.页面加载完成后，直接发送一个ajax请求要到分页数据
    $(function(){
        //去首页
        to_page(1);
    });

    
    function to_page(pn) {
        $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"GET",
                success:function (result) {
//                console.log(result);
//                1.解析并显示员工表格数据
                    build_emps_table(result);
//                2.解析并显示分页
                    build_page_info(result);
//                3.解析显示分页条数据
                    build_page_nav(result);
                }
            }
        );
    }
    
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps=result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
//            alert(item.empName);
            var empIdTd =$("<td></td>").append(item.empId);
            var empNameTd =$("<td></td>").append(item.empName);
            var genderTd =$("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd =$("<td></td>").append(item.email);
            var deptNameTd =$("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");

            var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            $("<tr></tr>").append(empIdTd).append(empNameTd).append(genderTd)
                .append(emailTd).append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");

        })

    }
//    解析显示分页信息的配置
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页,总页数"
            + result.extend.pageInfo.pages+",总记录数："+result.extend.pageInfo.total)

        pageTotal = result.extend.pageInfo.total;
    }
//    解析并显示导航条
    function build_page_nav(result) {
        //page_nav_area
        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        if(result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled")
            prePageLi.addClass("disabled");
        }else {
            firstPageLi.click(function () {
                to_page(1);
            });

            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage==false){
            nextPageLi.addClass("disabled")
            lastPageLi.addClass("disabled");
        }else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2，3遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function(index,item){

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
            numLi.addClass("active");
        }
        numLi.click(function(){
            to_page(item);
        });
            ul.append(numLi);
        });
        //添加下一页和末页 的提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
//    完整的清空表单样式及内容
    function reset_form(ele) {
//       清空表单数据
        $(ele)[0].reset();
//       清空表单样式
        $(ele).find("*").removeClass("has_error has_success");
//        清空表单中所有的信息提示框
        $(ele).find(".help-block").text("");
    }
    
    $("#emp_add_model_btn").click(function () {
//        清除表单数据
//        $("#empAddModal form")[0].reset();
        reset_form("#empAddModal form");
        getDepts();
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });
    
    function  getDepts() {
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
//                console.log(result)
//                $("#deptname_add_select")
                $.each(result.extend.depts,function () {

                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo("#empAddModal select");
//                   console.log(this.deptName)
                })
            }
            }
        );
    }

    //校验表单数据
    function  validata_add_form() {

       var empName= $("#empName_add_input").val();
       var regName =/^[a-zA-Z0-9_-]{4,16}$|[\u4E00-\u9FA5]/;
       if(!regName.test(empName)){
//           alert("用户名格式问题");
           show_validate_msg("#empName_add_input","error","用户名格式输入错误！！");
           return false;
       }

       var email=$("#email_add_input").val();
       var regEmail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
        if(!regEmail.test(email)){
//           alert("邮箱地址错误。");
           show_validate_msg("#email_add_input","error","邮箱格式输入错误！！");
           return false;
        }

    }
    
    function  show_validate_msg(ele,status,msg) {

//        校验之前将原有的格式去除掉。
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next().text("");

        if (status=="success"){
            $(ele).parent().addClass("has-success ");
            $(ele).next("span").text("");
        }else if(status == "error"){
            $(ele).parent().addClass("has-error ");
            $(ele).next("span").text("");
        }
        
    }
//单击按钮保存表单数据方法
    $("#emp_save_btn").click(function () {
//        模态框中填写的数据进行校验。
            if(!validata_add_form()){
                return false;
            }
//            验证标签中的ajax-val是否是success
            if ($(this).attr("ajax-va")=="error"){
                return false;
            }

//         对提交给服务器的数据进行校验

//     1.   模态框中的保存方法
//        2.发送ajax请求，保存员工
//        alert($("#empAddModal form").serialize());
     $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
//                关闭模态框
                $("#empAddModal").modal('hide');
//                发送ajax请求到达最后一页
                to_page(pageTotal);
            }
        });

    });

//    验证员工姓名是否可用
    $("#empName_add_input").change(function () {
        var empname=this.value;
        $.ajax({
            url:"${APP_PATH}/checkempname",
            data:"empname="+empname,
            type:"POST",
            success:function (result) {
                if (result.code==200){
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }else{
                    show_validate_msg("#empName_add_input","success",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","success");
                }
            }
        })
    })
</script>
</body>
</html>
