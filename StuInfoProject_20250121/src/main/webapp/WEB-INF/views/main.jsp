<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script
            src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        .screen_right {
            float:left;
        }
        .screen_left {
            float:left;
        }

    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            loadList();
        });

        function loadList() {
            $.ajax({
                url: "board/all",
                type: "get",
                dataType: "json",
                success: make,
                error: function () {
                    alert("error");
                }
            });
        }

        function make(data) {

            let listHtml = "<table class='table table-bordered'>";
            listHtml += "<tr>";
            listHtml += "<td>학생번호</td>";
            listHtml += "<td>이름</td>";
            listHtml += "</tr>";

            $.each(data, function (index, obj) {
                listHtml += "<tr>";
                listHtml += "<td>" + obj.stu_no + "</td>";
                listHtml += "<td id='t'>"+ obj.stu_no +"<a href='javascript:search()'>" + obj.stu_name + "</a></td>";
                listHtml += "</tr>";
            });

            listHtml += "</table>";
        }


    </script>

</head>
<body>
<div class="container">
    <h2>Spring Legacy</h2>
    <div class="screen_left">
        <div class="panel panel-default">
            <div class="panel-heading">학생리스트</div>
            검색 : <input type="text"><input type="button" value="검색" onclick="">
            <table class='table table-bordered'>
                <tr>
                    <td>학생번호</td>
                    <td>이름</td>
                </tr>
                <c:forEach var="s" items="${}">
                    <tr>
                        <td>${s.stu_no}</td>
                        <td><a href="${root}/select">${s.stu_name}</a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="screen_right">
        <div class="panel panel-default">
            <div class="panel-heading">학생정보</div>
            <form id="frm">
                <table class="table">
                    <tr>
                        <td>번호</td>
                        <td><input type="text" id="stu_no" name="stu_no" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td>이름</td>
                        <td><input type="text" id="stu_name" name="stu_name" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td>사는곳</td>
                        <td><input type="text" class="form-control" id="stu_add" name="stu_add"> </td>
                    </tr>
                    <tr>
                        <td>학교</td>
                        <td><input type="text" id="stu_school" name="stu_school"  class="form-control"/></td>
                    </tr>
                    <tr>
                        <td>전공</td>
                        <td><input type="text" id="stu_major" name="stu_major"  class="form-control"/></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <button type="button" class="btn btn-success btn-sm" onclick="update()">수정</button>
                            <button type="button" class="btn btn-warning btn-sm" onclick="delete()">삭제</button>
                            <button type="button" class="btn btn-info btn-sm" onclick="insert()">등록</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

</div>
</body>
</html>