<%@ page import="Classes.Post" %>
<%@ page import="Classes.DBManager" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 13.10.2020
  Time: 18:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>More Details</title
    <%@include file="vendor/head.jsp"%>

    <script src="tinymce\tinymce.min.js" referrerpolicy="origin"></script>
    <script>
        tinymce.init({
            selector: 'textarea',
        });
    </script>
</head>
<body>
<%@include file="vendor/navbar.jsp"%>
<%
    //        response.setIntHeader("Refresh", 1);
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
                        <li class="list-group-item"><a href="/profilepage">My Profile</a></li>
                        <li class="list-group-item"><a href="#">Settings</a></li>
                        <li class="list-group-item"><a href="#" style="color: crimson">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="column">
                <%
                    Long postId = (Long) request.getAttribute("postId");
                    Post post = DBManager.getPost(postId);
                %>
                <div class="jumbotron">
                    <h3 class="display-4"><%=post.getTitle()%></h3>
                    <p class="lead"><%=post.getShortContent()%></p>
                    <hr class="my-4">
                    <p><%=post.getContent()%></p>
                    <a class="btn btn-primary btn-lg" href="/home" role="button">Back</a>
                    <a class="btn btn-primary btn-lg" href="/home" role="button" style="background-color: green" data-toggle="modal" data-target="#add_modal">Edit</a>
                    <a class="btn btn-primary btn-lg" href="/home" role="button" style="background-color: crimson" data-toggle="modal" data-target="#delete_modal">Delete</a>
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

<form action="/addPost?update_id=<%=post.getId()%>" method="post">
    <div class="modal fade" id="add_modal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Add New Post</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="formGroupExampleInput">TITLE:</label>
                        <input type="text" class="form-control" id="formGroupExampleInput" name="new_title" value="<%=post.getTitle()%>">
                    </div>
                    <div class="form-group">
                        <label for="textar1">SHORT CONTENT: </label>
                        <textarea class="form-control" id="textar1" name="new_short_content" rows="3" value="<%=post.getShortContent()%>"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="textar2">CONTENT: </label>
                        <textarea class="form-control" id="textar2" name="new_content" rows="3" value="<%=post.getContent()%>"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-secondary" name="btn_action" value="update" style="background-color: midnightblue">Update</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" style="background-color: crimson">Close</button>
                </div>
            </div>
        </div>
    </div>
</form>

<form action="/addPost?delete_id=<%=post.getId()%>" method="post">
    <div class="modal fade" id="delete_modal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Delete Post</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <h2>You really want to delete?</h2>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-secondary" name="btn_action" value="delete" style="background-color: midnightblue">Yes</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" style="background-color: crimson">No</button>
                </div>
            </div>
        </div>
    </div>
</form>
<%
    }
%>
</body>
</html>
