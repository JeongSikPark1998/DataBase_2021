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
	String uco = request.getParameter("uco"); //입력받아야함!
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

<%//해당 학교 개설 학과 불러오기
	sql = "SELECT * FROM FACULTY WHERE FUco = '"+uco+"'";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rs.close();
	pstmt.close();
%>

<%//해당 학교 개설 강좌 불러오기
	sql = "SELECT * FROM COURSE WHERE CUco = '"+uco+"'";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();	
	rs.close();
	pstmt.close();
%>

여기에서 이제 추가 삭제 만들면 될듯!!

</body>
</html>

