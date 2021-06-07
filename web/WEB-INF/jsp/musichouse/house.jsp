<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 86188
  Date: 2021/4/24
  Time: 21:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>曲库</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/2.3.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/2.3.0/js/bootstrap.min.js"></script>
</head>
<script>
    $(function () {
        addEd()
        function addEd(){
            $.ajax({
                url:"${pageContext.request.contextPath}/getSession",
                async:true,
                success:function (result) {
                    if (result !="0"){
                        let parse = JSON.parse(result);
                        for (let x in parse) {
                            $('.added').each(function () {
                                // console.log($(this).attr("value"))
                                if ($(this).attr("value") == parse[x] ){
                                    $(this).text('已加')
                                    $(this).addClass("disabled")
                                    $(this).removeAttr('href');//去掉a标签中的href属性
                                    $(this).removeAttr('onclick');//去掉a标签中的onclick事件
                                }
                            })
                        }
                    }
                }
            })
        }
        $('.add').click(function () {
          let id =  $(this).attr("value")
                add(id)
        })

        //添加歌曲
        function add(id) {
            $.ajax({
                url:"${pageContext.request.contextPath}/add",
                data:{'sid':id},
                async:true,
                success:function () {
                    addEd()
                }
            })

        }



        //删除
        <%--function deletes(name){--%>
        <%--    $.ajax({--%>
        <%--        url:"${pageContext.request.contextPath}/deleteSession",--%>
        <%--        data:{'name':name},--%>
        <%--        async: true,--%>
        <%--        success:function () {--%>
        <%--        }--%>
        <%--    })--%>
        <%--}--%>


        $('.play').click(function () {
            if ( $(this).next().text() == "添加"){
                alert("已将此歌曲添加到歌单")
            }
        })
        //获取地址栏的page值
        function getUrlParam(name) {
            let reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
            let r = window.location.search.substr(1).match(reg);  //匹配目标参数
            if (r != null) return encodeURI(r[2]); return 1; //返回参数值
        }

        let urlParam = getUrlParam("page");
            if (urlParam=="0"){
                urlParam="1";
            }
            if (urlParam==${pageInfos.pages}+1){
                urlParam=${pageInfos.pages}
            }

            //当前页面显示为红色
            $('.page').each(function () {
                if($(this).text()==urlParam){
                    $(this).css('color','red')
                    $(this).removeAttr('href');//去掉a标签中的href属性
                    $(this).removeAttr('onclick');//去掉a标签中的onclick事件
                }
            })
        //判断页面是否为查找页面
        let pathname = location.pathname;
        if (pathname=="/music/house"){
            $('#lookup').remove()
        }else {
            $('#house').remove()
        }
        //判断是否有歌曲
        let total = ${pageInfos.total}
        if (total==0){
            let no = "<span style=\"margin: auto;text-align: center;color: red;font-family: KaiTi;\"><h3>未查找到歌曲!!!</h3></span>" +
                "<h3 style='text-align:center;font-family: KaiTi' ><a target=\"_parent\" href='${pageContext.request.contextPath}/house'>全部歌曲</a></h3>"
            $('#tab').after(no)
        }

        //注销弹窗
        $('#cancel').click(function () {
            let b = confirm('您确定要退出吗');
            return b;
        })


        <%--//获取数据库用户歌单id--%>
        <%--function getId(){--%>
        <%--    $.ajax({--%>
        <%--        url:"${pageContext.request.contextPath}/selectMusicId",--%>
        <%--        async:true,--%>
        <%--        success:function (result) {--%>
        <%--            if(result=="null"){--%>
        <%--                return;--%>
        <%--            }else {--%>
        <%--                //转成js对象--%>
        <%--                let parse = JSON.parse(result);--%>
        <%--                for (let x in parse) {--%>
        <%--                    add(parse[x])--%>
        <%--                }--%>
        <%--            }--%>
        <%--        }--%>
        <%--    })--%>
        <%--}--%>
        <%--if (${sessionScope.get("username") !=null}){--%>
        <%--    getId()--%>
        <%--}--%>

        //将添加歌曲数据添加到数据库
        $('.update').click(function () {
            let id =  $(this).attr("value")
                update(id)
                add(id)
        })

        function update(id){
            $.ajax({
                url:"${pageContext.request.contextPath}/updateMusicId",
                data:{'sid':id},
                type:"post",
                async:true,
                success:function () {
                    add(id)
                }
            })
        }

    })


</script>
<body>
<div class="container-fluid" >
    <div class="row-fluid">
        <div class="span12" >
            <ul class="nav nav-tabs" >
                <li >
                    <a href="${pageContext.request.contextPath}/">首页</a>
                </li>
                <li class="active">
                    <a href="#">曲库</a>
                </li>
                <li >
                    <a href="${pageContext.request.contextPath}/listen">听歌</a>
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
            <form action="${pageContext.request.contextPath}/lookup"  method="post" class="form-search" autocomplete="on">
                <input class="input-medium search-query" type="text" style="height: 30px" name="name"  required/> <button type="submit" class="btn">查找</button>
                <a href="${pageContext.request.contextPath}/house" class="btn">全部歌曲</a>
            </form>
            <table class="table table-hover" id="tab">
                <thead>
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
                </thead >
                <tbody >
                       <c:forEach var="music" items="${pageInfos.list}">
                           <tr class="warning">
                               <td width="15%">
                                       ${music.getId()}
                               </td>
                               <td width="25%">
                                       ${music.getTitle()}
                               </td>
                               <td width="20%">
                                       ${music.getName()}</td>
                               <td width="20%">
                                   <a href="${pageContext.request.contextPath}/play/${music.getId()}"  class="btn play" >播放</a>
                                   <c:choose>
                                       <c:when test="${sessionScope.get('username') !=null}">
                                           <button value="${music.getId()}"  class="btn update added"  >添加</button>
                                       </c:when>
                                       <c:otherwise>
                                           <button value="${music.getId()}"  class="btn add added"  >添加</button>
                                       </c:otherwise>
                                   </c:choose>
                                   <a href="${pageContext.request.contextPath}/download/${music.getTitle()}" class="btn">下载</a>
                               </td>
                           </tr>
                       </c:forEach>
                </tbody>
            </table>
            <div class="pagination pagination-right">
                <ul class="pagination" id="house">
                    <li>
                        <a href="${pageContext.request.contextPath}/house?page=1" aria-label="Previous">首页</a>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/house?page=${pageInfos.pageNum-1}"><</a></li>
                    <c:choose>
                        <%--中间--%>
                        <c:when test="${pageInfos.pageNum-1>0 && pageInfos.pageNum+1<=pageInfos.pages}">
                            <c:forEach begin="${pageInfos.pageNum-1}" end="${pageInfos.pageNum+1}" var="pageNum">
                                <li><a href="${pageContext.request.contextPath}/house?page=${pageNum}" class="page">${pageNum}</a></li>
                            </c:forEach>
                        </c:when>
                        <%--最后--%>
                        <c:when test="${pageInfos.pageNum+1>pageInfos.pages && pageInfos.pageNum-2>0}">
                            <c:forEach begin="${pageInfos.pageNum-2}" end="${pageInfos.pages}" var="pageNum">
                                <li><a href="${pageContext.request.contextPath}/house?page=${pageNum}" class="page">${pageNum}</a></li>
                            </c:forEach>
                        </c:when>
                        <%--最开始--%>
                        <c:when test="${pageInfos.pageNum-1<=0 && pageInfos.pageNum+2<=pageInfos.pages}">
                            <c:forEach begin="${pageInfos.pageNum}" end="${pageInfos.pageNum+2}" var="pageNum">
                                <li><a href="${pageContext.request.contextPath}/house?page=${pageNum}" class="page">${pageNum}</a></li>
                            </c:forEach>
                        </c:when>
                        <%--页面不足3页--%>
                        <c:otherwise>
                            <c:forEach begin="${pageInfos.pageNum}" end="${pageInfos.pages}" var="pageNum">
                                <li><a href="${pageContext.request.contextPath}/house?page=${pageNum}" class="page">${pageNum}</a></li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    <li><a href="${pageContext.request.contextPath}/house?page=${pageInfos.pageNum+1}">></a></li>
                    <li>
                        <a href="${pageContext.request.contextPath}/house?page=${pageInfos.pages}" aria-label="Next">尾页</a>
                    </li>
                    <li ><a style="color: black">共${pageInfos.pages}页</a></li>
                </ul>
                <ul class="pagination" id="lookup">
                    <li>
                        <a href="${pageContext.request.contextPath}/lookup?page=1" aria-label="Previous">首页</a>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/lookup?page=${pageInfos.pageNum-1}"><</a></li>
                    <c:choose>
                        <%--中间--%>
                        <c:when test="${pageInfos.pageNum-1>0 && pageInfos.pageNum+1<=pageInfos.pages}">
                            <c:forEach begin="${pageInfos.pageNum-1}" end="${pageInfos.pageNum+1}" var="pageNum">
                                <li><a href="${pageContext.request.contextPath}/lookup?page=${pageNum}" class="page">${pageNum}</a></li>
                            </c:forEach>
                        </c:when>
                        <%--最后--%>
                        <c:when test="${pageInfos.pageNum+1>pageInfos.pages && pageInfos.pageNum-2>0}">
                            <c:forEach begin="${pageInfos.pageNum-2}" end="${pageInfos.pages}" var="pageNum">
                                <li><a href="${pageContext.request.contextPath}/lookup?page=${pageNum}" class="page">${pageNum}</a></li>
                            </c:forEach>
                        </c:when>
                        <%--最开始--%>
                        <c:when test="${pageInfos.pageNum-1<=0 && pageInfos.pageNum+2<=pageInfos.pages}">
                            <c:forEach begin="${pageInfos.pageNum}" end="${pageInfos.pageNum+2}" var="pageNum">
                                <li><a href="${pageContext.request.contextPath}/lookup?page=${pageNum}" class="page">${pageNum}</a></li>
                            </c:forEach>
                        </c:when>
                        <%--页面不足3页--%>
                        <c:otherwise>
                            <c:forEach begin="${pageInfos.pageNum}" end="${pageInfos.pages}" var="pageNum">
                                <li><a href="${pageContext.request.contextPath}/lookup?page=${pageNum}" class="page">${pageNum}</a></li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    <li><a href="${pageContext.request.contextPath}/lookup?page=${pageInfos.pageNum+1}">></a></li>
                    <li>
                        <a href="${pageContext.request.contextPath}/lookup?page=${pageInfos.pages}" aria-label="Next">尾页</a>
                    </li>
                    <li ><a style="color: black">共${pageInfos.pages}页</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<footer class="jumbotron"><h5 class="text-muted" align="center">Copyringht©wwfwl 版权所有</h5></footer>
</body>
</html>
