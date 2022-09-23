/********************************
 * 파일명 : contactResult.js
 * 용 도 : 공지사항 세부화면 페이징
 * 작성자 : 황재윤
*********************************/

$(document).ready(function(){
	
	// 초기화
   	var flag = $("#flag").val();
   	$("div.active").eq(flag).addClass("aSelected");
   	
   	// 페이지 번호 버튼 클릭했을 때
   	$(".active").click(function(e) {
   		var pageNum = parseInt($(this).attr('value') - 1);
   		var submitPath = "/contactResult/" + pageNum + "/" + $("#userId").val();
   		
   		$("#userFrm").attr('action', submitPath);
   		$("#userFrm").submit();
	});
	
	// 첫 페이지 버튼 클릭했을 때
   	$(".firstPager > div").click(function() {
   		var pageNum = parseInt(0);
   		var submitPath = "/contactResult/" + pageNum + "/" + $("#userId").val();
   		
   		$("#userFrm").attr('action', submitPath);
   		$("#userFrm").submit();   	
   	});

   	// 이전 버튼 클릭했을 때
   	$(".prevPager > div").click(function() {
   		var pageNum = parseInt(flag - 1);
   		var submitPath = "/contactResult/" + pageNum + "/" + $("#userId").val();
   		
   		if(pageNum < 0) {
   			alert("첫 페이지 입니다.");
   			return false;
   		}
   		
   		$("#userFrm").attr('action', submitPath);
   		$("#userFrm").submit();   	
   	});
   	
   	// 다음 버튼 클릭했을 때
   	$(".nextPager > div").click(function() {
   		var pageNum = parseInt(flag + 1);
   		var submitPath = "/contactResult/" + pageNum + "/" + $("#userId").val();
   		
   		if(pageNum >= $("#maxPage").val()) {
			alert("마지막 페이지입니다.");
			return false;
		}
   		
   		$("#userFrm").attr('action', submitPath);
   		$("#userFrm").submit();   	
   	});
   	
	// 첫 페이지 버튼 클릭했을 때
   	$(".lastPager > div").click(function() {
   		var pageNum = $("#maxPage").val() - 1;
   		var submitPath = "/contactResult/" + pageNum + "/" + $("#userId").val();
   		
		$("#userFrm").attr('action', submitPath);
   		$("#userFrm").submit();   	
   	});
   	
  	// 전체동의 체크박스 체크시 전체 체크
  	// 전체체크 선택 시 변수 값 저장
  	var arrBoardId = new Array();	// 배열선언
	$('#allCheck').click(function() {
		if($(this).is(':checked')){	// 체크되었을 때
			$('.agree_subcheck').prop('checked', true);
			
			// 변수값 저장
			arrBoardId = [];	// 초기화 필요
			$(".agree_subcheck:checked").each(function() {
				arrBoardId.push($(this).val());
				
			});
			// console.log(arrBoardId);
		} else {
			$('.agree_subcheck').prop('checked', false);
			
			// 변수값 제거
			$(".agree_subcheck").each(function() {
				arrBoardId.shift($(this).val());
			});
		}
	});
	
	// 체크박스 선택 시 변수값 저장
	$(".agree_subcheck").on('click', function() {
		if($(".agree_subcheck:checked").length == 10) $('#allCheck').prop('checked', true);
		
		if($(this).is(':checked')) {
			arrBoardId.push($(this).val());
		} else {
			arrBoardId = arrBoardId.filter((e) => e !== $(this).val());
			$('#allCheck').prop('checked', false);
		}
	});
	
	// 삭제 기능
	$("#adminNoticeDel").on('click', function() {
	
		// submit 이벤트 기본 기능 : 페이지 새로 고침
 		// 기본 기능 중단
 		event.preventDefault();

 		// 유효성 추가
 		if(arrBoardId.length == 0) {
 			alert("삭제 내역이 없습니다.");
 			return false;
 		} else {
 			if(confirm("삭제하겠습니까")) {
		 		$.ajax({
		 			type:"post",
		 			url:"/adminDeleteNotice",
		 			data:{ "boardIds": JSON.stringify(arrBoardId) },
					dataType:"text",
					success:function(result){
						// 성공 시 결과 받음
						if(result == "SUCCESS") {
							alert("삭제되었습니다.");
							location.href = "/contactResult/0/" + $("#userId").val();
						}
					},
					error:function(){
						// 오류있을 경우 수행 되는 함수
						alert("전송 실패");
					}
		 		});
	 		} else {
	 			$('#allCheck').prop('checked', false);
	 			$(".agree_subcheck").prop('checked', false);
	 			arrBoardId = [];	// 초기화 필요
	 		}
	 	} 
	});	
});

	