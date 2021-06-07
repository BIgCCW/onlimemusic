<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>注册</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="robots" content="all,follow">
    <link rel="stylesheet" href="../../static/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../static/css/style.default.css">
    <script type="text/javascript" src="../../static/js/jquery.min.js"></script>
  <script>
    $(function () {

      $('body').on("blur","#login-username",function () {
        select()
      })
      let username;
      function select() {
        $.ajax({
          url:"${pageContext.request.contextPath}/selectUser",
          data:{'username':$('#login-username').val(),'password':$('#login-password').val()},
          async:true,
          success:function(result) {
            if (result == "null"){
              username=result
              $('#selectUser').css("display","block")
            }else {
              username=result
              $('#selectUser').css("display","none")
            }
          }
        })
      }
        let resultPwd;
      function pwd() {
        $.ajax({
          url:"${pageContext.request.contextPath}/selectUser",
          data:{'username':$('#login-username').val(),'password':$('#login-password').val()},
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
      $('body').on("blur","#login-password",function () {
          pwd()
      })

      $("form").submit(function(e){
        if (resultPwd !="pwdTrue" || username=="null"){
          e.preventDefault();
        }
      });
    })
  </script>
  </head>
  <body>

    <div class="page login-page">
      <div class="container d-flex align-items-center">
        <div class="form-holder has-shadow">
          <div class="row">
            <!-- Logo & Information Panel-->
            <div class="col-lg-5">
              <div class="info d-flex align-items-center">
                <div class="content">
                  <div class="logo">
                    <h1>欢迎登录</h1>
                  </div>
                  <p>WWFWL在线音乐网站</p>
                </div>
              </div>
            </div>
            <!-- Form Panel    -->
            <div class="col-lg-7 bg-white">
              <div class="form d-flex align-items-center">
                <div class="content">
                  <form method="post" action="${pageContext.request.contextPath}/userLogin" class="form-validate" id="loginFrom">
                    <div class="form-group">
                      <input id="login-username" type="text" name="userName" required data-msg="请输入用户名" placeholder="用户名" class="input-material" required>
                      <div id="selectUser"  class="invalid-feedback" >
                        用户名不存在
                      </div>
                    </div>
                    <div class="form-group">
                      <input id="login-password" type="password" name="passWord" required data-msg="请输入密码" placeholder="密码" class="input-material" required>
                      <div  id="pwd" class="invalid-feedback" >
                        密码错误
                      </div>
                    </div>
                    <button id="login" type="submit" class="btn btn-primary">登录</button>
                    <a style="margin-bottom: 20px;cursor: pointer;color: white;" type="submit"
                       href="${pageContext.request.contextPath}/"  class="btn btn-primary">返回首页</a>
                    <div style="margin-top: -40px;">
											<div class="custom-control custom-checkbox " style="float: right;">
											    <input type="checkbox" class="custom-control-input" id="check1" >
											    <label class="custom-control-label" for="check1">记住密码&nbsp;&nbsp;</label>
											</div> 
                    </div>
                  </form>
                  <br />
                  <small>没有账号?</small><a href="register.jsp" class="signup">&nbsp;注册</a>
                 <br/>
                  <a href="#" class="signup">找回密码</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>