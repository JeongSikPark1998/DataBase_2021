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
	String SId = request.getParameter("SId"); // ��û�ϴ� ���� ����
	String Consult_Type = request.getParameter("Consult_Type");
	String Consult_Space = request.getParameter("Consult_Space");
	String C_Max_Reserv_Num = request.getParameter("C_Max_Reserv_Num");
	String CTime = request.getParameter("CTime");
	String CProfName = request.getParameter("CProfName");
	String CNum = request.getParameter("CNum");
	String CStuName = request.getParameter("CStuName");
	String CPId = request.getParameter("CPId");
	String CDate = request.getParameter("CDate");
	String CSUco = request.getParameter("CSUco");
    //������ �������� ������ consultation block���� �������� �� ���̰�
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

<% //���� ����
	//sql ������ ���� ���� üũ�� �ؼ� ������ ������ ������ �Բ� �������� �� ������ �ް�,
	sql = "SELECT COUNT(*), C_Max_Reserv_Num FROM CONSULTATION WHERE CNum = '"+CNum+"' GROUP BY CNum, C_Max_Reserv_Num";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	String countMember = rs.getString(1);
	int maxCount = rs.getInt(2);
	if (Integer.parseInt(countMember) > maxCount) {
		//��û �Ұ�!! �˸� ���鼭 alert() �����鼭, ������ �� ���̰� �ϰų�, ���� �������� ������ ������ �� ���!
	}
	rs.close();
	pstmt.close();
%>

<%
	//��û form���� �޾ƿ� ������
	String SFName = "",grade= "";
	int age = 0;
	double GPA = 0;
	String military="",content="";
%>

<%  //CONSULTATION ����
	//INSERT INTO CONSULTATION VALUES('FOLLOW', 'A7127', 4, '13:00 - 13:30', 'Arely', '0112', 'Jett', '2019171428', '2014135925', '2021-12-16', '11001');
	sql = "INSERT INTO CONSULTATION VALUES('"+Consult_Type +"', '"+Consult_Space +"', "+C_Max_Reserv_Num+", '"+CTime+"', '"+CProfName+"', '"+CNum+"', '"+SFName+"', '"+SId+"', '"+CPId+"', '"+CDate+"', '"+CSUco+"')";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	conn.commit(); //commit!!!
	rs.close();
	pstmt.close();
%>

<%  //CONSULT_INFO ����
	sql = "INSERT INTO CONSULT_INFO VALUES('"+CNum+"', '"+SFName+"', "+grade+", "+GPA+", "+age+", "+military+", '"+content+"', '"+SId+"', '"+CPId+"')";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	conn.commit(); //commit!!!
	rs.close();
	pstmt.close();
%>


</body>
</html>