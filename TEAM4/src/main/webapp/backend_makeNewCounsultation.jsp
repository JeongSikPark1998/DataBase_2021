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
	//signUpConsultation �л� ��� ��û - ���ü� ����
	String CProfName = request.getParameter("CProfName");
	String CNum = request.getParameter("CNum"); // �ڵ�����
	String PId = request.getParameter("CPId");
	String Uco = request.getParameter("CSUco");
    //CProfName, PId, Uco�� ������ ������ �������� �Է� �޾ƾ���.
    //���� ������ �α��� ������ ���� ���������� �ҷ��;���.
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
	//���� form���� �޾ƿ� ������
	int C_Max_Reserv_Num = 0;
	String Consult_Type = "",Consult_Space= "";
	String CTime="",Date="";
%>

<%  //CONSULTATION ����
	//INSERT INTO CONSULTATION VALUES('FOLLOW', 'A7127', 4, '13:00 - 13:30', 'Arely', '0112', 'Jett', '2019171428', '2014135925', '2021-12-16', '11001');
	sql = "INSERT INTO CONSULTATION VALUES('"+Consult_Type +"', '"+Consult_Space +"', "+C_Max_Reserv_Num+", '"+CTime+"', '"+CProfName+"', "+"(SELECT MAX(CNum) + 1 FROM CONSULTATION)"+", NULL, DEFAULT, '"+PId+"', '"+Date+"', '"+Uco+"')";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	conn.commit(); //commit!!!
	rs.close();
	pstmt.close();
%>


</body>
</html>