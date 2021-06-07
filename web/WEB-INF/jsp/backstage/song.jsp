<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 86188
  Date: 2021/5/20
  Time: 22:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>歌单</title>
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
            let id = $(this).attr("value")
            $(this).attr('id', 'del');
            del(id);
        });

        function del(id) {
            $.ajax({
                url: "${pageContext.request.contextPath}/userDelete",
                data: {'sid': id},
                type: "post",
                async: true,
                success: function () {
                    $('#del').parent().parent().remove()
                    let number = $('#count').children().children().text() - 1;
                    $('#count').children().children().text(number)
                }
            })
        }

        let song="${requestScope.get('userSong')}";
        if (song==""){
            let no = "<span><h3 style=\"text-align:center;color: red;font-family: KaiTi;\">您的歌单还没有歌曲呢,赶快去添加吧!</h3></span>" +
                "<h3 style='text-align:center;font-family: KaiTi' ><a target=\"_parent\" href='${pageContext.request.contextPath}/house'>曲库添加</a></h3>"
            $('#tab').after(no)
        }

    });
</script>
<body>
<div class="container-fluid" style="padding: 0;">
    <form action="${pageContext.request.contextPath}/userLookup" method="post" class="form-inline" autocomplete="on"
          style="margin-left: 1rem;">
        <input class="input-medium search-query" type="text" style="height: 30px;margin-top: 1rem;" name="name"
               required/>
        <button type="submit" class="btn">查找</button>
        <a href="${pageContext.request.contextPath}/userSong" class="btn  btn-success">全部歌曲</a>
    </form>
    <div class="table-responsive">
        <table class="table table-hover" id="tab">
            <tr>
                <th>
                    序号
                </th>
                <th>
                    歌曲
                </th>
                <th>
                    歌手
                </th>
                <th>
                    操作
                </th>
            </tr>
                    <c:forEach var="music" items="${requestScope.get('userSong')}">
                        <tr style="margin: auto">
                            <td width="25%"> ${music.getId()}</td>
                            <td width="25%"> ${music.getTitle()}</td>
                            <td width="25%"> ${music.getName()}</td>
                            <td width="25%">
                                <button value="${music.getId()}" class="btn  btn-danger delete">删除</button>
                                <a href="${pageContext.request.contextPath}/download/${music.getTitle()}"
                                   class="btn btn-primary">下载</a>
                                <a target="_parent" href="${pageContext.request.contextPath}/play/${music.getId()}"
                                   class="btn play  btn-success">播放</a>
                            </td>
                        </tr>
                    </c:forEach>
        </table>
        <div class="pull-right" style="margin-right: 1rem">
            <span id="count"><h4>共<span>${requestScope.get("count")}</span>条歌曲</h4></span>
        </div>
    </div>
</div>
</body>
</html>
