<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="utf-8">
    <title>在线播放</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/audio.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/audio.css">
    <link rel="shortcut icon" href="#" />
    <style>
        body {
            position: absolute;
            z-index: 1;
            width: 100%;
            height: 100%;
        }
        body::before {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: -1;
            content: '';
            background: url(${pageContext.request.contextPath}/images/bg.jpg) no-repeat;
            background-size: 100% 100%;
            filter: blur(20px);
        }

    </style>
    <script>
        $(function () {
            <%--$.ajax({--%>
            <%--    url:"${pageContext.request.contextPath}/getSession",--%>
            <%--    async:true,--%>
            <%--    success:function (result) {--%>
            <%--        if (result == "0"){--%>
            <%--            alert("请先在曲库中添加您自己喜欢的歌曲")--%>
            <%--            $(location).attr('href', '${pageContext.request.contextPath}/house?page=1');--%>
            <%--        }--%>
            <%--    }--%>
            <%--})--%>

                $('#cancel').click(function () {
                    let b = confirm('您确定要退出吗');
                    return b;
                })
        })
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row" style="background-color: white;">
    <div class="span12">
        <ul class="nav nav-tabs" style="font-size: 1.6rem;">
            <li >
                <a href="${pageContext.request.contextPath}/">首页</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/house?page=1" >曲库</a>
            </li>
            <li class="active">
                <a href="#">听歌</a>
            </li>
            <c:choose>
                <c:when test="${sessionScope.get('username')==null}">
                    <li >
                        <a href="${pageContext.request.contextPath}/login">登录</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li>
                        <a href="${pageContext.request.contextPath}/message">留言</a>
                    </li>
                </c:otherwise>
            </c:choose>
            <li class="dropdown pull-right">
                <a href="" data-toggle="dropdown" class="dropdown-toggle">下拉<strong class="caret"></strong></a>
                <ul class="dropdown-menu">
                    <c:if test="${sessionScope.get('username')!=null}">
                        <li >
                            <a id="cancel" href="${pageContext.request.contextPath}/cancellation">退出</a>
                        </li>
                    </c:if>
                    <li >
                        <a href="${pageContext.request.contextPath}/backstage?fun=5">个人中心</a>
                    </li>
                    <li >
                        <a href="${pageContext.request.contextPath}/backstage">后台管理</a>
                    </li>
                    <li >
                        <a href="${pageContext.request.contextPath}/backstage?fun=2">歌单管理</a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
    </div>
    <div class="row" style="text-align: center">
        <div class="col-md-6">
            <div class="row">
                <img src="${pageContext.request.contextPath}/images/10.png" alt="歌曲图片"  style="padding-top:40px ;">
            </div>
        </div>
        <div class="col-md-6">
            <div  style="margin: 0 auto;color: white;padding-top: 90px" >
                <h2 class="songName" ></h2>
                <h3 class="Name" ></h3>
                <div class="Lyric">暂无支持歌词滚动</div>
            </div>
        </div>
    </div>
    <div class="row" style="padding-top: 150px;z-index:100;">
        <div class="container-fluid" id="audio">
            <div class="audio-box">
                <div id="audio-container" class="container">
                    <div id="audio-view" class="row">
                        <div id="audio-body">
                            <small class="audio-id" style="display: none"></small><h3 class="audio-title">未知歌曲-未知歌手</h3>
                            <div class="audio-backs">
                                <div class="audio-this-time">00:00</div>
                                <div class="audio-count-time">00:00</div>
                                <div class="audio-setbacks">
                                    <i class="audio-this-setbacks">
                                        <span class="audio-backs-btn"></span>
                                    </i>
                                    <span class="audio-cache-setbacks">
							</span>
                                </div>
                            </div>
                        </div>
                        <div id="audio-btn">
                            <div class="audio-select">
                                <div class="audio-prev"></div>
                                <div class="audio-play"></div>
                                <div class="audio-next"></div>
                                <div class="audio-menu"></div>
                                <div class="audio-volume"></div>
                            </div>
                            <div class="audio-set-volume">
                                <div class="volume-box">
                                    <i><span></span></i>
                                </div>
                            </div>
                            <div class="audio-list" style="">
                                <div class="audio-list-head">
                                    <p>歌单</p>
                                    <span class="menu-close">关闭</span>
                                    <div style="font-size: 1.5rem;margin-bottom: 0.5rem;width: auto;margin-left: 0.7rem;">
                                        <a href="${pageContext.request.contextPath}/backstage?fun=2"
                                           style="border: 1px solid #ccc;color: #000;padding: 0.3rem 0.3rem;text-decoration: none;
                                            background-color: antiquewhite;border-radius: 1rem;margin-right: 0.3rem;display: inline-block">歌单管理</a>
                                        注：登陆后可管理,否则为临时歌单!!!
                                    </div>
                                </div>

                                <ul class="audio-inline">
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    $(function(){

        var song = [
            <c:forEach var="music" items="${sessionScope.song}">
            {
                'src':"${pageContext.request.contextPath}/${music.getSrc()}",
                'title' :'${music.getTitle()}'
            },
            </c:forEach>
        ];


        var audioFn = audioPlay({
            song : song,
            autoPlay : false  //是否立即播放第一首，autoPlay为true且song为空，会alert文本提示并退出
        });

<%--        <c:forEach var="music" items="${sessionScope.addSong}">--%>
<%--        /* 向歌单中添加新曲目，第二个参数true为新增后立即播放该曲目，false则不播放 */--%>
<%--        audioFn.newSong({--%>
<%--            'src' :"${pageContext.request.contextPath}/${music.getSrc()}",--%>
<%--            'title' : '${music.getTitle()}'--%>
<%--        },false);--%>
<%--        </c:forEach>--%>
        /* 暂停播放 */
        //audioFn.stopAudio();

        /* 开启播放 */
        //audioFn.playAudio();

        /* 选择歌单中索引为3的曲目(索引是从0开始的)，第二个参数true立即播放该曲目，false则不播放 */
        //audioFn.selectMenu(3,true);

        /* 查看歌单中的曲目 */
        //console.log(audioFn.song);

        /* 当前播放曲目的对象 */
        //console.log(audioFn.audio);
    });
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();

</script>


</html>