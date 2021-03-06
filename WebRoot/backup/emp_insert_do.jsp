<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="mvc.factory.*"%>
<%@ page import="mvc.vo.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String listUrl = basePath + "pages/back/admin/emp/emp_list_split.jsp";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>雇员管理程序</title>
<base href="<%=basePath %>">
</head>
<body>
	<%
  	request.setCharacterEncoding("UTF-8");
	SmartUpload smart = new SmartUpload();
	smart.initialize(config,request,response);
	smart.upload();
  	Emp vo = new Emp();
  	vo.setEmpno(Integer.parseInt(smart.getRequest().getParameter("empno")));
  	vo.setEname(smart.getRequest().getParameter("ename"));
  	vo.setJob(smart.getRequest().getParameter("job"));
  	vo.setHiredate(new SimpleDateFormat("yyyy-MM-dd").parse(smart.getRequest().getParameter("hiredate")));//this.pstmt.setDate(4, new java.sql.Date(vo.getHiredate().getTime()));		vo.setHiredate(new Date());
  	vo.setSal(Double.parseDouble(smart.getRequest().getParameter("sal")));
  	vo.setComm(Double.parseDouble(smart.getRequest().getParameter("comm")));
  	int tempMgr = Integer.parseInt(smart.getRequest().getParameter("mgr"));
  	if (tempMgr != 0){//表示有雇员领导
  		Emp mgr = new Emp();
  		mgr.setEmpno(tempMgr);
  		vo.setMgr(mgr);
  	}
  	int tempDeptno = Integer.parseInt(smart.getRequest().getParameter("deptno"));
  	if (tempDeptno != 0){
		Dept dept = new Dept();
  		dept.setDeptno(tempDeptno);
  		vo.setDept(dept);
  	}
  	String fileName = "nophoto.jpg";
  	if (smart.getFiles().getFile(0).getSize() > 0){
	  	if (smart.getFiles().getFile(0).getContentType().contains("image")) {
	  		fileName = java.util.UUID.randomUUID() + "." + smart.getFiles().getFile(0).getFileExt();
	  	}
  	}
  	vo.setPhoto(fileName);
  	vo.setNote(smart.getRequest().getParameter("note"));
  	String msg = "雇员信息增加失败!";
  	if(ServiceFactory.getIEmpServiceInstance().insert(vo)){
  	  	if (smart.getFiles().getFile(0).getSize() > 0){
  		  	if (smart.getFiles().getFile(0).getContentType().contains("image")) {
  		  		String filePath = getServletContext().getRealPath("/upload/") + fileName;
  		  		smart.getFiles().getFile(0).saveAs(filePath);
  		  	}
  	  	}
  		msg = "雇员信息增加成功!";
  	}
  %>
	<script type="text/javascript">
  	alert("<%=msg%>");
  	window.location = "<%=listUrl%>";
  </script>
</body>
</html>
