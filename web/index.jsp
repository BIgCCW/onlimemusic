<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 86188
  Date: 2021/4/24
  Time: 19:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>首页</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/2.3.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/2.3.0/js/bootstrap.min.js"></script>
</head>
<script>
    $(function () {
        $('#cancel').click(function () {
            let b = confirm('您确定要退出吗');
            return b;
        })
    })
</script>
<body>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="col-md-12">
            <ul class="nav nav-tabs" >
                <li class="active">
                    <a href="#">首页</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/house">曲库</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/listen">听歌</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/message">留言</a>
                </li>
                <li class="dropdown ">
                    <a href="" data-toggle="dropdown" class="dropdown-toggle">下拉<strong class="caret"></strong></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="${pageContext.request.contextPath}/backstage?fun=5">个人中心</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/backstage">后台管理</a>
                        </li>
                    </ul>
                </li>
                <c:choose>
                    <c:when test="${sessionScope.get('username')==null}">
                        <li>
                            <a href="${pageContext.request.contextPath}/login">登录</a>
                        </li>
                        <li class="pull-right">
                            <a style="color: #FF4500;">未登录</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <a id="cancel" href="${pageContext.request.contextPath}/cancellation">退出</a>
                        </li>
                        <li class="pull-right">
                            <a style="color: #FF4500;">您好!用户:${sessionScope.get('username')}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
            <div class="carousel slide" id="carousel-342774">
                <ol class="carousel-indicators">
                    <li class="active" data-slide-to="0" data-target="#carousel-342774">
                    </li>
                    <li data-slide-to="1" data-target="#carousel-342774">
                    </li>
                    <li data-slide-to="2" data-target="#carousel-342774">
                    </li>
                </ol>
                <div class="carousel-inner">
                    <div class="item active"
                         style="background-image: linear-gradient(to right,rgb(102,99,84), rgb(51,69,79));">
                        <img alt="" src="imgs/4.jpg" style="height: auto;display: block;margin: auto"/>
                        <div class="carousel-caption"/>
                        <p>音乐常使死亡迟延。——伊索</p>
                    </div>
                </div>
                <div class="item"
                     style="background-image: linear-gradient(to right,rgb(194,185,180), rgb(184,171,165));">
                    <img alt="" src="imgs/5.jpg" style="height: auto;display: block;margin: auto"/>
                    <div class="carousel-caption">
                        <p>音乐是思维着的声音。——雨果</p>
                    </div>
                </div>
                <div class="item"
                     style="background-image: linear-gradient(to right,rgb(211,236,243), rgb(177,225,237));">
                    <img alt="" src="imgs/6.jpg" style="height: auto;display: block;margin: auto"/>
                    <div class="carousel-caption">
                        <p>移风易俗，莫善于乐。——孔子</p>
                    </div>
                </div>
            </div>
            <a data-slide="prev" href="#carousel-342774" class="left carousel-control">‹</a> <a data-slide="next"
                                                                                                href="#carousel-342774"
                                                                                                class="right carousel-control">›</a>
        </div>
    </div>
</div>
</div>
<div class="container-fluid">
    <div class="row-fluid text-center">
        <div class="span4 text-center">
            <img alt="140x140" src="imgs/1.jpg" class="img-polaroid"/>
        </div>
        <div class="span4">
            <img alt="140x140" src="imgs/2.jpg" class="img-polaroid"/>
        </div>
        <div class="span4 text-center">
            <img alt="140x140" src="imgs/3.jpg" class="img-polaroid"/>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span4">
            <dl>
                <dt>
                    邓紫棋:
                </dt>
                <dd>
                    本名邓诗颖，1991年8月16日出生于上海市，中国香港流行乐女歌手、词曲作者、音乐制作人。
                </dd>
            </dl>
        </div>
        <div class="span4">
            <dl>
                <dt>
                    薛之谦:
                </dt>
                <dd>
                    1983年7月17日出生于上海市，中国内地流行乐男歌手、音乐制作人、影视演员。
                </dd>
            </dl>
        </div>
        <div class="span4">
            <dl>
                <dt>
                    泰勒·斯威夫特:
                </dt>
                <dd>
                    出生于美国宾夕法尼亚州，毕业于亚伦学院，美国女歌手、音乐制作人、演员、慈善家。
                </dd>
            </dl>
        </div>
    </div>
</div>
<div class="container-fluid" style="margin-top: 3%">
    <div class="row-fluid text-center">
        <div class="span4">
            <ul class="inline">
                <li>
                    <h4 class="display-1">与我联系</h4>
                </li>
                <li>
                    <a href="#" target="_Blank">给我留言</a>
                </li>
                <li>
                    <a href="#">补充曲库</a>
                </li>
                <li>
                    <a href="#" target="_Blank">bug报备</a>
                </li>
            </ul>
        </div>
        <div class="span4">
            <ul class="inline">
                <li>
                    <h4 class="display-3">友情链接</h4>
                </li>
                <li>
                    <a href="https://music.163.com/" target="_Blank">网易云音乐</a>
                </li>
                <li>
                    <a href="http://www.kugou.com/" target="_Blank">酷狗音乐</a>
                </li>
                <li>
                    <a href="https://y.qq.com/" target="_Blank">QQ音乐</a>
                </li>
            </ul>
        </div>
        <div class="span4">
            <ul class="inline" style="list-style:none;">
                <li>
                    <h4 class="display-3">功能展示</h4>
                </li>
                <li>
                    <a href="#">曲库歌单</a>
                </li>
                <li>
                    <a href="#">注册登录</a>
                </li>
                <li>
                    <a href="#">后台管理</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<footer class="jumbotron"><h5 class="text-muted" align="center">Copyringht©wwfwl 版权所有</h5></footer>
</body>
</html>
