<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<%
	//������ ������ ��Ȳ �ٽ� �����ؼ� ���ο� ������ ������� �� �� ���ƿ�!
	//�̹����� �ҷ��;��� ������ ���� ������־ ������ ���� �ʿ��� ���� �����صѰԿ�! uco�� ���� �ʿ��ؼ� �־�ѰԿ�
	String uco = request.getParameter("uco");
	request.setCharacterEncoding("UTF-8");
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

<% //�а� �߰�: �߰��� �Է��� �޾ƾ��մϴ�.
	String FName = request.getParameter("FName");
	String IFCo = request.getParameter("FCo");
	sql = "INSERT INTO FACULTY VALUES('"+FName+"','"+IFCo+"','"+uco+"')";
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();	
	rs.close();
	pstmt.close();
%>

<% //�а� ����
	String DFCo = request.getParameter("DFCo");
	sql = "DELETE FROM FACULTY WHERE FCode = '"+DFCo+"' AND FUco ='"+uco+"'";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rs.close();
	pstmt.close();
%>

<% //�ڽ� �߰�: �߰��� �Է��� �޾ƾ��մϴ�.
	String ICName = request.getParameter("ICName");
	String ICFCo = request.getParameter("ICFCo");
	String ICCode = request.getParameter("ICCode");
	sql = "INSERT INTO COURSE VALUES('"+ICName+"','"+ICCode+"','"+ICFCo+"','"+uco+"');";
			
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();	
	rs.close();
	pstmt.close();
%>

<% //�ڽ� ����
	String DCFCo = request.getParameter("DCFCo");
	String DCCode = request.getParameter("DCCode");
	sql = "DELETE FROM COURSE WHERE CCode = '"+DCCode+"' AND CFco = '"+DCFCo+"' AND CUco = '"+uco+"'";
			
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rs.close();
	pstmt.close();
%>


</body>
</html>