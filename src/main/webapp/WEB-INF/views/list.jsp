<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%--web路径： 以/ 开始的相对路径，找资源，以当前资源路径为基础，经常出现错误，以/开头的相对路径，找资源，以服务器的路径为标准，（http://localhost:8080/crud）
    需要添加项目名才能正确找到项目--%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <% request.setAttribute("APP_PATH", request.getContextPath()); %>
    <script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="col-md-4 col-md-offset-10">
        <button class="btn btn-primary btn-sm">新增</button>
        <button class="btn btn-danger btn-sm">删除</button>
    </div>
</div>
<dev class="row">
    <dev class="col-md-12">
        <table class="table table-striped table-hover">
            <tr>
                <th>##</th>
                <th>empName</th>
                <th>gender</th>
                <th>email</th>
                <th>deptName</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${pageInfo.list }" var="emp">
                <tr>
                    <th>${emp.empId}</th>
                    <th>${emp.empName}</th>
                    <th>${emp.gender=="M"?"男":"女"}</th>
                    <th>${emp.email}</th>
                    <th>${emp.department.deptName}</th>
                    <th>
                        <button class="btn btn-danger btn-sm">
                            <span class="glyphicon glyphicon-pencil"></span>
                            编辑
                        </button>
                        <button class="btn btn-primary btn-sm">
                            <span class="glyphicon glyphicon-trash"></span>
                            删除
                        </button>
                    </th>
                </tr>
            </c:forEach>

        </table>
    </dev>
</dev>
<div class="col-md-6">当前第${pageInfo.pageNum}页,总${pageInfo.pages}页数,总记录数：${pageInfo.total}</div>
<div class="row">
    <div class="col-md-6">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li>
                    <a href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                    <c:if test="${page_NUM==pageInfo.pageNum}">
                        <li class="active"><a href="#">${pageNum}</a></li>
                    </c:if>
                    <li><a href="#">${pageNum}</a></li>
                </c:forEach>

                <li>
                    <a href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>

</div>
</body>
</html>
