<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <!-- 자바 클래스 Import  -->
<%@ page import = "org.smy.board.*" %>
<%@ page import = "java.util.ArrayList" %>

<%-- request 내장객체의 한글 인코딩 --%>    
<% request.setCharacterEncoding("UTF-8"); %>

<%-- 자바빈즈 사용 --%>   
<jsp:useBean id="smyboardDTO" class="org.smy.board.smyboardDTO" scope="request" ></jsp:useBean>

<%-- 자바빈즈에 폼정보 전달 --%> 
<jsp:setProperty property="*" name="smyboardDTO"/>

<%-- 자바빈즈 사용, scope은 request --%>  
<jsp:useBean id="smyboardDAO" class="org.smy.board.smyboardDAO" scope="request" ></jsp:useBean>
 
<%

    // action구분 등 파라메터
 	String action = request.getParameter("action");

    ///////////////////////////////////////////
    // action에 따라 각각 처리
    /////////////////////////////////////////// 
 	if (action.equals("add")) {

 		// 게시판 입력화면 오픈
 		pageContext.forward("smyboard_view.jsp?action=add");

 	} else if (action.equals("insert")) {

 		// 게시판 입력
 		if (smyboardDAO.insertDB(smyboardDTO)) {

 			// 조회를 위하여 controll 호출
 			pageContext.forward("smyboard_control.jsp?action=list");
 		} else {
 			throw new Exception("DB 입력오류");
 		}

 	} else if (action.equals("list")) {

 		// 게시판 조회결과
 		ArrayList<smyboardDTO> boardList = smyboardDAO.getDBList();

 		// List를 setAttribute
 		request.setAttribute("boardList", boardList);
 		pageContext.forward("smyboard_list.jsp");
 	} else if (action.equals("edit")) {

 		// edit용 1건을 select
 		smyboardDTO = smyboardDAO.getDB(Integer.parseInt((String) request.getParameter("id")));

 		// edit를 setAttribute
 		request.setAttribute("smyboardDTO", smyboardDTO);
 		pageContext.forward("smyboard_view.jsp?action=edit");

 	} else if (action.equals("update")) {

 		// 게시판 수정
 		if (smyboardDAO.updateDB(smyboardDTO)) {

 			// 조회를 위하여 controll 호출
 			pageContext.forward("smyboard_control.jsp?action=list");
 		} else {
 			throw new Exception("DB 수정오류");
 		}

 	} else if (action.equals("delete")) {

 		// 게시판 삭제
 		if (smyboardDAO.deleteDB(Integer.parseInt((String) request.getParameter("id")))) {

 			// 조회를 위하여 controll 호출
 			pageContext.forward("smyboard_control.jsp?action=list");
 		} else {
 			throw new Exception("DB 삭제오류");
 		}

 	} else {

 		out.println("<script>alert('err')</script>");

 	}
 %> 
 
