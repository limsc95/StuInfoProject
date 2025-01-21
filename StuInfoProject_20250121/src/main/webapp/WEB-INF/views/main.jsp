<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
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

        function enterKeyPress(event){
            if(event.keyCode == 13){
                loadList();
            }
        }

        function loadList() {

            let stu_list_name = $("#stu_list_name").val();
                    console.log(stu_list_name);

            $.ajax({
                url: "getList",
                type: "get",
                data: {"stu_list_name":stu_list_name},
                dataType: "json",
                success: nameList,
                error:function(request,error){
                    console.log(request.responseText);
                    console.log(error);
                }
            });
        }

        function nameList(data) {

            let listHtml = "";

            $.each(data, function (index, obj) {
                listHtml += "<tr>";
                listHtml += "<td>" + obj.stu_list_no + "</td>";
                listHtml += "<td id='t'><a href='javascript:infoList("+obj.stu_list_no+")'>" + obj.stu_list_name + "</a></td>";
                listHtml += "</tr>";
            });

            $("#table1").html(listHtml);

        }

        function showModal(message, stu_list_name) {

            $('#modalStuName').val(stu_list_name);

            $('#myMessage').modal('show');
        }

        function infoList(stu_list_no) {

            $.ajax({
                url: "getInformation",
                type: "get",
                data: {"stu_list_no":stu_list_no},
                dataType: "json",
                success: function(response) {
                    // 서버에서 받은 데이터로 input 값 설정
                    console.log(response); // 서버에서 받은 데이터를 콘솔에 출력

                    // 예시: 서버에서 받은 데이터는 { id: 123, name: "John Doe", status: "Active" } 형태일 것
                    // 서버 응답을 통해 id 값을 input에 반영
                    $("#stu_no").val(response.stu_no);  // <input id="stu_id" />에 값 설정
                    $("#stu_name").val(response.stu_name); // <input id="stu_name" />에 이름 설정
                    $("#stu_addr").val(response.stu_addr); // <input id="stu_status" />에 상태 설정
                    $("#stu_school").val(response.stu_school);
                    $("#stu_major").val(response.stu_major);
                },
                error:function(request,error){
                    console.log(request.responseText);
                    console.log(error);
                    }
            });

        }

        function goToInsert() {

            $("#stu_no").val();
            $("#stu_name").val($("#modalStuName").val());
            $("#stu_addr").val();
            $("#stu_school").val();
            $("#stu_major").val();

        }


        function studentDelete() {
            let stu_no = $("#stu_no").val(); // 삭제할 학생 번호 가져오기

            if (!stu_no) {
                alert("삭제할 학생 번호를 입력하세요.");
                return;
            }

            $.ajax({
                url: "studentDelete/"+stu_no,
                type: "delete",
                data: {"stu_no":stu_no},
                success: function () {
                    alert("삭제가 완료되었습니다.");
                    reset();
                },
                error: function (request, error) {
                    console.log(request.responseText);
                    console.log(error);
                    alert("삭제 중 오류가 발생했습니다.");
                }
            });
        }

        function studentUpdate() {
            let stuData = {
                stu_no: $("#stu_no").val(),
                stu_name: $("#stu_name").val(),
                stu_addr: $("#stu_addr").val(),
                stu_school: $("#stu_school").val(),
                stu_major: $("#stu_major").val()
            };

            if (!stuData.stu_name || !stuData.stu_addr || !stuData.stu_school || !stuData.stu_major) {
                alert("모든 필드를 입력하세요.");
                return;
            }

            $.ajax({
                url: "update",
                type: "put",
                contentType: "application/json",
                data: JSON.stringify(stuData),
                success: function () {
                     alert("수정이 완료되었습니다.");
                     reset(); // 입력 필드 초기화
                 },
                error: function (request, error) {
                    console.log(request.responseText);
                    console.log(error);
                }
            });
        }

        function studentInsert() {
            let stuData = {
                stu_name: $("#stu_name").val(),
                stu_addr: $("#stu_addr").val(),
                stu_school: $("#stu_school").val(),
                stu_major: $("#stu_major").val()
            };

            if (!stuData.stu_name || !stuData.stu_addr || !stuData.stu_school || !stuData.stu_major) {
                alert("모든 필드를 입력하세요.");
                return;
            }

            $.ajax({
                url: "insert", // 서버에서 처리할 경로
                type: "post", // HTTP 메서드
                contentType: "application/json", // JSON 데이터 전송
                data: JSON.stringify(stuData), // 데이터를 JSON 문자열로 변환
                success: function () {
                    alert("등록이 완료되었습니다.");
                    reset(); // 입력 필드 초기화
                },
                error: function (request, error) {
                    console.log(request.responseText);
                    console.log(error);
                    alert("등록 중 오류가 발생했습니다.");
                }
            });
        }

        function reset(){
            $("#stu_no").val("");
            $("#stu_name").val("");
            $("#stu_addr").val("");
            $("#stu_school").val("");
            $("#stu_major").val("");
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
                        <div class="panel-heading text-center">
                            <h3>학생 리스트</h3>
                        </div>
                        <div class="panel-body" style="background-color: white;">
                            <div class="form-inline" style="margin-bottom: 15px;">
                                <input type="text" id="stu_list_name" class="form-control" style="width: 80%; margin-right: 10px;" onkeypress="enterKeyPress(event)">
                                <input type="button" class="btn btn-info btn-sm" value="검색" onclick="loadList()">
                            </div>

                            <table class='table table-bordered'>
                                <thead>
                                    <tr>
                                        <td>학생번호</td>
                                        <td>이름</td>
                                    </tr>
                                </thead>
                                <tbody id="table1">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                </div>
                <div class="col-md-6">
                    <div class="right-panel">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="text-align: center">
                                <h3>학생 정보</h3>
                            </div>
                            <form id="frm">
                                <table class="table">
                                    <tr>
                                        <td>번호</td>
                                        <td><input type="text" id="stu_no" name="stu_no" class="form-control" readonly="readonly"/></td>
                                    </tr>
                                    <tr>
                                        <td>이름</td>
                                        <td><input type="text" id="stu_name" name="stu_name" class="form-control"/></td>
                                    </tr>
                                    <tr>
                                        <td>사는곳</td>
                                        <td><input type="text"id="stu_addr" name="stu_addr"  class="form-control" > </td>
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
                                            <button type="button" class="btn btn-success btn-sm" onclick="studentUpdate()">수정</button>
                                            <button type="button" class="btn btn-warning btn-sm" onclick="studentDelete()">삭제</button>
                                            <button type="button" class="btn btn-info btn-sm" onclick="studentInsert()">등록</button>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
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