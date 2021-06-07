<%--
  Created by IntelliJ IDEA.
  User: 86188
  Date: 2021/5/21
  Time: 23:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>个人中心</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<script>
    $(function () {
        $('#modify').click(function () {
            $('#form1').css("display", "")
            $('#show').css("display", "none")
        })
        $('.return').click(function () {
            $('#form1').css("display", "none")
            $('#form2').css("display", "none")
            $('#form3').css("display", "none")
            $('#show').css("display", "")
        })

        $("#updateUser").click(function () {
            $('#form2').css("display", "")
            $('#show').css("display", "none")
        })

        $("#updatePassword").click(function () {
            $('#form3').css("display", "")
            $('#show').css("display", "none")
        })

        $('body').on("blur", "#exampleInputUser1", function () {
            select()
        })

        //用户名
        let nameReg =/^[\u4e00-\u9fa5a-zA-Z0-9_-]{5,12}$/;
        //密码
        let psw =/^(?=.*[a-zA-Z])(?=.*\d)[^]{6,16}$/;
        //邮箱正则
        let email=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;

        let master;
        $('body').on("blur","#exampleInputUser1",function () {
            if (!nameReg.test($(this).val())){
                $('#notUser').css("display","inline")
                master=false;
            }else {
                master=true;
                $('#notUser').css("display","none")
            }
        })

        let emails;
        $('body').on("blur","#text3",function () {
            if (!email.test($(this).val())){
                $(this).next().css("display","inline")
                emails=false;
            }else {
                emails=true;
                $(this).next().css("display","none")
            }
        })

        let pwds;
        $('body').on("blur","#password2",function () {
            if (!psw.test($(this).val())){
                pwds=false;
                $(this).next().css("display","inline")
            }else {
                pwds=true;
                $(this).next().css("display","none")
            }
        })

        let username;

        function select() {
            $.ajax({
                url: "${pageContext.request.contextPath}/selectUser",
                data: {'username': $('#exampleInputUser1').val(), 'password': $('#exampleInputPassword1').val()},
                async: true,
                success: function (result) {
                    if (result == "null") {
                        username = result
                        $('#selectUser').css("display", "none")
                    } else {
                        username = result
                        $('#selectUser').css("display", "block")
                    }
                }
            })
        }

        let resultPwd;

        function pwd(val) {
            $.ajax({
                url: "${pageContext.request.contextPath}/selectUser",
                data: {'username':${sessionScope.get("username")}, 'password': val},
                async: true,
                success: function (result) {
                    if (result != "pwdTrue") {
                        resultPwd = result
                        $('.pwd').css("display", "block")
                    } else {
                        resultPwd = result
                        $('.pwd').css("display", "none")
                    }
                }
            })
        }



        $('body').on("blur", "#password", function () {
            let val= $(this).val()
            pwd(val)
        })

        $('body').on("blur", "#password1", function () {
            let val = $(this).val();
            pwd(val)
        })

        $("#form2").submit(function (e) {
            if (resultPwd != "pwdTrue" || username != "null" || !master) {
                e.preventDefault();
            }
        });

        $("#form1").submit(function (e) {
            if (!email) {
                e.preventDefault();
            }
        });

        $("#form3").submit(function (e) {
            if (resultPwd != "pwdTrue" || !pwds) {
                e.preventDefault();
            }
        });


    })
</script>
<body style="background-color: #86cfda">
<div class="container-fluid">
    <div class="row clearfix">
        <div style="margin: 2rem auto;width: 10rem;">
            <img src="${pageContext.request.contextPath}/imgs/10.jpg" class="img-circle"
                 style="width: 10rem;height: 10rem;">
        </div>
        <div style="display: flex;flex-direction: row;justify-content: center;align-items: center">
            <div class="col-md-6">
                <table class="table " style="text-align: center" id="show">
                    <tr>
                        <td>用户名: ${sessionScope.get("username")} &nbsp;<a class="btn btn-primary btn-sm"
                                                                          id="updateUser">修改用户名</a></td>
                    </tr>
                    <tr>
                        <td>密码:****** &nbsp;<a class="btn btn-primary btn-sm" id="updatePassword">修改密码</a></td>
                    </tr>
                    <tr>
                        <td>邮箱:${requestScope.get("user").getEmail()}</td>
                    </tr>
                    <tr>
                        <td>性别:${requestScope.get("user").getSex()}</td>
                    </tr>
                    <tr>
                        <td>生日:${requestScope.get("user").getBirthday()}</td>
                    </tr>
                    <tr>
                        <td>权限:<span style="color: red">${requestScope.get("user").getJurisdiction()}</span></td>
                    </tr>
                    <tr style="text-align: center;}">
                        <td>
                            <button class="btn " id="modify">修改信息基本信息</button>
                        </td>
                    </tr>
                </table>
                <form role="form" style="display: none" id="form1" action="${pageContext.request.contextPath}/info"
                      method="post">
                    <div class="form-group">
                        <label for="text3">邮箱:</label><input type="email" class="form-control" id="text3" name="email"
                                                             value="${requestScope.get("user").getEmail()}" required/>
                        <div style="display: none;color: red" class="invalid-feedback">
                            邮箱格式错误
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="text1">性别:</label>
                        <div class="radio" id="text1">
                            <select name="sex">
                                <option selected="selected" value="保密">保密</option>
                                <option value="男">男</option>
                                <option value="女">女</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="text2">生日:</label><input type="date" class="form-control" id="text2" name="birthday"
                                                             value="${requestScope.get("user").getBirthday()}"
                                                             required/>
                    </div>
                    <div style="text-align: center">
                        <button type="submit" class="btn btn-default">提交</button>
                        <button type="button" class="btn btn-default return">返回</button>
                    </div>
                </form>


                <form style="display: none" id="form2" action="${pageContext.request.contextPath}/newUser"
                      method="post">
                    <div style="text-align: center">
                        <h4 style="color: red">注意:修改后需要重新登录！</h4>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputUser1">新用户名:</label><input type="text" class="form-control"
                                                                           id="exampleInputUser1" name="newUser"/>
                        <br>
                        <div style="display: none;color: red" id="notUser" class="invalid-feedback" >
                            用户名必须在5~16位之间
                        </div>
                        <div style="display: none;color: red" id="selectUser" class="invalid-feedback">
                            用户名已存在
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password">用户密码:</label><input type="password"
                                                                  class="form-control"
                                                                  id="password"/>
                        <br>
                        <div style="display: none;color: red" class="invalid-feedback pwd">
                            密码错误
                        </div>
                    </div>
                    <div style="text-align: center">
                        <button type="submit" id="btnUser" class="btn btn-default">提交</button>
                        <button type="button" class="btn btn-default return">返回</button>
                    </div>
                </form>


                <form style="display: none" id="form3" action="${pageContext.request.contextPath}/newPwd" method="post">
                    <div style="text-align: center">
                        <h4 style="color: red">注意:修改后需要重新登录！</h4>
                    </div>
                    <div class="form-group">
                        <label for="password1">原密码:</label><input type="text" class="form-control"
                                                                  id="password1" required/>
                        <br>
                        <div style="display: none;color: red" class="invalid-feedback pwd">
                            密码错误
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password2">新密码:</label><input type="password" class="form-control" id="password2"
                                                                  name="Pwd" required/>
                        <div style="display: none;color: red" class="invalid-feedback">
                            密码必须在6~16位之间,字母数字组合
                        </div>
                    </div>
                    <div style="text-align: center">
                        <button type="submit" class="btn btn-default">提交</button>
                        <button type="button" class="btn btn-default return">返回</button>
                    </div>
                </form>
                <div class="col-md-12 column">
                    <div class="row clearfix">
                        <div class="col-md-6 column">
                            <div class="alert alert-success alert-dismissable">
                                <h4>
                                    歌单歌曲数量:
                                </h4>
                                <h4>查询到您的歌单中共有<strong>${requestScope.get('countMusic')}首</strong>歌曲,修改请到歌单管理页面</h4>
                            </div>
                        </div>
                        <div class="col-md-6 column">
                            <div class="alert alert-success alert-dismissable">
                                <h4>
                                    留言条数：
                                </h4> <h4>查询到您的留言共有<strong>${requestScope.get("count")}条</strong>记录,请及时查看回复</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
