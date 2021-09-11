<%@ page import="Classes.User" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 07.10.2020
  Time: 8:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User currentUser = (User) request.getSession().getAttribute("CURRENT_USER");
    boolean online = false;
    if(currentUser != null){
        online = true;
    }
%>
