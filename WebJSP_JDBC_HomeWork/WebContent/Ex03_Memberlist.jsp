<%@page import="kr.or.bit.utils.Singleton_Helper"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/*  
	 1.관리자만 접근 가능한 페이지
	 2.로그인한 일반 회원이 주소값을 외워서 ... 접근불가 
	 3.그러면  회원에 관련되 모든 페이지 상단에는 아래 코드를 ..... : sessionCheck.jsp >> include 
	*/
	 if(session.getAttribute("userid") == null || !session.getAttribute("userid").equals("admin") ){
		//강제로 페이지 이동
		//out.print("<script>location.href='Ex02_JDBC_Login.jsp'</script>");
		response.sendRedirect("Ex02_JDBC_Login.jsp");
	} 
%>	

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- Primary Meta Tags -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="title" content="Pixel Lite - Free Bootstrap 4 UI Kit">
	<meta name="author" content="Themesberg">
	<meta name="description" content="Open source and accessibility first Bootstrap Design System featuring over 80 premium components and 4 example pages.">
	<meta name="keywords" content="bootstrap, Bootstrap Design System, accessiblity, accessibility first, open source, open source Bootstrap Design System" />
	<link rel="canonical" href="https://themesberg.com/product/ui-kits/pixel-lite-free-bootstrap-4-ui-kit">
	
	<!-- Favicon -->
	<link rel="apple-touch-icon" sizes="120x120" href="./assets/img/favicon/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="./assets/img/favicon/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="./assets/img/favicon/favicon-16x16.png">
	<link rel="manifest" href="./assets/img/favicon/site.webmanifest">
	<link rel="mask-icon" href="./assets/img/favicon/safari-pinned-tab.svg" color="#ffffff">
	<meta name="msapplication-TileColor" content="#ffffff">
	<meta name="theme-color" content="#ffffff">
	
	<!-- Fontawesome -->
	<link type="text/css" href="./vendor/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet">
	
	<!-- Pixel CSS -->
	<link type="text/css" href="./css/pixel.css" rel="stylesheet">
</head>
<body>
	<header class="header-global">
		<jsp:include page="/common/Top.jsp"></jsp:include>
	</header>
	<main>
	<section class="section section-lg">
	<div class="container">
	
	<!-- <table class="w-100">  -->
			
			<!--  
				회원 목록(리스트) 출력
				목록 (select id, ip from koreamember)
			-->	
				<%
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try{
						conn = Singleton_Helper.getConnection("oracle");
						String sql="select id, ip from koreamember";
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery(); 
				%>	
				
					<table class="table table-hover">
						<thead>
							<tr>
							<th scope="col">#회원이름</th>
				            <th scope="col">#회원 IP</th>
				            <th scope="col">#삭제</th>
				            <th scope="col">#수정</th>
				            </tr>
				        </thead>
				        <tbody>    
						<% while(rs.next()){ %>
							<tr>
								<td>
									<div class="d-flex align-items-center">
										<a href='Ex03_MemberDetail.jsp?id=<%=rs.getString("id")%>'><%=rs.getString("id")%></a>
									</div>
								</td>
								<td><%=rs.getString("ip")%></td>
								<td>
									<div class="d-flex align-items-center">
										<a href="Ex03_MemberDelete.jsp?id=<%=rs.getString("id")%>"><i class="fas fa-trash text-danger ml-3" data-toggle="tooltip" data-placement="top" title="Delete item"></i></a>
									</div>	
								</td>
								<td>
									<div class="d-flex align-items-center">
										<a href="Ex03_MemberEdit.jsp?id=<%=rs.getString("id")%>"><i class="fas fa-edit ml-3" data-toggle="tooltip" data-placement="top" title="Edit item"></i></a>
									</div>
								</td>
							
						<% } %>
					<div class="container text-center">
					<hr>
					<!-- 
					<div>
						<label for="exampleInputIcon2">Icon Right</label>
						<div class="input-group mb-4">
                        <input class="form-control" id="exampleInputIcon2" placeholder="Icon Right" aria-label="Input group" type="text">
                        <div class="input-group-append">
                            <span class="input-group-text"><span class="fas fa-search"></span></span>
                        </div>
                    	</div>
                    </div>
                    -->
                    	<div class="row">
							<form action="Ex03_MemberSearch.jsp" method="post">
								<label for="search"><i class="fas fa-user fa-3x"></i></label>
								<input type="text" name="search" id="search" placeholder="회원 이름 입력" class="col-3 ml-3 rounded">
								<!--  <input type="submit" value="검색"><i class="fas fa-search"></i>-->
								<button class="btn btn-outline-primary fa-2x" type="submit" value="검색"><i class="fas fa-search"></i>검색하기</button>
							</form>
						</div>
						
					<hr>
					</div>
									
				<%	
					}catch(Exception e){
						
					}finally{
						Singleton_Helper.close(rs);
						Singleton_Helper.close(pstmt);
					}
				%>
				
				
				
			</tbody>
			</table>
			</div>
		</section>
	</main>
	<footer class="footer pt-7 pb-6 bg-primary text-white">
		<jsp:include page="/common/Bottom.jsp" />
	</footer>
	
</body>
</html>