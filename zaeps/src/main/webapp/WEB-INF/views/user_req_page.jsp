<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>클릭한 위치에 마커 표시하기</title>
<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-2.1.0.min.js"></script>

<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

</head>
<body>
<h1>사용자 설정</h1>
<div id="map" style="width:100%;height:350px;"></div>
<div id="clickLatlng"></div>
<div>
	<form name="insertForm" action="insertUserReq.do" method="post">
	<p>
		우리 위도 : 
		<input type="text" id="reqLat[0]" class="reqLat" name="list[0].reqLat" readonly>
		우리 경도 :
		<input type="text" id="reqLong[0]" class="reqLong" name="list[0].reqLong" readonly>
		동물 종 :
		<select id="aniTypeNo[0]" class="aniTypeNo" name="list[0].aniTypeNo">
			<option value="" selected>선택 </option>
			<c:forEach var="i" items="${aniTypeList}">
				<option value="${i.aniTypeNo}">${i.aniName}</option>
			</c:forEach>
		</select>
		필요 센서 개수 : 
		<input type="text" id="aniCount[0]" class="aniCount" size="5" maxlength="3" name="list[0].aniCount">개
		<button type="button" class="btn btn-danger" name="delete">삭제</button>
		<!-- <button type="button" name="complete" class="btn btn-success">입력 완료</button> -->
	</p>
	<div id="appendDiv"></div>
		
	<br>
	<button type="button" class="btn btn-default" id="plus_btn" onclick="plus()">우리 추가</button>
	<input type="hidden" id="complete_btn_flag" name="complete_btn_flag" value="flagUnCheck">
	<button type="button" id="submit_btn" class="btn btn-primary">등록</button>
	<!-- <button type="button" id="select_ani_btn" class="btn btn-primary">선택 완료</button> -->
	</form>
</div>

<!-- 부트스트랩 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- 다음 지도 api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a026737c907423f0e922ae661fd8c0ea&libraries=services"></script>

<script>
/* 다음 지도 api */
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
		center: new daum.maps.LatLng(35.855192, 127.144395), // 지도의 중심좌표
		level: 3 // 지도의 확대 레벨
	};

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

//주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();

//마커 선언
var marker;
//윈도인포우(장소 설명 상자) 선언
var infowindow;

var zooName = '${memberInfo.zooName}';
var zooAddress = '${memberInfo.address}';
// 주소로 좌표를 검색합니다
geocoder.addressSearch(zooAddress, function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === daum.maps.services.Status.OK) {

        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        marker = new daum.maps.Marker({
            map: map,
            position: coords
        });
		
        // 인포윈도우로 장소에 대한 설명을 표시합니다
        infowindow = new daum.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">' + zooName + '</div>',
            removable: true
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } else {
    	alert('동물원 주소가 올바르지 않습니다. 다시 설정해 주세요.');
    }
});

var count = 0;
var reqLat = document.getElementById('reqLat[' + count + ']');
var reqLong = document.getElementById('reqLong[' + count + ']');
// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
daum.maps.event.addListener(map, 'click', function(mouseEvent) {        
	infowindow.close();
	// 클릭한 위도, 경도 정보를 가져옵니다 
	latlng = mouseEvent.latLng; 
	
	// 마커 위치를 클릭한 위치로 옮깁니다
	marker.setPosition(latlng);
	
	if(count > 0) {
		reqLat = document.getElementById('reqLat[' + count + ']');
		reqLong = document.getElementById('reqLong[' + count + ']');
		console.log('count 체크 : ' + count);
	}
	reqLat.value = latlng.getLat();
	reqLong.value = latlng.getLng();
});

//우리추가 버튼
function plus() {
	var length = $('p').length;
	if($('#complete_btn_flag').val() == 'flagCheck') {
		count++;
		$('#complete_btn_flag').val('flagUnCheck');
		var html = '';
		html += '<p>';
		html += '우리 위도 : ';
		html += '<input type="text" id="reqLat[' + count + ']" class="reqLat" name="list[' + count + '].reqLat" readonly> ';
		html += '우리 경도 : ';
		html += '<input type="text" id="reqLong[' + count + ']" class="reqLong" name="list[' + count + '].reqLong" readonly> ';
		html += '동물 종 : ';
		html += '<select id="aniTypeNo[' + count + ']" class="aniTypeNo" name="list[' + count + '].aniTypeNo">';
		html += '	<option value="" selected>선택</option>';
		html += '	<c:forEach var="i" items="${aniTypeList}">';
		html += '	<option value="${i.aniTypeNo}">${i.aniName}</option>';
		html += '	</c:forEach>';
		html += '</select> ';
		html += '필요 센서 개수 : ';
		html += '<input type="text" id="aniCount[' + count + ']" class="aniCount" size="5" maxlength="3" name="list[' + count + '].aniCount">개 ';
		html += '<button type="button" class="btn btn-danger" name="delete">삭제</button> ';
		html += '</p>';
		$('#appendDiv').append(html);
	} else if($('#complete_btn_flag').val() == 'flagUnCheck') {
		var result = check();
		if(result) {
			plus();
		}
	}
	
}

//삭제 버튼
$(document).on('click', 'button[name="delete"]', function() {
	var length = $('p').length;
	if(length > 1) {
		$(this).parent().remove();
	} else if(length == 1) {
		alert('최소 한개의 우리는 입력해야 합니다.');
	} else {
		alert('삭제 오류, length = ' + length);
	}
	
});

$('#submit_btn').click(function() {
	var completeFlag = $('#complete_btn_flag').val();
	if(completeFlag == 'flagUnCheck') {
		var result = check();
		if(result) {
			document.insertForm.submit();
		}
	} else if(completeFlag == 'flagCheck') {
		document.insertForm.submit();
	} else {
		alert('전송 오류, completeFlag = ' + completeFlag);
	}
});

//폼 유효성 검사
function check() {
	var lat = document.getElementById('reqLat[' + count + ']');
	var lng = document.getElementById('reqLong[' + count + ']');
	var aniTypeNo = document.getElementById('aniTypeNo[' + count + ']');
	var aniCount = document.getElementById('aniCount[' + count + ']');
	
	if (lat.value == "" || lng.value == "") {
		alert("위도 경도를 입력하지 않았습니다.");
		return false;
	}
 	if (aniTypeNo.options[aniTypeNo.selectedIndex].value == "" || aniTypeNo.options[aniTypeNo.selectedIndex].value == null) {
		alert("동물 종을 입력해주세요.");
		return false;
	}
	if (aniCount.value == "") {
		alert("필요한 센서 개수를 입력해주세요.");
		return false;
	}
	//유효성 검사 성공 시 input 박스 readonly 변경 후 플래그 변경
	$('#complete_btn_flag').val('flagCheck');
	
	console.log('입력완료 버튼 테스트');
	return true;
}
</script>
</body>
</html>