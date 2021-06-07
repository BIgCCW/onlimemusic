<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8"%>
<html>
  <head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>首页</title>
	  <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/backstage/css/sccl.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/backstage/skin/qingxin/skin.css" id="layout-skin"/>
  </head>
  <script>
	  $(function () {
		  $.ajax({
			  url: "${pageContext.request.contextPath}/getJur",
			  type: "post",
			  async: true,
			  success: function (result) {
					$('#jurisdiction').text(result)
				  	if (result=="订阅者"){
				  		$('.House').css('display','none')
				  		$('.root').css('display','none')
					}else if(result=="管理员"){
						$('.root').css('display','none')
					}
			  }
		  })
	  })

  </script>
  <%
	  String path = request.getContextPath();
	  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  %>
  <body>
	<div class="layout-admin">
		<header class="layout-header">
			<span class="header-logo">后台管理系统</span>
			<a class="header-menu-btn" href="javascript:;"><i class="icon-font">&#xe600;</i></a>
			<ul class="header-bar">
				<li class="header-bar-nav">
					<a href="${pageContext.request.contextPath}/">返回首页</a>
				</li>
				<li class="header-bar-role"><a href="javascript:;" id="jurisdiction"></a></li>
				<li class="header-bar-nav">
					<a href="javascript:;"><span id="una">${sessionScope.get("username")}</span><i class="icon-font" style="margin-left:5px;">&#xe60c;</i></a>
					<ul class="header-dropdown-menu">
						<li><a href="${pageContext.request.contextPath}/cancellation">退出账号</a></li>
					</ul>
				</li>
			</ul>
		</header>
		<aside class="layout-side">
			<ul class="side-menu" id="twoUl">
			  
			</ul>
		</aside>
		
		<div class="layout-side-arrow"><div class="layout-side-arrow-icon"><i class="icon-font">&#xe60d;</i></div></div>
		
		<section class="layout-main">
			<div class="layout-main-tab">
				<button class="tab-btn btn-left"><i class="icon-font">&#xe60e;</i></button>
                <nav class="tab-nav">
                    <div class="tab-nav-content">
                        <a href="javascript:;" style="cursor:pointer" class="content-tab active" data-id=<%=basePath%>home>首页</a>
                    </div>
                </nav>
                <button class="tab-btn btn-right"><i class="icon-font">&#xe60f;</i></button>
			</div>
			<div class="layout-main-body">
				<iframe class="body-iframe" name="iframe0" width="100%" height="99%" src=<%=basePath%>home frameborder="0" data-id=<%=basePath%>home seamless></iframe>
			</div>
		</section>
		<div class="layout-footer">Copyringht©wwfwl</div>
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/lib/jquery-1.9.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/sccl.js"></script>
  </body>
</html>
