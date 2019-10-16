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

 	} else if (action.equals("list")) {

 		ArrayList<smyboardDTO> boardList = smyboardDAO.getDBList();

 		request.setAttribute("boardList", boardList);
 		pageContext.forward("smyboard_list.jsp");
 	} else if (action.equals("edit")) {

 		smyboardDTO = smyboardDAO.getDB(Integer.parseInt((String) request.getParameter("id")));

 		request.setAttribute("smyboardDTO", smyboardDTO);
 		pageContext.forward("smyboard_view.jsp?action=edit");

 	} else if (action.equals("update")) {

 		if (smyboardDAO.updateDB(smyboardDTO)) {

 			pageContext.forward("smyboard_control.jsp?action=list");
 		} else {
 			throw new Exception("DB update err");
 		}

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
 
