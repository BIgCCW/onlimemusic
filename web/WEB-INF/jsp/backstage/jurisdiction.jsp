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
    <title>提升权限</title>
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
        let resultPwd;
        function pwd() {
            $.ajax({
                url:"${pageContext.request.contextPath}/addApplyPwd",
                data:{'password':$('#text2').val()},
                async:true,
                success:function(result) {
                    if (result != "pwdTrue"){
                        resultPwd=result
                        $('#pwd').css("display","block")
                    }else {
                        resultPwd=result
                        $('#pwd').css("display","none")
                    }
                }
            })
        }
        $('body').on("blur","#text2",function () {
            pwd()
        })

        $("form").submit(function(e){
            if (resultPwd !="pwdTrue"){
                e.preventDefault();
            }
        });
    })
</script>
<body style="background-color: #f5c6cb">
<h3 style="text-align: center;color: red;">提升权限</h3>
<h5 style="text-align: center;color: red;">目前后台管理曲库添加需要管理权限，处理用户需要超级管理员权限,提交后需开发者核对同意</h5>
<div class="container-fluid" style="display: flex;flex-direction: row;justify-content: center;align-items: center">
    <div class="col-md-6">
        <form action="${pageContext.request.contextPath}/apply"  method="post" >
            <div class="form-group">
                <label for="text2">密码</label>
                <input type="password" class="form-control" id="text2" name="password" placeholder="密码" required="required"><br>
                <div style="display: none;color: red" id="pwd" class="invalid-feedback" >
                    密码错误
                </div>
            </div>
            <div class="form-group">
                <label >选择权限</label>
                <div class="radio" id="sex">
                    <select name="jurisdiction">
                        <option selected="selected" value="提权为-订阅者">订阅者</option>
                        <option value="提权为-管理员">管理员</option>
                        <option value="提权为-超级管理员">超级管理员</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label >理由(QQ号必填,否则不通过)</label>
                <textarea class="form-control" rows="6" name="reason" required></textarea>
            </div>
            <button type="submit" class="btn btn-default">提交申请</button>
        </form>
    </div>
</div>
</body>
</html>
