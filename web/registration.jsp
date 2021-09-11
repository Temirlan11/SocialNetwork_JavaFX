<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 07.10.2020
  Time: 2:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration Page</title>
    <%@include file="vendor/head.jsp"%>
</head>
<body>
    <%@include file="vendor/navbar.jsp"%>

    <section class="section" style="margin-top: 30px">
        <div class="column">
            <div class="container">
                <%
                    String success = request.getParameter("success");
                    if(success != null){
                %>
                <div class="alert alert-success" role="alert">
                    Registration succesfull!
                </div>
                <%
                    }
                %>
                <%
                    String emailerror = request.getParameter("emailerror");
                    if(emailerror != null){
                %>
                <div class="alert alert-danger" role="alert">
                    Such mail already exists!
                </div>
                <%
                    }
                %>
                <%
                    String passworderror = request.getParameter("passworderror");
                    if(passworderror != null){
                %>
                <div class="alert alert-danger" role="alert">
                    Passwords do not match!
                </div>
                <%
                    }
                %>
            </div>

            <div class="container">
                <form action="/registration" method="post">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Email address</label>
                        <input type="email" class="form-control"  name="email" id="exampleInputEmail1" aria-describedby="emailHelp">
                        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Password</label>
                        <input type="password" name="pass" class="form-control" id="exampleInputPassword1">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword11">Re-Password</label>
                        <input type="password"  name="repass" class="form-control" id="exampleInputPassword11">
                    </div>
                    <div class="form-group">
                        <label for="fullname">Full Name</label>
                        <input type="text" class="form-control" name="full_name" id="fullname">
                    </div>
                    <div class="form-group">
                        <label for="Birthdate1">Birthdate</label>
                        <input type="text" class="form-control" name="birth_date" id="Birthdate1">
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="exampleCheck1">
                        <label class="form-check-label" for="exampleCheck1">Check me out</label>
                    </div>
                    <button type="submit" class="btn btn-primary" style="background-color: midnightblue">Submit</button>
                </form>
            </div>
        </div>
    </section>
</body>
</html>
