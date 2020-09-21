<%@page import="com.nidhi.student.StudentDao"%>
<%@page import="com.nidhi.student.StudentDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Attendance</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script>
	function checkOnlyOne(b, status) {
		var x = document.getElementsByClassName(status);
		var i;

		for (i = 0; i < x.length; i++) {
			if (x[i].value != b)
				x[i].checked = false;
		}
	}
	
	function DoOnSubmit(count) {
		if (document.getElementById("sub").value == "null") {
			document.getElementById("SubmitButton").disabled = true;
    		alert("Please choose a subject.");
    		return;
		}
		for(var j = 0; j < count; j++){
			var temp = ""+j;
	    	var checkboxs=document.getElementsByClassName(temp);
	   		var okay=false;
	    	for(var i=0,l=checkboxs.length;i<l;i++) {
	        	if(checkboxs[i].checked) {
	            	okay=true;
	            	break;
	        	}
	    	}
	    	if(!okay) {
	    		document.getElementById("SubmitButton").disabled = true;
	    		alert("Please select an Attendance Status.");
	    		return;
	    	}
	    }
	}

	function DoOnResubmit() {
		document.getElementById("SubmitButton").disabled = false;
	}
	
	
</script>
</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="faculty_menu.jsp"%>
	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			String course = request.getParameter("course");
			String branch = request.getParameter("branch");
			String year = request.getParameter("year");
			String sec = request.getParameter("sec");
			String details = course + "_" + year + "_" + branch + "_" + sec;
			if (details != null) {
				ArrayList<StudentDto> al = new StudentDao().getAllStudent(details);
				if (al.size() > 0) {
	%>
	<div style="width: 40%; margin-left: 30%; margin-top: 5%">
		<form action="MarkAttendance" method="post">
			<div style="margin-left: 17%;">
				<input type="hidden" name="details" value="<%=details%>">
				<table>
					<tr>
						<td><select id="sub" name="sub" class="field"
							onchange="DoOnResubmit()">
								<option value="null">Subject</option>
								<option value="dsa">DSA</option>
								<option value="automata">Automata</option>
								<option value="os">OS</option>
								<option value="dbms">DBMS</option>
						</select></td>
						<td><input type="date" class="field" name="doa"
							required="required"></td>
					</tr>
				</table>
			</div>
			<div>
				<table style="width: 100%" id="tables">
					<tr>
						<th>S.No.</th>
						<th>SIC</th>
						<th>Name</th>
						<th>Status</th>
					</tr>
					<%
						int s = 0, i = 0, count = 0;
									for (StudentDto dto : al) {
										String temp = "" + String.valueOf(i);
										++i;
										++count;
					%>
					<tr>
						<td><%=++s%></td>
						<td><%=dto.getSic()%></td>
						<td><%=dto.getSname()%></td>
						<td><input type="checkbox" class=<%=temp%> id="<%=temp%>"
							name="status" value="p"
							onclick="checkOnlyOne(this.value,<%=temp%>);"
							onchange="DoOnResubmit()">Present <input type="checkbox"
							class=<%=temp%> id="<%=temp%>" name="status" value="a"
							onclick="checkOnlyOne(this.value,<%=temp%>);"
							onchange="DoOnResubmit()">Absent</td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<input type="submit" id="SubmitButton"
				onclick="DoOnSubmit(<%=count%>)" value="Submit" />
		</form>
	</div>
	<%
		} else {
	%>
	<h1 style="text-align: center; color: red">No Students to Show.</h1>
	<%
		}

			}
		}
	%>
</body>
</html>