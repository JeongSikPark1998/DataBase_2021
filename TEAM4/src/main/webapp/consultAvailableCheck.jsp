<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>checking...</title>
<%
	request.setCharacterEncoding("UTF-8");
    String CNum = (String)session.getAttribute("CNum21");
	int selectnumIn = Integer.parseInt(request.getParameter("select_num"));
	session.setAttribute("selectnumIn", selectnumIn);
%>

<%
   String serverIP = "localhost";
   String strSID = "orcl";
   String portNum = "1521";
   String user = "TEAM4";
   String pass = "1234";
   String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
   Connection conn = null;
   PreparedStatement pstmt,pstmt2,pstmt3;
   ResultSet rs;
   String sql;
   int cnt;
   ResultSetMetaData rsmd;
   Class.forName("oracle.jdbc.driver.OracleDriver");
   conn = DriverManager.getConnection(url, user, pass);
   conn.setAutoCommit(false); 
%>

</head>
<body>
<h1>checking...</h1>
<% //본인 정보
	//sql 순서가 들어가기 전에 체크를 해서 넘으면 내보내 에러랑 함께 내보내고 안 넘으면 받고,
	sql = "SELECT COUNT(*), C_Max_Reserv_Num FROM CONSULTATION WHERE CNum = '"+CNum+"' GROUP BY CNum, C_Max_Reserv_Num";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = rs.getMetaData();
	rs.next();
	cnt = rsmd.getColumnCount();
	String countMember = rs.getString(1);
	String maxCount = rs.getString(2);
	rs.close();
	pstmt.close();
	if (Integer.parseInt(countMember) > Integer.parseInt(maxCount)) {
		out.println("alert(\"This reservation is full reserved\");");
		out.println("<nav><li><a href=\"main_student.jsp\">go back to main page</a></li></nav>");
	}
	else {
		out.println("<nav><li><a href=\"insert_info_student.jsp\">please go to write a info</a></li></nav>");
	}
	%>
</body>
</html>