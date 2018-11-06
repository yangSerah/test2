<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin - Blank Page</title>

    <!-- Bootstrap core CSS-->
    <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="resources/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="resources/css/sb-admin.css" rel="stylesheet">

  </head>

  <body id="page-top">
	<!-- navbar -->
    <c:import url="./module/navbar.jsp"></c:import>

    <div id="wrapper">

      <!-- Sidebar -->
      <c:import url="./module/sidebar.jsp"></c:import>

      <div id="content-wrapper">

        <div class="container-fluid">

          <!-- Breadcrumbs-->
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a href="main">Dashboard</a>
            </li>
            <li class="breadcrumb-item active">Blank Page</li>
          </ol>

          <!-- Page Content -->
          <h1>Blank Page</h1>
          <hr>
          	<div id="map" style="width:100%;height:350px;"></div>
			<div id="clickLatlng"></div>

        </div>
        <!-- /.container-fluid -->

        <!-- Sticky Footer -->
        <c:import url="./module/footer.jsp"></c:import>

      </div>
      <!-- /.content-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <c:import url="./module/logoutModal.jsp"></c:import>

    <!-- Bootstrap core JavaScript-->
    <script src="resources/vendor/jquery/jquery.min.js"></script>
    <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="resources/js/sb-admin.min.js"></script>
    
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
	
	var zooName;
	var zooAddress;
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
	var reqLat = document.getElementById('reqLat[]');
	var reqLong = document.getElementById('reqLong[]');
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
	</script>

  </body>

</html>
