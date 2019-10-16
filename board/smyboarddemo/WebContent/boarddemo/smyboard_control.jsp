<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "org.smy.board.*" %>
<%@ page import = "java.util.ArrayList" %>
 
<% request.setCharacterEncoding("UTF-8"); %>
 
<jsp:useBean id="smyboardDTO" class="org.smy.board.smyboardDTO" scope="request" ></jsp:useBean>
<jsp:setProperty property="*" name="smyboardDTO"/> 
<jsp:useBean id="smyboardDAO" class="org.smy.board.smyboardDAO" scope="request" ></jsp:useBean>
<%
/**
*
* @brief 	action구분과 파라메터
*
* @author 	김설규
* @date 	2019-10-16
*
* @param 	action
*
* @remark 	action구분과 파라메터	[2019-10-16; 김설규]
* 
*/
 	String action = request.getParameter("action");
/**
*
* @brief 	action파라메터에 따라 각각처리
*
* @author 	김설규
* @date 	2019-10-16
*
* @param 	action
*
* @remark 	action파라메터	[2019-10-16; 김설규]
* 
*/ 
 	if (action.equals("add")) {

 		pageContext.forward("smyboard_view.jsp?action=add");

 	} else if (action.equals("insert")) {

 		if (smyboardDAO.insertDB(smyboardDTO)) {

 			pageContext.forward("smyboard_control.jsp?action=list");
 		} else {
 			throw new Exception("DB insert err ");
 		}
 		/**
 		*
 		* @brief 	action파라메터 list 시 처리 되는 메서드
 		*
 		* @author 	김설규
 		* @date 	2019-10-16
 		*
 		* @param 	list
 		*
 		* @remark 	값을 호출하고 객체를 생성해 담아 페이지를 이동하여 전달 	[2019-10-16; 김설규]
 		* 
 		*/ 
 	} else if (action.equals("list")) {

 		ArrayList<smyboardDTO> boardList = smyboardDAO.getDBList();

 		request.setAttribute("boardList", boardList);
 		pageContext.forward("smyboard_list.jsp");
 		/**
 		*
 		* @brief 	action파라메터 edit 시 처리 되는 메서드
 		*
 		* @author 	김설규
 		* @date 	2019-10-16
 		*
 		* @param 	edit
 		*
 		* @remark 	값을 호출하고 객체를 생성해 담아 페이지를 이동하여 전달	[2019-10-16; 김설규]
 		* 
 		*/ 
 	} else if (action.equals("edit")) {

 		smyboardDTO = smyboardDAO.getDB(Integer.parseInt((String) request.getParameter("id")));

 		request.setAttribute("smyboardDTO", smyboardDTO);
 		pageContext.forward("smyboard_view.jsp?action=edit");
 		/**
 		*
 		* @brief 	action파라메터 update 시 처리 되는 메서드
 		*
 		* @author 	김설규
 		* @date 	2019-10-16
 		*
 		* @param 	update
 		*
 		* @remark 	 페이지를 이동 바뀐 값  전달 [2019-10-16; 김설규]
 		* 
 		*/ 
 	} else if (action.equals("update")) {

 		if (smyboardDAO.updateDB(smyboardDTO)) {

 			pageContext.forward("smyboard_control.jsp?action=list");
 		} else {
 			throw new Exception("DB update err");
 		}
 		/**
 		*
 		* @brief 	action파라메터 delete 시 처리 되는 메서드
 		*
 		* @author 	김설규
 		* @date 	2019-10-16
 		*
 		* @param 	delete
 		*
 		* @remark 	페이지를 이동 바뀐 값  전달	[2019-10-16; 김설규]
 		* 
 		*/ 
 	} else if (action.equals("delete")) {

 		if (smyboardDAO.deleteDB(Integer.parseInt((String) request.getParameter("id")))) {

 			pageContext.forward("smyboard_control.jsp?action=list");
 		} else {
 			throw new Exception("DB delete err");
 		}

 	} else {
 		out.println("<script>alert('DBerr')</script>");
 	}
 %> 
 
