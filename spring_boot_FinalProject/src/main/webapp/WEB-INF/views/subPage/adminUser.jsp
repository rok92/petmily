<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>펫밀리가 떴다</title>
		<!-- header  -->
		<c:import url="/WEB-INF/views/layout/header.jsp"/>
		
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/board.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/adminUser.css"/>">
		
		<script src="<c:url value="/js/adminUser.js"/>"></script>
	</head>
	
	<body>
		<!-- header  -->
		<c:import url="/WEB-INF/views/layout/top.jsp"/>
			
		<section class="wrap">
			<!-- 관리자 레이아웃 시작 -->
			<article>
				<!-- sidebar -->
				<c:import url="/WEB-INF/views/layout/adminSide.jsp"/>
				
				<div class="main-layout">
					<div class="pageTitle">
						<div>
							<span>#사용자관리</span>
						</div>
					</div>	
					<form method="post" id="userFrm" class="userFrm" name="userFrm" action="<c:url value="/adminUserSearch/0"/>">
						<table class="search-table">
							<tr>
								<td>
									<c:if test="${maxPageNum ne 0}">
										<div class="blue">총 ${maxCnt}</div>
									</c:if>	
								</td>
								<td>
									<div id="dropdown-box" class="dropdown-box">
										<div id="dpBox-name" class="dpBox-name">전체</div>
										
										<c:if test="${empty chk_search}">
											<input type="hidden" id="chk_search" name="chk_search" value="0" />
										</c:if>
										
										<c:if test="${not empty chk_search}">
											<input type="hidden" id="chk_search" name="chk_search" value="${chk_search}" />
										</c:if>
										
										<div class="dpBox-div">▼</div>
									</div>
									<ul class="dropdown-contents">
										<li class="dp-all">전체</li>
										<li class="dp-id">ID</li>
										<li class="dp-name">이름</li>
										<li class="dp-activeDate">접속일</li>
									</ul>
									<div class="search-box">
										<div>
											<input type="text" id="text_search" name="text_search" class="text_search" value="${text_search}" placeholder="검색어를 입력하세요.">
											<button class="search-button"><img src="<c:url value="/images/search.png"/>"></button>
										</div>
									</div>
								</td>
							</tr>
						</table>
					</form>	
					<div class="table-box">
						<table>
							<thead>
								<tr>
							      	<th class="num">번호</th>
							      	<th class="id">ID</th>
							      	<th class="name">이름</th>
							      	<th>이메일</th>
							     	<th class="date">가입일</th>
							      	<th class="date">접속일</th>
							      	<th class="author">권한</th>
							    </tr>
							</thead>
							<tbody>
								<c:if test="${maxPageNum eq 0}">
									<tr>
										<td colspan="8">내용이 없습니다.</td>
									</tr>							
								</c:if>
								<c:if test="${maxPageNum ne 0}">
									<c:forEach var="list" items="${lists}" varStatus="loop">
									    <tr>
									      	<td>${loop.count}</td>
									      	<td><a class="atxtUnderline" href="<c:url value="/adminUserDetail/${list.userId}"/>">${list.userId}</a></td>
									      	<td>${list.userName}</td>
									      	<td>${list.userEmail}</td>
									      	<td><fmt:formatDate value="${list.createDate}" pattern="yyyy-MM-dd HH:mm:dd"/></td>
									      	<td><fmt:formatDate value="${list.activeDate}" pattern="yyyy-MM-dd HH:mm:dd"/></td>
									      	<td>
									      		<c:if test="${list.userAuthor eq '0'}">사용자</c:if>
												<c:if test="${list.userAuthor eq '1'}">관리자</c:if>
									      	</td>
									    </tr>
								    </c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
					<div class="paging-box">
						<input type="hidden" id="flag" value="${sessionScope.flag}" />
						<input type="hidden" id="maxPage" value="${maxPageNum}" />
						<ul>
							<c:if test="${maxPageNum ne 0}">
								<c:if test="${maxPageNum ne 1}">
									<li class="firstPager">
										<div title="첫 페이지로 이동하기">
											<<
										</div>
									</li>
									<li class="prevPager">
										<div title="이전 페이지로 이동하기">
											<
										</div>
									</li>
								</c:if>
	
								<c:forEach var="i" begin="1" end="${maxPageNum}">
								<li>
									<div class="active" value="${i}">${i}</div>
								</li>
								</c:forEach>
							
								<c:if test="${maxPageNum ne 1}">
									<li class="nextPager">
										<div title="다음 페이지로 이동하기">
											>
										</div>
									</li>
									<li class="lastPager">
										<div title="마지막 페이지로 이동하기">
											>>
										</div>
									</li>
								</c:if>
							</c:if>
						</ul>
					</div>
				</div>
			</article>
			<!-- 관리자 레이아웃 종료 -->
		</section>
		
		<!-- footer -->
		<c:import url="/WEB-INF/views/layout/footer.jsp"/>
	</body>
</html>