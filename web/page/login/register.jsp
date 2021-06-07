<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>登录</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="../../static/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../static/css/style.default.css">
    <script type="text/javascript" src="../../static/js/jquery.min.js"></script>
  </head>
  <script>
    $(function () {
      //用户名
        let nameReg =/^[\u4e00-\u9fa5a-zA-Z0-9_-]{5,12}$/;
      //密码
        let psw =/^(?=.*[a-zA-Z])(?=.*\d)[^]{6,16}$/;
      //邮箱正则
        let email=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
        let master;
        $('body').on("blur","#register-username",function () {
          if (!nameReg.test($(this).val())){
            $(this).next().css("display","inline")
            master=false;
          }else {
            master=true;
            $(this).next().css("display","none")
          }
          let names=$(this).val();
          select(names)
        })

      let emails;
      $('body').on("blur","#register-email",function () {
        if (!email.test($(this).val())){
          $(this).next().css("display","inline")
          emails=false;
        }else {
          emails=true;
          $(this).next().css("display","none")
        }
      })

      let pwd;
      $('body').on("blur","#register-password",function () {
        if (!psw.test($(this).val())){
          pwd=false;
          $(this).next().css("display","inline")
        }else {
          pwd=true;
          $(this).next().css("display","none")
        }
      })

      let pwds;
      $('body').on("blur","#register-passwords",function () {
        if ($(this).val() != $('#register-password').val() || $(this).val()==""){
          pwds=false;
          $(this).next().css("display","inline")
        }else {
          pwds=true;
          $(this).next().css("display","none")
        }
      })
      //手动刷新
      $('#code').click(function () {
        $(this).attr('src', '${pageContext.request.contextPath}/getVerifyCode?' + Math.floor(Math.random() * 100));
      })

      let results;
      function codeError(){
        $.ajax({
          url:"${pageContext.request.contextPath}/getCodeSession",
          async:false,
          success:function (result) {
            results = result.replace("\"","").replace("\"","");
          }
        })
      }

      let code;
        $('body').on("blur","#verifyCode",function () {
          codeError()
          let value= $(this).val()
          if (value.toLowerCase() != results.toLowerCase()){
            code=false;
            $('#error').css("display","block")
          }else {
            code=true;
            $('#error').css("display","none")
          }
        })


      function select(names) {
        $.ajax({
          url:"${pageContext.request.contextPath}/selectUser",
          data:{'username':names},
          async:true,
          success:function(result) {
                if (result != "null"){
                  $('#selectUser').css("display","block")
                }else {
                  $('#selectUser').css("display","none")
                }
          }
        })
      }

      $("form").submit(function(e){
        if (!master || !pwd || !pwds || !code || !emails){
          e.preventDefault();
        }else {
          alert("注册成功，请登录")
        }
      });
    })
  </script>
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
                    <h1>欢迎注册</h1>
                  </div>
                  <p>WWFWL在线音乐网站</p>
                </div>
              </div>
            </div>
            <!-- Form Panel    -->
            <div class="col-lg-7 bg-white">
              <div class="form d-flex align-items-center">
                <div class="content">
                  <form action="${pageContext.request.contextPath}/register" method="post" autocomplete="on">
                    <div class="form-group">
                      用户名:<input id="register-username" class="input-material" type="text" name="username" placeholder="用户名必须在5~16位之间" required>
								      <div class="invalid-feedback" >
								        	用户名必须在5~16位之间
								      </div>
                      <div id="selectUser" class="invalid-feedback" >
                        用户名已存在
                      </div>
                    </div>
                    <div class="form-group">
                      密码:<input id="register-password" class="input-material" type="password" name="password" placeholder="密码必须在6~16位之间,字母数字组合"   required>
                    	<div class="invalid-feedback">
								        	密码必须在6~16位之间,字母数字组合
								      </div>
                    </div>
                  <div class="form-group">
                    确认密码:<input id="register-passwords" class="input-material" type="password" name="registerPasswords" placeholder="两次密码必须相同"   required>
                    <div class="invalid-feedback">
                      两次密码必须相同,且不为空
                    </div>
                  </div>
                    <div class="form-group">
                     邮箱:<input id="register-email" class="input-material" type="text" name="email" placeholder="邮箱"   required>
                      <div class="invalid-feedback">
                       邮箱格式错误
                      </div>
                    </div>
                  <div class="form-group">
                    验证码:<br><input id="verifyCode"  class="input-material" type="text"  placeholder="请输入验证码" style="width: 70%; margin-bottom: 0.5rem" required>
                    <div class="col-md-3" style="float: right;">
                      <img style="cursor: pointer" id="code" src="${pageContext.request.contextPath}/getVerifyCode">
                    </div>
                    <div id="error" class="invalid-feedback">
                      验证码错误
                    </div>
                  </div>
                    <div class="form-group">
                      <button id="regbtn" type="submit" name="registerSubmit" class="btn btn-primary" spellcheck ="false" style="margin-top: 0.5rem">注册</button>
                      <a  href="${pageContext.request.contextPath}/"  class="btn btn-primary" style="margin-top: 0.5rem">返回首页</a>
                    </div>
                  </form>
                  <small>已有账号?</small><a href="login.jsp" class="signup">&nbsp;登录</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>