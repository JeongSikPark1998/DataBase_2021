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
<h2>Welcome to Consultation Service</h2><br><br>
	<h3>LOGIN</h3>
	<h4>GET and POST Methods to Read Form Data</h4>
	
	<!-- insert id, password, and university code from user -->
	<fieldset>
		<legend>Fill out the form</legend>
		<ul>
			<li>
				<label for="id">ID: </label>
				<input type="text" id="id" name="id">
			</li>
			<li>
				<label for="pw">PASSWORD:  </label>
				<input type="text" id="pw" name="pw">
			</li>
			<li>
				<label for="uco">University Code: </label>
				<input type="text" id="uco" name="uco" size="5">
			</li>
		</ul>
	</fieldset><br>
	<!-- select role(occupation) by User (radio button) -->
	<fieldset>
		<legend>Select which section you are taking</legend>
		<input type="radio" name="loginType" id="professor" value="professor">
		<label for="professor">Professor</label>
		<input type="radio" name="loginType" id="student" value="student">
		<label for="student">Student</label>
		<input type="radio" name="loginType" id="manager" value="manager">
		<label for="manager">Manager</label>
	</fieldset><br>
	<!-- Sign In button -->
	<div id="buttons">
		<input type="SignIn" value="Sign In">
	</div>
	
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
	if (rsmd.getColumnCount() >= 1) {
		//login 성공
	}
	else {
		//login 실패
	}
	rs.close();
	pstmt.close();
%>

</body>
</html>
