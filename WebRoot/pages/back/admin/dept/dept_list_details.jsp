<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="mvc.vo.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String insertUrl = basePath + "pages/back/admin/dept/dept_insert.jsp";
	String showDeptUrl = basePath + "pages/back/admin/dept/dept_show.jsp";
	String empInsertUrl = basePath + "pages/back/admin/emp/emp_insert.jsp";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>雇员管理程序</title>
<base href="<%=basePath%>">
<link type="text/css" rel="stylesheet" href="css/ppcss.css">
<script type="text/javascript" src="js/ppjs.js"></script>
</head>
<body>
	<%
		List<Dept> all = (List<Dept>) request.getAttribute("allDepts");
		Iterator<Dept> iter = all.iterator();
	%>
	<h1>部门信息</h1>
	<table border="1" cellpadding="8" cellspacing="0" width="100%" bgcolor="#F2F2F2">
		<tr onmouseover="changeColor(this,'#FFFFFF')" onmouseout="changeColor(this,'#F2F2F2')">
			<td width="10%"><strong>部门编号</strong></td>
			<td width="10%"><strong>部门名称</strong></td>
			<td width="10%"><strong>部门位置</strong></td>
			<td width="10%"><strong>部门人数</strong></td>
			<td width="10%"><strong>工资合计</strong></td>
			<td width="10%"><strong>平均工资</strong></td>
			<td width="10%"><strong>最高工资</strong></td>
			<td width="10%"><strong>最低工资</strong></td>
			<td width="10%"><strong>操作</strong></td>
		</tr>
		<%
			while (iter.hasNext()) {
				Dept vo = iter.next();
		%>
		<tr onmouseover="changeColor(this,'#FFFFFF')" onmouseout="changeColor(this,'#F2F2F2')">
			<td><%=vo.getDeptno()%></td>
			<td><%=vo.getDname()%></td>
			<td><%=vo.getLoc()%></td>
			<td><%=vo.getStat().get("count")%></td>
			<td><%=vo.getStat().get("sum")%></td>
			<td><%=vo.getStat().get("avg")%></td>
			<td><%=vo.getStat().get("max")%></td>
			<td><%=vo.getStat().get("min")%></td>
			<td><a href="<%=empInsertUrl %>?deptno=<%=vo.getDeptno()%>">增加新雇员</a></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>
