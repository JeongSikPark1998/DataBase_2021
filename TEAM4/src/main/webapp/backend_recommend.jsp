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
    
    session.setAttribute("loginType", loginType);
	session.setAttribute("id", id);
	session.setAttribute("pw", pw);
	session.setAttribute("uco", uco);
%>

<%
   String serverIP = "localhost";
   String strSID = "orcl";
   String portNum = "1521";
   String user = "TEAM4";
   String pass = "1234";
   String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
   Connection conn = null;
   PreparedStatement pstmt,pstmt2;
   ResultSet rs,rs2;
   String sql;
   int cnt;
   ResultSetMetaData rsmd;
   Class.forName("oracle.jdbc.driver.OracleDriver");
   conn = DriverManager.getConnection(url, user, pass);
%>
</head>
<body>
	
<%
	//보여주고 싶은 정보 가져다 쓰시면 됩니다!
	//혹시 몰라서 남겨뒀는데 이건 자신의 지도교수가 상담을 개설했을때 보여주는 겁니다.
	sql = "SELECT * FROM CONSULTATION"
			+ " WHERE CPId = (SELECT TPId FROM FOLLOW_STUDENT WHERE TSId = '"+id+"')"
			+ " AND CSId = '0000000000' AND CSUco = '"+uco+"'";

	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	while(rs.next()){
		//필요한 정보 빼오세용
	}
	rs.close();
	pstmt.close();
%>

<%
	//보여주고 싶은 정보 가져다 쓰시면 됩니다!
	//자신이 수강하는 과목의 교수님의 상담을 보여줍니다.
	sql = "SELECT * FROM CONSULTATION"
			+" WHERE CPId IN (SELECT DISTINCT CId FROM COURSE_REGISTRATION"
			+"		 WHERE CRco IN (SELECT CRco FROM COURSE_REGISTRATION"
			+"				 WHERE CId = '"+id+"')"
			+"		 AND CRFco = (SELECT SFco FROM STUDENT"
			+"				 WHERE SId = '"+id+"')"
			+"		 AND CRUco = '"+uco+"'"
			+"		 AND Role = 'p')"
			+" AND CSId = '0000000000' AND CSUco = '"+uco+"'";

	pstmt2 = conn.prepareStatement(sql);
	rs2 = pstmt.executeQuery();
	while(rs2.next()){
		//필요한 정보 빼오세용
	}
	rs2.close();
	pstmt2.close();
%>

</body>
</html>