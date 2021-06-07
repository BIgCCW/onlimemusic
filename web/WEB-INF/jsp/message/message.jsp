<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>留言板</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" type="text/css" />
		<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
		<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
		<script src="https://cdn.bootcdn.net/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js"></script>
	</head>
		<script>
			$(function(){
				$('#sendMessage').on('click',function(){
					if ($('#messageContent').val()!=""){
						addMessage()
					}
				});

				function addMessage() {
					$.ajax({
						url: "${pageContext.request.contextPath}/addMessage",
						data: {'message':$('#messageContent').val()},
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
		<div class="container">
			<div class="row">
				<div id="wrapper" class="col-md-12  align-items-center" style="background-color: white;opacity: 0.8;margin-top:6rem; ">
					<!-- 留言显示区域 -->
					<div class="comment">
						<ul class="message">
							<c:forEach var="message" items="${requestScope.get('messages')}">
							<li>
								<div class="concent">${message.getText()} <span style="float: right;">${message.getName()}</span></div>
							</li>
							</c:forEach>
						</ul>
					</div>
					<!-- 留言发布区域 -->
					<div class="row">
						<div class="sendMessageWrap" class="col-md-8">
							<!-- 留言输入框 -->
							<textarea id="messageContent" placeholder="留言输入内容..." ></textarea>
							<!-- 发布留言按钮 -->
							<button id="sendMessage" class="btn">发布留言</button>
							<a href="${pageContext.request.contextPath}/" class="btn">返回首页</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
