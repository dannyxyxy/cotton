<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        #map {
            width: 100%;
            height: 300px;
            margin-top: 10px;
            display: none;
        }
    </style>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8030f1881b41d3cc1dfafec0c630e729&libraries=services"></script>
    <script>
        var mapContainer = document.getElementById('map'),
            mapOption = {l;
                center: new daum.maps.LatLng(37.537187, 127.005476),
                level: 5
            };

        var map = new daum.maps.Map(mapContainer, mapOption);
        var geocoder = new daum.maps.services.Geocoder();
        var marker = new daum.maps.Marker({
            position: new daum.maps.LatLng(37.537187, 127.005476),
            map: map
        });

        function sample5_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = data.address;
                    document.getElementById("sample5_address").value = addr;
                    geocoder.addressSearch(data.address, function(results, status) {
                        if (status === daum.maps.services.Status.OK) {
                            var result = results[0];
                            var coords = new daum.maps.LatLng(result.y, result.x);
                            mapContainer.style.display = "block";
                            map.relayout();
                            map.setCenter(coords);
                            marker.setPosition(coords);
                        } else {
                            alert('주소 검색에 실패했습니다. 다시 시도하세요.');
                        }
                    });
                }
            }).open();
        }
    </script>

</head>

	<body>
	<div class="container mt-5">
        <h3>로그인</h3>
        <form action="login.do" method="post">
            <div class="form-group">
                <label for="id">ID</label>
                <input type="text" class="form-control" name="id" id="id" placeholder="아이디" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" class="form-control" name="pw" id="pw" placeholder="비밀번호" required>
            </div>
            <input type="text" id="sample5_address" placeholder="주소">
            <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색" class="btn btn-secondary"><br>
            <div id="map"></div>
            <button class="btn btn-primary mt-2">로그인</button>
        </form>
    </div>
			
			
		</div>
	</body>
	
</html>