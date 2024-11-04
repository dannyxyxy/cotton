<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
	<!-- datepicker -->
	
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8030f1881b41d3cc1dfafec0c630e729&libraries=services"></script>
	
	
<style type="text/css">
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .writeAll {
            width: 50%;
            margin: 0 auto;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }
        input, select, button {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        button {
            background-color: #333;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        button:hover {
            background-color: #555;
        }
        .btn-secondary {
            background-color: #e0e0e0;
            color: #333;
            margin-right: 10px;
        }
        .btn-secondary:hover {
            background-color: #ccc;
        }
        .flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .half-width {
            width: 48%;
        }
</style>

<script type="text/javascript">
// 페이지 로딩 후 설정
$(function() {
    console.log("jQuery loading...");

    let now = new Date();
    let startYear = now.getFullYear();
    let yearRange = (startYear - 100) + ":" + (startYear);

    // 날짜입력 설정 - datepicker
    $(".datepicker").datepicker({
        dateFormat: "yy-mm-dd",
        changeMonth: true,
        changeYear: true,
        monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
        dayNamesMin: ["일","월","화","수","목","금","토"],
        yearRange: yearRange,

    });
    
 // 아이디 중복 확인 이벤트
    $("#ID").keyup(function() {
        let id = $("#ID").val();
        if (id.length >= 4) {
            $.ajax({
<<<<<<< HEAD
                url: "/ajax/checkId.do",
                type: "POST",
                data: { id: id },
                success: function(response) {
                    if (response.indexOf("중복") == -1) {
                        $("#checkIdDiv").removeClass("alert-danger").addClass("alert-success");
                        $("#checkIdDiv").text("사용 가능한 아이디입니다.");
                    } else {
                        $("#checkIdDiv").removeClass("alert-success").addClass("alert-danger");
                        $("#checkIdDiv").text("이미 사용 중인 아이디입니다.");
                    }
                },
                error: function() {
                    $("#checkIdDiv").removeClass("alert-success").addClass("alert-danger");
                    $("#checkIdDiv").text("아이디 확인 중 오류가 발생했습니다.");
                }
            });
        } else {
            $("#checkIdDiv").removeClass("alert-success").addClass("alert-danger");
            $("#checkIdDiv").text("아이디는 4자 이상이어야 합니다.");
        }
    }); 
    
    
    
    

    // 비밀번호와 비밀번호 확인 이벤트
    $("#PW, #pw2").keyup(function() {
        let pw = $("#PW").val();
        let pw2 = $("#pw2").val();

        if (pw.length < 4) {
            $("#pwDiv").removeClass("alert-success alert-danger").addClass("alert-danger");
            $("#pwDiv").text("비밀번호는 필수입력입니다. 4자 이상 입력하세요.");
        } else {
            $("#pwDiv").removeClass("alert-success alert-danger").addClass("alert-success");
            $("#pwDiv").text("사용할 수 있는 비밀번호입니다.");
        }

        if (pw2.length < 4) {
            $("#pw2Div").removeClass("alert-success alert-danger").addClass("alert-danger");
            $("#pw2Div").text("비밀번호 확인은 필수입력입니다. 4자 이상 입력하세요.");
        } else {
            if (pw != pw2) {
                $("#pw2Div").removeClass("alert-success alert-danger").addClass("alert-danger");
                $("#pw2Div").text("비밀번호와 일치하지 않습니다.");
            } else {
                $("#pw2Div").removeClass("alert-success alert-danger").addClass("alert-success");
                $("#pw2Div").text("비밀번호와 일치합니다.");
            }
        }
    });

});

</script>

</head>
<body>
<div class="container writeAll">
    <br><br>
    <form action="/member/write.do" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <h2>회원가입</h2>
            <br>
            
            	
            
            <label for="id">아이디</label>
            <input type="text" class="form-control" maxlength="20" 
            pattern="^[a-zA-Z][a-zA-Z0-9]{4,19}$" required placeholder="아이디 입력" id="ID" name="id">
        </div>
        <div id="checkIdDiv" class="alert alert-danger">
            아이디를 입력해주세요.
        </div>
        <div class="form-group">
            <label for="pw">비밀번호</label>
            <input type="password" class="form-control" maxlength="20" 
            required pattern="^.{4,20}$" placeholder="비밀번호 입력" id="PW" name="pw">
        </div>
        <div id="pwDiv" class="alert alert-danger">
            비밀번호를 입력해주세요.
        </div>
        <div class="form-group">
            <label for="pw2">비밀번호확인</label>
            <input type="password" class="form-control" maxlength="20" 
            required pattern="^.{4,20}$" placeholder="비밀번호 입력" id="pw2">
        </div>
        <div id="pw2Div" class="alert alert-danger">
            비밀번호를 한번 더 입력해주세요.
        </div>

        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" maxlength="10" 
            pattern="^[a-zA-Z가-힣]{2,10}$" placeholder="이름" required>
        </div>

        <div class="form-group">
            <label for="tel">전화번호</label>
            <input type="text" id="tel" name="tel" placeholder="전화번호" required>
        </div>

        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" placeholder="이메일" required>
        </div>

        <div class="form-group flex">
            <div class="half-width">
                <label for="birth">생년월일</label>
                <input type="text" id="birth" name="birth" 
                class="datepicker" placeholder="YYYY-MM-DD" required>
            </div>
            <div class="half-width">
                <label for="gender">성별</label>
                <select id="gender" name="gender">
                    <option value="">성별</option>
                    <option value="남자">남자</option>
                    <option value="여자">여자</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label for="address2">주소입력</label>
            <input type="text" id="address" name="address" placeholder=" '구'만 입력해주세요 ex)은평구 " >
=======
                url: "/member/checkId.do",
                type: "POST",
                data: { id: id },
                success: function(response) {
                    if (response === "available") {
                        $("#checkIdDiv").removeClass("alert-danger").addClass("alert-success");
                        $("#checkIdDiv").text("사용 가능한 아이디입니다.");
                    } else {
                        $("#checkIdDiv").removeClass("alert-success").addClass("alert-danger");
                        $("#checkIdDiv").text("이미 사용 중인 아이디입니다.");
                    }
                },
                error: function() {
                    $("#checkIdDiv").removeClass("alert-success").addClass("alert-danger");
                    $("#checkIdDiv").text("아이디 확인 중 오류가 발생했습니다.");
                }
            });
        } else {
            $("#checkIdDiv").removeClass("alert-success").addClass("alert-danger");
            $("#checkIdDiv").text("아이디는 4자 이상이어야 합니다.");
        }
    }); 
    
    
    
    

    // 비밀번호와 비밀번호 확인 이벤트
    $("#PW, #pw2").keyup(function() {
        let pw = $("#PW").val();
        let pw2 = $("#pw2").val();

        if (pw.length < 4) {
            $("#pwDiv").removeClass("alert-success alert-danger").addClass("alert-danger");
            $("#pwDiv").text("비밀번호는 필수입력입니다. 4자 이상 입력하세요.");
        } else {
            $("#pwDiv").removeClass("alert-success alert-danger").addClass("alert-success");
            $("#pwDiv").text("사용할 수 있는 비밀번호입니다.");
        }

        if (pw2.length < 4) {
            $("#pw2Div").removeClass("alert-success alert-danger").addClass("alert-danger");
            $("#pw2Div").text("비밀번호 확인은 필수입력입니다. 4자 이상 입력하세요.");
        } else {
            if (pw != pw2) {
                $("#pw2Div").removeClass("alert-success alert-danger").addClass("alert-danger");
                $("#pw2Div").text("비밀번호와 일치하지 않습니다.");
            } else {
                $("#pw2Div").removeClass("alert-success alert-danger").addClass("alert-success");
                $("#pw2Div").text("비밀번호와 일치합니다.");
            }
        }
    });

});

var mapContainer = document.getElementById('map'), // 지도를 표시할 div
mapOption = {
    center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
    level: 5 // 지도의 확대 레벨
};

//지도를 미리 생성
var map = new daum.maps.Map(mapContainer, mapOption);
//주소-좌표 변환 객체를 생성
var geocoder = new daum.maps.services.Geocoder();
//마커를 미리 생성
var marker = new daum.maps.Marker({
position: new daum.maps.LatLng(37.537187, 127.005476),
map: map
});


function sample5_execDaumPostcode() {
new daum.Postcode({
    oncomplete: function(data) {
        var addr = data.address; // 최종 주소 변수

        // 주소 정보를 해당 필드에 넣는다.
        document.getElementById("sample5_address").value = addr;
        // 주소로 상세 정보를 검색
        geocoder.addressSearch(data.address, function(results, status) {
            // 정상적으로 검색이 완료됐으면
            if (status === daum.maps.services.Status.OK) {

                var result = results[0]; //첫번째 결과의 값을 활용

                // 해당 주소에 대한 좌표를 받아서
                var coords = new daum.maps.LatLng(result.y, result.x);
                // 지도를 보여준다.
                mapContainer.style.display = "block";
                map.relayout();
                // 지도 중심을 변경한다.
                map.setCenter(coords);
                // 마커를 결과값으로 받은 위치로 옮긴다.
                marker.setPosition(coords)
            }
        });
    }
}).open();
}



</script>

</head>
<body>
<div class="container writeAll">
    <br><br>
    <form action="/member/write.do" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <h2>회원가입</h2>
            <br>
            
            	
            
            <label for="id">아이디</label>
            <input type="text" class="form-control" maxlength="20" 
            pattern="^[a-zA-Z][a-zA-Z0-9]{4,19}$" required placeholder="아이디 입력" id="ID" name="id">
        </div>
        <div id="checkIdDiv" class="alert alert-danger">
            아이디를 입력해주세요.
        </div>
        <div class="form-group">
            <label for="pw">비밀번호</label>
            <input type="password" class="form-control" maxlength="20" 
            required pattern="^.{4,20}$" placeholder="비밀번호 입력" id="PW" name="pw">
        </div>
        <div id="pwDiv" class="alert alert-danger">
            비밀번호를 입력해주세요.
        </div>
        <div class="form-group">
            <label for="pw2">비밀번호확인</label>
            <input type="password" class="form-control" maxlength="20" 
            required pattern="^.{4,20}$" placeholder="비밀번호 입력" id="pw2">
        </div>
        <div id="pw2Div" class="alert alert-danger">
            비밀번호를 한번 더 입력해주세요.
        </div>

        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" maxlength="10" 
            pattern="^[a-zA-Z가-힣]{2,10}$" placeholder="이름" required>
        </div>

        <div class="form-group">
            <label for="tel">전화번호</label>
            <input type="text" id="tel" name="tel" placeholder="전화번호" required>
        </div>

        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" placeholder="이메일" required>
        </div>

        <div class="form-group flex">
            <div class="half-width">
                <label for="birth">생년월일</label>
                <input type="text" id="birth" name="birth" 
                class="datepicker" placeholder="YYYY-MM-DD" required>
            </div>
            <div class="half-width">
                <label for="gender">성별</label>
                <select id="gender" name="gender">
                    <option value="">성별</option>
                    <option value="남자">남자</option>
                    <option value="여자">여자</option>
                </select>
            </div>
        </div>

        <div class="form-group">
        	<input type="text" id="sample5_address" placeholder="주소">
			<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
			<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>

            <label for="address2">상세 주소</label>
            <input type="text" id="address2" name="address2" placeholder="상세주소 (동, 호수) 입력" >
>>>>>>> branch 'main' of https://github.com/dannyxyxy/cotton.git
        </div>

        <div class="form-group flex">
            <br><br>
            <button type="button" class="btn-secondary" id="cancelBtn" onclick="history.back()">취소</button>
            <button type="submit" id="signBtn">회원 가입</button>
        </div>
    </form>
</div>
</body>
</html>