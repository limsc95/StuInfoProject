<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>title</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript">


        $(document).ready(function () {
            loadList();
            if(${!empty messageType}) {
                $("#myMessage").modal("show");
            }
        });

        // <학생리스트 전체 불러오기 테스트>
        function loadList() {
            $.ajax({
                url: "select",
                type: "get",
                dataType: "json",
                success: make,
                error:function(request,error) {
                    console.log(request.responseText);
                    console.log(error);
                }
            });
        }

        // <학생검색 테스트>
        // function sea() {
        //     let se = $("#se").val();
        //     alert(se);
        //     $.ajax({
        //         url: "search",  // /search URL로 요청
        //         type: "get",
        //         data: { se: se },  // `se` 파라미터를 쿼리 스트링으로 전송
        //         dataType: "json",
        //         success: make,
        //         error: function(request, error) {
        //             alert(request.responseText);
        //             alert(error);
        //         }
        //     });
        // }

        function make(data) {

            let listHtml = "<table class='table table-bordered' style='background-color: white'>";
            listHtml += "<tr>";
            listHtml += "<td colspan='2'>";
            listHtml += "<div class='form-inline'>";
            listHtml += "<input type='text' id='' name='' class='form-control' style='width: 80%; margin-right: 10px;'><input type='button' class='btn btn-info btn-sm' value='검색' onClick=''>";
            //text값 받아오기 위해 id, name 임의설정 테스트
            //listHtml += "<input type='text' id='se' name='se' class='form-control' style='width: 80%; margin-right: 10px;'><input type='button' class='btn btn-info btn-sm' value='검색' onClick='sea()'>";
            listHtml += "</div>";
            listHtml += "</td>";
            listHtml += "</tr>";

            listHtml += "<tr>";
            listHtml += "<td>학생번호</td>";
            listHtml += "<td>이름</td>";
            listHtml += "</tr>";

            $.each(data, function (index, obj) {
                listHtml += "<tr>";
                listHtml += "<td>" + obj.stu_list_no + "</td>";
                // 이름 클릭하면 학생정보 불러오기
                listHtml += "<td id='t'" + obj.stu_list_no + "><a href='javascript:get()'>" + obj.stu_list_name + "</a></td>";
                listHtml += "</tr>";
            });

            listHtml += "</table>";
            $("#test").html(listHtml);
        }
    </script>
</head>
<body>
<div class="container">
    <h2 style="text-align: center">학생 검색</h2>
        <div class="row">
            <div class="col-md-6">
                <div class="left-panel">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="text-align: center"><h3>학생 리스트</h3></div>
                            <table class='table table-bordered'>
                                <div id="test" class="panel-heading" style='background-color: white'>

                                </div>
                            </table>
                    </div>
                </div>
            </div>

                <div class="col-md-6">
                    <div class="right-panel">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="text-align: center"><h3>학생 정보</h3></div>
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
                                            <td><input type="text"id="stu_add" name="stu_add"  class="form-control" > </td>
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
                                                <button type="button" class="btn btn-success btn-sm" onclick="">수정</button>
                                                <button type="button" class="btn btn-warning btn-sm" onclick="">삭제</button>
                                                <button type="button" class="btn btn-info btn-sm" onclick="">등록</button>
                                            </td>
                                        </tr>
                                    </table>
                                </form>
                        </div>
                    </div>
                </div>
        </div>

    <div id="myMessage" class="modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">${messageType}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="message">${message}</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" >Close</button>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>
