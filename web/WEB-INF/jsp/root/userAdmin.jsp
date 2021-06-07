<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 86188
  Date: 2021/6/1
  Time: 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户管理</title>
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
            let b = confirm(`您确定要注销该用户吗`);
            if (b){
                let name = $(this).attr("value")
                $(this).attr('id', 'del');
                del(name);
            }
        });

        function del(name) {
            $.ajax({
                url: "${pageContext.request.contextPath}/root/agreeAccount",
                data: {'name': name},
                type: "post",
                async: true,
                success: function () {
                    $('#del').parent().parent().remove()
                }
            })
        }

        //重置
        $('.update').click(function () {
            let b = confirm(`您确定要重置该用户密码吗`);
            if (b){
                let name = $(this).attr("value")
                $(this).attr('id', 'del');
                update(name);
            }
        });

        function update(name) {
            $.ajax({
                url: "${pageContext.request.contextPath}/root/updatePwd",
                data: {'name': name},
                type: "post",
                async: true,
                success: function () {
                    $('#del').parent().prevAll('.Pwd').text("123456w")
                }
            })
        }

        //管理
        $('.jurUp').click(function () {
                $(this).parent().prev().children('form').css('display','block')
                $(this).parent().prev().children('span').css('display','none')
                $(this).parent().css('display','none')
                $(this).parent().next().css('display','')
                $(this).parent().parent().attr('class','danger')
        });
        //管理
        $('.cancel').click(function () {
            $(this).parent().prevAll('.jur').children('form').css('display','none')
            $(this).parent().prevAll('.jur').children('span').css('display','')
            $(this).parent().prev().css('display','')
            $(this).parent().css('display','none')
            $(this).parent().parent().attr('class','')
        })

        $('.updateJur').click(function () {
            let b1 = confirm("您确定要更改此用户权限吗");
            if (!b1) {
                return;
            }
            $(this).parent().prevAll('.jur').children('form').submit()
        })
    })
</script>

<body>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <h3 class="text-center" style="color: red;font-family: KaiTi">
                用户管理
            </h3>
            <h3 class="text-center" style="color: red;font-family: KaiTi">
                重置的密码默认为123456w
            </h3>
            <br>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>
                        用户名
                    </th>
                    <th>
                        密码
                    </th>
                    <th>
                        权限
                    </th>
                    <th>
                        操作
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${requestScope.get('userAdmin')}">
                    <tr>
                        <td  width="25%">
                                ${user.getUsername()}
                        </td>
                        <td  width="25%" class="Pwd">
                                ${user.getPassword()}
                        </td>
                        <td  width="25%" class="jur">
                            <span>${user.getJurisdiction()}</span>
                            <form style="display: none" action="${pageContext.request.contextPath}/root/jurAdmin" method="post">
                                <div class="form-group" >
                                    <label >选择权限</label><br>
                                        <select name="jur">
                                            <option selected="selected" value="订阅者">订阅者</option>
                                            <option value="管理员">管理员</option>
                                            <option value="超级管理员">超级管理员</option>
                                        </select>
                                </div>
                                <div style="display: none" class="form-group">
                                    <input name="name" value="${user.getUsername()}">
                                </div>
                            </form>
                        </td>
                        <td  width="25%">
                            <button value="${user.getUsername()}" class="btn  btn-danger delete">注销用户</button>
                            <button value="${user.getUsername()}" class="btn  btn-success update">重置密码</button>
                            <button value="${user.getJurisdiction()}" class="btn  btn-info jurUp">管理权限</button>
                        </td>
                        <td style="display: none" width="25%">
                            <button value="${user.getId()}" class="btn  btn-success updateJur">更新</button>
                            <button class="btn  btn-danger cancel">取消</button>
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
