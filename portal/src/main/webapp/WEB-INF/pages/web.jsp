<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>hello</title>
    <script src="/js/jquery-1.7.2.min.js"></script>
    <script>
        $(function () {
            $.ajax("test", {
                headers: {
                    //            accept:"text/plain,text/html;q=0.9,*/*;q=0.8"
                    accept: "text/plain,text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                }
            }).success(function (data) {
                $("body").append(JSON.stringify(data))
                console.info(data)
            }).fail(function (a, b) {
                console.warn(a)
                console.error(b)
            })
        });
    </script>
</head>
<body>
<h1>it works</h1>
</body>
</html>
