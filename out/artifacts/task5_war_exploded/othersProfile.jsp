<%@ page import="Classes.DBManager" %>
<%@ page import="Classes.Post" %>
<%@ page import="java.util.ArrayList" %><%--
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
    Long id = (Long) request.getAttribute("user_id");
    User current_user = (User) request.getSession().getAttribute("CURRENT_USER");
    if(id != null){
        User user = DBManager.getUser(id);
%>
<div class="container">
    <div class="row mt-5">
        <div class="col-lg-3">
            <div class="card" style="width: 16rem;">
                <img src="<%=user.getPicture_url()%>" class="card-img-top" alt="...">
                <div class="card-body">
                    <ul class="list-group">
                        <li class="list-group-item"><%=user.getFull_name()%></li>
                        <%
                            if(DBManager.getFriendstoDelete(current_user.getId(), user) != null){
                                System.out.println(DBManager.getFriendstoDelete(current_user.getId(), user).getId() + " chbd");
                        %>
                        <li class="list-group-item"><a href="#" data-toggle="modal" data-target="#delete_modal">Remove From Friends</a></li>
                        <%
                            }else if(DBManager.getFriendstoDelete(user.getId(), current_user) != null){
                        %>
                        <li class="list-group-item"><a href="#" data-toggle="modal" data-target="#delete_modal">Remove From Friends</a></li>
                        <%
                            }else{
                        %>
                        <li class="list-group-item"><a href="#" data-toggle="modal" data-target="#delete_modal">Remove From Friends</a></li>
                        <%
                            }
                        %>
                        <li class="list-group-item"><a href="#">Send Message</a></li>
                        <li class="list-group-item"><a href="#" style="color: crimson">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="column">
                <div class="container mb-4">
                    <button type="submit" class="btn btn-secondary" name="btn_action" value="add" data-toggle="modal" data-target="#add_modal"   style="background-color: midnightblue">+ Add New</button>
                </div>
                <%
                    ArrayList<Post> posts = DBManager.getPosts(user.getId());
                    for(Post post : posts){
                %>
                <div class="card mb-4">
                    <div class="card">
                        <div class="card-body">
                            <blockquote class="blockquote mb-0">
                                <h5><%=post.getTitle()%></h5>
                                <h6><p><%=post.getShortContent()%></p></h6>>
                                <form action="/othersdetails?user_id=<%=user.getId()%>&moredetails_id=<%=post.getId()%>" method="get">
                                    <button type="submit" name="btn_action" class="btn btn-outline-primary mt-3" value="more">More</button>
                                </form>
                                <%--                                    <a class="btn btn-primary btn-sm" href="/editstudent?id=<%=post.getId()%>" role="button" style="background-color: darkmagenta">EDIT</a>--%>
                            </blockquote>
                        </div>
                        <div class="card-footer">
                            Posted on <%=post.getPostDate()%> by <a href="/profilepage"><%=post.getAuthor().getFull_name()%></a>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
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

<form action="/addPost" method="post">
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
                        <input type="text" class="form-control" id="formGroupExampleInput" name="title" placeholder="Name of publication">
                    </div>
                    <div class="form-group">
                        <label for="textar1">SHORT CONTENT: </label>
                        <textarea class="form-control" id="textar1" name="short_content" rows="3" placeholder="Description..."></textarea>
                    </div>
                    <div class="form-group">
                        <label for="textar2">CONTENT: </label>
                        <textarea class="form-control" id="textar2" name="content" rows="3" placeholder="Description..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-secondary" name="btn_action" value="add" style="background-color: midnightblue">Add</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" style="background-color: crimson">Close</button>
                </div>
            </div>
        </div>
    </div>
</form>

<form action="/othersprofile?delete_id=<%=user.getId()%>" method="post">
    <div class="modal fade" id="delete_modal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Delete <%=user.getFull_name()%></h4>
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
                    <button type="submit" class="btn btn-secondary" name="btn_action" value="delete_friend" style="background-color: midnightblue">Yes</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" style="background-color: crimson">No</button>
                </div>
            </div>
        </div>
    </div>
</form>

<%
    }
    }
%>

</body>
</html>
