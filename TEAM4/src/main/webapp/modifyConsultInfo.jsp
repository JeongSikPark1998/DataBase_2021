<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<%
	//���� ȭ���� �ڽ��� ��� ��û ��Ȳ���� Consult Info�� ����ȭ������ �Ѿ�� ��Ȳ�Դϴ�.
	//���� ���������� �����;� �� ������ �л� �ڽ��� sid, pid, CNum(CICode), Uco �Դϴ�.
	request.setCharacterEncoding("UTF-8");
	String loginType = request.getParameter("loginType");
    String sid = request.getParameter("sid");
    String pid = request.getParameter("pid");
    String CICode  = request.getParameter("CICode");
  	// Consult_Info�̰͸� ���� �Է� �޾ƾ���.
    String Consult_content = request.getParameter("Consult_content"); //�̰� paragraph�� ��Ʈ���� �� �� �� ���� �־��
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
	sql = "UPDATE CONSULT_INFO SET"
		 +" Consult_content = '"+Consult_content+"' WHERE "
		 +" SId= '"+sid+"'"
		 +" PId = '"+pid+"'"
		 +" CICode = '"+CICode+"'";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	conn.commit();
	rs.close();
	pstmt.close();
%>

</body>
</html>