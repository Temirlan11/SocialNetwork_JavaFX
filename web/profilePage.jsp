<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 10.10.2020
  Time: 0:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@include file="vendor/head.jsp"%>
</head>
<body>
    <%@include file="vendor/navbar.jsp"%>

    <%
        if(online){
            User user = (User) request.getSession().getAttribute("CURRENT_USER");
    %>

    <div class="container">
        <div class="row mt-5">
            <div class="col-lg-3">
                <div class="card" style="width: 16rem;">
                    <img src="<%=user.getPicture_url()%>" class="card-img-top" alt="...">
                    <div class="card-body">
                        <ul class="list-group">
                            <li class="list-group-item"><%=user.getFull_name()%></li>
                            <li class="list-group-item"><a href="#">My Profile</a></li>
                            <li class="list-group-item"><a href="#">Settings</a></li>
                            <li class="list-group-item"><a href="#" style="color: crimson">Logout</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="column">
                    <div class="container mb-5">
                        <form action="/updateprofile" method="post">
                            <h4>Edit Profile</h4>
                            <div class="form-group">
                                <label for="exampleInputEmail1">Email address</label>
                                <input type="email" class="form-control" id="exampleInputEmail1" name="email" value="<%=user.getEmail()%>" aria-describedby="emailHelp" disabled>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputFullName1">Full Name</label>
                                <input type="text" class="form-control" name="full_name" id="exampleInputFullName1" value="<%=user.getFull_name()%>">
                                <small id="emailHelp4" class="form-text text-muted">Change your full name</small>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputBirthdate2">Birthdate</label>
                                <input type="text" class="form-control" name="birthdate" id="exampleInputBirthdate2" value="<%=user.getBirth_date()%>">
                                <small id="emailHelp5" class="form-text text-muted">Change your birthdate</small>
                            </div>
                            <button type="submit" name="action" value="update_profile" class="btn btn-primary" style="background-color: midnightblue">Update Profile</button>
                        </form>
                    </div>

                    <div class="container mb-5">
                        <form action="/updateprofile" method="post">
                            <h4>Edit Picture</h4>
                            <div class="form-group">
                                <label for="exampleInputPicture1">URL</label>
                                <input type="text" class="form-control" id="exampleInputPicture1" name="picture_url" value="<%=user.getPicture_url()%>">
                                <small id="emailHelp" class="form-text text-muted">Input url of your profile photo</small>
                            </div>
                            <button type="submit" name="action" value="update_url" class="btn btn-primary" style="background-color: midnightblue">Update URL</button>
                        </form>
                    </div>

                    <div class="container mb-5">
                        <form action="/updateprofile" method="post">
                            <h4>Update Password</h4>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Old Password</label>
                                <input type="password" class="form-control" name="old_password" id="exampleInputPassword1">
                                <small id="emailHelp1" class="form-text text-muted">Input your old password</small>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword2">New Password</label>
                                <input type="password" class="form-control" name="new_password" id="exampleInputPassword2">
                                <small id="emailHelp2" class="form-text text-muted">Input your new password</small>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword3">Re-New Password</label>
                                <input type="password" class="form-control" name="re_new_password" id="exampleInputPassword3">
                                <small id="emailHelp3" class="form-text text-muted">Re type your new password again</small>
                            </div>
                            <button type="submit" name="action" value="update_password" class="btn btn-primary" style="background-color: midnightblue">Update Password</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-lg-3">
                <div class="card bg-light mb-5" style="max-width: 18rem;">
                    <div class="card-header" style="background-color: darkcyan;  color: white">Latest birthdays</div>
                    <div class="card-body">
                        <h5 class="card-title">Light card title</h5>
                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                    </div>
                </div>
                <div class="card bg-light mb-5" style="max-width: 18rem;">
                    <div class="card-header" style="background-color: darkcyan; color: white">My Games</div>
                    <div class="card-body">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link" href="#" style="color: midnightblue">FOOTBALL ONLINE</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" style="color: midnightblue">ING PONG ONLINE</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" style="color: midnightblue">CHESS MASTERS</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" style="color: midnightblue">RACES ONLINE</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%
        }
    %>

</body>
</html>
