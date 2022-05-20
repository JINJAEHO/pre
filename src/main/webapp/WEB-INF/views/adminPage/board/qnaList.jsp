<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QNAList</title>
    
    <!-- CSS -->
    <link rel="preconnect" href="https://fonts.gstatic.com" />
	<link rel="preconnect" href="https://fonts.googleapis.com" />
	
 	<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Sunflower:wght@300;500&display=swap" rel="stylesheet" />
	<link href="https://fonts.sandbox.google.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,700,1,200" rel="stylesheet" />
    
    
    <link rel="stylesheet" href="/resources/css/adminPage/common.css">
    <link rel="stylesheet" href="/resources/css/adminPage/qnaList.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
    	window.name = "parentPage";
    </script>
</head>
<body>
   	<%@ include file="/WEB-INF/views/common/header.jsp" %>	
    <main>
		<%@ include file="/WEB-INF/views/adminPage/common/sideMenu.jsp" %>	

        <div class="divider"></div>

        <section class="content-board">
            <div class="title">
                <h2 style="maring-bottom:1rem;">FAQ/QNA </h2>
            </div>

            <div class="board_list_menu">
                <a class="QNA_category" onclick="window.location='/adminPage/qnaConfig'">QNA 카테고리</a>
                <a class="FAQ_category" onclick="window.location='/adminPage/faqConfig'">FAQ 카테고리</a>
                <a class="QNA_list" onclick="window.location='/adminPage/board/qnaList'">QNA 리스트</a>
                <a  class="FAQ_list" onclick="window.location='/adminPage/faq/faqList'">FAQ 리스트</a>
            </div>
      <div class=contents>
		<table class = "boardTable" >
			<%-- <tr>
				<td colspan="5" align="left">
					<button onclick="window.location='/board/write'">글작성</button>
				</td>
			</tr>--%>
			<tr class = "tableHeader" style="margin-bottom: 0.5rem;" >
				<td style="margin-left: 0.1rem">No.</td>
				<td style="margin-left: 2.2rem">제목</td>
				<td style="margin-left: 4.3rem">작성일</td>
				<td style="margin-left: -0.5rem; margin-right:0.5rem">수정일</td>
				<td style="margin-left: -3rem">카테고리</td>
			</tr>
			<%-- board : BoardVO 객체 담기는 변수 
				 items : 컨트롤러로부터 전달받은 List<BoardVO> 리스트 
						리스트의 요소 개수만큼 자동으로 반복하며, 하나씩 꺼내서 board변수에 체워줌 --%>
			<c:forEach var="board" items="${list}">
				<tr class="tableBody">
					<td class="no">${board.board_no}</td>
					<td class="title"><a class="move" href="${board.board_no}">${board.board_title}</a></td>
					<td class="date"><fmt:formatDate value="${board.create_date}" pattern="yyyy-MM-dd" /></td>
					<td class="date"><fmt:formatDate value="${board.update_date}" pattern="yyyy-MM-dd" /></td>
					<td class="type">${board.category}</td>
				</tr>	
			</c:forEach>
			
		</table>
		<div class = "buttonWrap">
			<%-- 검색바 --%>
			<form class = "categoryForm" id="categoryForm" action="/adminPage/board/categorySearch" method="get">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<select class = "categorySearch" id = "categorySearch" name="category">
					<option value="all">전체보기</option>
					<c:forEach var="item" items="${cate}" >
							<option value="${item.qna_cate_name}"> ${item.qna_cate_name} </option>
	                </c:forEach>
				</select>
				<input class ="SearchBtn" type="submit" value="검색" />
			</form>
				<button class ="writeBtn"onclick="window.location='/adminPage/board/write'">문의하기</button>
		</div>
		
		<br />
		

		
		<form action="/adminPage/board/qnaList" method="get" id="pagingForm">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
			<input type="hidden" name="listQty" value="${pageMaker.cri.listQty}" />
			<input type="hidden" name="type" value="${pageMaker.cri.type}" />
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
		</form>
	</div>

            
            
            
        </section>
    </main>
</body>
</html>

<script>
	$(document).ready(function(){
			let pagingForm = $("#pagingForm");
			// 게시글 제목 클릭시, content 페이지로 이동 처리 
			$(".move").click(function(e){
				
				e.preventDefault(); 
				// 숨김 폼 태그에 bno input hidden으로 태그 추가 
				pagingForm.append("<input type='hidden' name='board_no' value='"+ $(this).attr("href") + "' />"); 
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/adminPage/board/content"); 
				pagingForm.submit();  // 서브밋! 이동!! 
			});
			
			$("#categoryForm").submit(function(){
				if($("#categorySearch").val() == 'all') {
					pagingForm.attr("action", "/adminPage/board/qnaList"); 
					pagingForm.submit();  // 서브밋! 이동!! 
	                return false
	            }
				return true
		    }); // end submit()
		    
		});
	</script>