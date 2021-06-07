<%--
  Created by IntelliJ IDEA.
  User: 86188
  Date: 2021/5/21
  Time: 23:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>曲库添加</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<script>
    $(function () {
        $("form").submit(function (e) {
            let fileInput = $('#exampleInputFile').get(0).files[0];
            if (fileInput) {
                alert("上传成功")
            } else {
                alert("请上传文件")
                e.preventDefault();
            }
        });

        $('#exampleInputFile').change(function () {
            let uploadFile = $("#exampleInputFile").val();
            let fileName = getFileName(uploadFile);
            let split = fileName.split("-");
            $('#text2').val(split[0].trim())
            let strings = split[1].trim().split(".");
            $('#text1').val(strings[0])
        })

        function getFileName(file) {//通过第二种方式获取文件名
            let arr = file.split('\\');//通过\分隔字符串，成字符串数组
            return arr[arr.length - 1];//取最后一个，就是文件名
        }
    })

</script>
<body style="background-color: antiquewhite;padding: 0;margin-left: -0.3rem">
<h3 style="text-align: center;color: deepskyblue;">歌曲添加</h3>
<h5 style="text-align: center;color: red">注意事项:1:上传歌曲不可超过10MB 2:上传的歌曲名字中尽量不要带空格 3：上传文件需要为MP3文件</h5>
<div class="container-fluid" style="display: flex;flex-direction: row;justify-content: center;align-items: center">
    <div class="col-md-6">
        <form action=" ${pageContext.request.contextPath}/upload2" enctype="multipart/form-data" method="post">
            <div class="form-group">
                <label for="text1">歌曲名字</label>
                <input type="text" class="form-control" id="text1" placeholder="歌曲名字" name="musicName"
                       required="required">
            </div>
            <div class="form-group">
                <label for="text2">歌曲歌手</label>
                <input type="text" class="form-control" id="text2" name="singer" placeholder="歌曲歌手" required="required">
            </div>
            <div class="form-group">
                <label for="exampleInputFile">上传文件</label>
                <input type="file" id="exampleInputFile" name="file" accept="audio/mpeg">
                <p class="help-block" style="color: red">歌曲文件需为MP3文件,上传文件后可自动识别歌手和歌名，如有错误请手动更改</p>
            </div>
            <div class="form-group">
                <label for="exampleInputFile">歌曲介绍（可选填)</label>
                <textarea class="form-control" rows="6"></textarea>
            </div>
            <button type="submit" class="btn btn-default">上传</button>
        </form>
    </div>
</div>
</body>
</html>
