<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Team4: Consultation</title>
<%
	request.setCharacterEncoding("UTF-8");
	//login 모든 정보 새로 입력 받아야 함.
	String loginType = request.getParameter("loginType");
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    String uco = request.getParameter("uco");
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
		sql = "SELECT SId FROM STUDENT"
				+" WHERE SId = '"+id+"'"
				+" AND SPw= '"+pw+"'"
				+" AND SUco = '"+uco+"'";
	}
	else if (loginType.equals("PROFESSOR")) {
		sql = "SELECT PId FROM PROFESSOR"
				+" WHERE PId = '"+id+"'"
				+" AND PPw= '"+pw+"'"
				+" AND PUco = '"+uco+"'";
	}
	else if (loginType.equals("ADMIN")) {
		sql = "SELECT SId FROM STUDENT"
				+" WHERE SId = '"+id+"'"
				+" AND SPw= '"+pw+"'"
				+" AND SUco = '"+uco+"'";
	}
	else {
		sql = "";
	}
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = rs.getMetaData();
	RequestDispatcher dispatcher;
	if (rsmd.getColumnCount() >= 1) {
		//login 성공
		System.out.println("success");
		if(loginType.equals("STUDENT")){
			dispatcher = request.getRequestDispatcher("main_student.jsp");
		}
		else if(loginType.equals("PROFESSOR")){
			dispatcher = request.getRequestDispatcher("main_professor.jsp");
		}
		else{
			dispatcher = request.getRequestDispatcher("main_administrator.jsp");
		}
		dispatcher.forward(request, response);
	}
	else {
		//login 실패
		System.out.println("failed");
	}
	rs.close();
	pstmt.close();
%>

</body>
</html>