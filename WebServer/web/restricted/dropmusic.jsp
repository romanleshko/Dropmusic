<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <jsp:include page="header.jsp"/>
    <title>DropMusic</title>
</head>


<body>
<h1>DropMusic</h1>
<s:form action="albumSearch" method="GET">
    <s:textfield name="inputObject.keyword" />
</s:form>
</body>
</html>
