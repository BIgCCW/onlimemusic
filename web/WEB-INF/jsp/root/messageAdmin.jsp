<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 86188
  Date: 2021/6/1
  Time: 9:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>留言管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- 页面的宽度与设备屏幕的宽度一致
         初始缩放比例 1:1 -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<script>
    $(function () {
        $('.delete').click(function () {
            let id = $(this).attr("value")
            $(this).attr('id', 'del');
            del(id);
        });

        function del(id) {
            $.ajax({
                url: "${pageContext.request.contextPath}/root/deleteMessage",
                data: {'sid': id},
                type: "post",
                async: true,
                success: function () {
                    $('#del').parent().parent().remove()
                }
            })
        }
    })
</script>
<body>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <h3 class="text-center" style="color: red;font-family: KaiTi">
                留言管理
            </h3>
            <br>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>
                       id
                    </th>
                    <th>
                       留言内容
                    </th>
                    <th>
                        用户
                    </th>
                    <th>
                        操作
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="message" items="${requestScope.get('messages')}">
                <tr>
                    <td  width="15%">
                        ${message.getId()}
                    </td>
                    <td  width="35%">
                            ${message.getText()}
                    </td>
                    <td  width="25%">
                            ${message.getName()}
                    </td>
                    <td  width="25%">
                        <button value="${message.getId()}" class="btn  btn-danger delete">删除</button>
                    </td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
