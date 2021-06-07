<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 86188
  Date: 2021/5/30
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>申请管理</title>
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
        //同意提权
        $('.agreeAly').click(function () {
            let names = $(this).attr("value")
            let split = names.split(",");
            let name = split[0];
            let opera = split[1];
            let jur = split[2].split("-")[1];
            del(name,opera,jur);
        });

        function del(name,opera,jur) {
            $.ajax({
                url: "${pageContext.request.contextPath}/root/agreeApply",
                data: {'name': name,'operation':opera,'jur':jur},
                type: "post",
                async: true,
                success: function () {
                    window.location.reload()
                }
            })
        }
        //同意注销
        $('.agreeAco').click(function () {
            let name = $(this).attr("value")
            delAccount(name);
        });

        function delAccount(name) {
            $.ajax({
                url: "${pageContext.request.contextPath}/root/agreeAccount",
                data: {'name': name},
                type: "post",
                async: true,
                success: function () {
                    window.location.reload()
                }
            })
        }

        //拒绝申请
        $('.refuse').click(function () {
            let names = $(this).attr("value")
            let split = names.split(",");
            let name = split[0];
            let opera = split[1];
            refuse(name,opera);
        });

        function refuse(name,opera) {
            $.ajax({
                url: "${pageContext.request.contextPath}/root/refuse",
                data: {'name': name,'operation':opera},
                type: "post",
                async: true,
                success: function () {
                    window.location.reload()
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
                申请管理
            </h3>
            <h4 class="text-center" style="color: red;font-family: KaiTi">
                注意<span style="color: #80bdff">蓝色</span>的为提权申请,<span style="color: yellow">黄色</span>的为注销申请！！！
            </h4>
            <br>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>
                       用户名
                    </th>
                    <th>
                        权限
                    </th>
                    <th>
                        理由申请
                    </th>
                    <th>
                        操作
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="apply" items="${requestScope.get('applies')}">
                    <c:choose>
                        <c:when test="${apply.getOperation()=='提权'}">
                            <tr class="info">
                        </c:when>
                        <c:otherwise>
                            <tr class="warning">
                        </c:otherwise>
                    </c:choose>
                    <td  width="25%">
                        ${apply.getUsername()}
                    </td>
                    <td  width="25%">
                       ${apply.getJurisdiction()}
                    </td>
                    <td  width="25%">
                            ${apply.getReason()}——<span style="color: red">${apply.getOperation()}</span>
                    </td>
                    <td  width="25%">
                    <c:choose>
                        <c:when test="${apply.getOperation()=='提权'}">
                            <button value="${apply.getUsername()},${apply.getOperation()},${apply.getJurisdiction()}" class="btn  btn-primary agreeAly">同意</button>
                        </c:when>
                        <c:otherwise>
                            <button value="${apply.getUsername()}" class="btn  btn-primary agreeAco">同意</button>
                        </c:otherwise>
                    </c:choose>
                        <button value="${apply.getUsername()},${apply.getOperation()}" class="btn  btn-success refuse">拒绝</button>
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
