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
	//login ��� ���� ���� �Է� �޾ƾ� ��.
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
	//�����ְ� ���� ���� ������ ���ø� �˴ϴ�!
	//Ȥ�� ���� ���ܵ״µ� �̰� �ڽ��� ���������� ����� ���������� �����ִ� �̴ϴ�.
	sql = "SELECT * FROM CONSULTATION"
			+ " WHERE CPId = (SELECT TPId FROM FOLLOW_STUDENT WHERE TSId = '"+id+"')"
			+ " AND CSId = '0000000000' AND CSUco = '"+uco+"'";

	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	while(rs.next()){
		//�ʿ��� ���� ��������
	}
	rs.close();
	pstmt.close();
%>

<%
	//�����ְ� ���� ���� ������ ���ø� �˴ϴ�!
	//�ڽ��� �����ϴ� ������ �������� ����� �����ݴϴ�.
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
		//�ʿ��� ���� ��������
	}
	rs2.close();
	pstmt2.close();
%>

</body>
</html>