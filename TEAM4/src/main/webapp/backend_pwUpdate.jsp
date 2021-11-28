<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<%
	request.setCharacterEncoding("UTF-8");
	String loginType = (String)session.getAttribute("loginType");
    String id = (String)session.getAttribute("id");
    String uco = (String)session.getAttribute("uco");
    String pwUpdate = request.getParameter("pwUpdate"); //이것만 새로 입력 받아야함.
%>

<%
   String serverIP = "localhost";
   String strSID = "orcl";
   String portNum = "1521";
   String user = "TEAM4";
   String pass = "1234";
   String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
   Connection conn = null;
   
   PreparedStatement pstmt;
   ResultSet rs;
   String sql;
   int cnt;
   ResultSetMetaData rsmd;
   Class.forName("oracle.jdbc.driver.OracleDriver");
   conn = DriverManager.getConnection(url, user, pass);
%>
</head>
<body>
<%
	
	if (loginType.equals("STUDENT")) {
		sql = "UPDATE STUDENT SET"
				+" SPW = '"+pwUpdate+"' WHERE"
				+" SId= '"+id+"'"
				+" AND SUco = '"+uco+"'";
	}
	else if (loginType.equals("PROFESSOR")) {
		sql = "UPDATE PROFESSOR SET"
				+" SPW = '"+pwUpdate+"' WHERE"
				+" PId= '"+id+"'"
				+" AND SUco = '"+uco+"'";
	}
	else {
		sql = "";
	}
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	conn.setAutoCommit(false);
	conn.commit();
	response.sendRedirect("main_student.jsp");
	rs.close();
	pstmt.close();
%>

</body>
</html>