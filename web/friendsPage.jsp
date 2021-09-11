<%@ page import="Classes.Friends" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Classes.DBManager" %>
<%@ page import="Classes.FriendsRequest" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 14.10.2020
  Time: 20:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Friends</title>
    <%@include file="vendor/head.jsp"%>
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
                    <div class="card mb-3" style="max-width: 540px; height: 75px">
                        <form class="form-inline" action="/friendspage" method="get">
                            <div class="form-group mx-sm-3 mb-2">
                                <label for="inputPassword2" class="sr-only">Password</label>
                                <input type="text" class="form-control mt-3" id="inputPassword2" name="search_value" placeholder="Search Friends" style="width: 400px">
                            </div>
                            <button type="submit" class="btn btn-outline-info mt-3 mb-2"  name="btn_action" value="search" style="margin-left: 19px">Search</button>
                        </form>
                    </div>
                    <%
//                        String other_users = "other";
                        if(request.getAttribute("search_result") != null){
                            ArrayList<User> results = (ArrayList<User>) request.getAttribute("search_result");
                            ArrayList<Friends> friendsList = DBManager.getAllFriends();
                            for(User u : results){
                                String other_users = "other";
                                for (Friends friends : friendsList){
                                    if(friends.getUser().getId()== u.getId() || friends.getFriend().getId() == u.getId()){
                                        if(friends.getFriend().getId() == user.getId() || friends.getUser().getId() == user.getId()){
                                            other_users = "friends";
                                        }
                                    }
                                }
                                if(other_users.equals("other")){
                                    System.out.println("+_+_+_+_+_+_+_+_+");
                    %>
                            <form action="/addfriend?request_receiver_id=<%=u.getId()%>&request_sender_id=<%=user.getId()%>" method="post">
                                <div class="card mb-3" style="max-width: 540px;">
                                    <div class="row no-gutters">
                                        <div class="col-md-4">
                                            <img src="<%=u.getPicture_url()%>" class="card-img mt-3" alt="..." style="border-radius: 50%; width: 125px; height: 125px">
                                        </div>
                                        <div class="col-md-8">
                                            <div class="card-body">
                                                <a href="/othersprofile?profile_id=<%=u.getId()%>" style="color: black"><h5 class="card-title"><%=u.getFull_name()%></h5></a>
                                                <p class="card-text"><%=u.getBirth_date()%></p>
                                                <%
                                                    String requestsent = request.getParameter("requestsent");
                                                    if(DBManager.checkRequestStatus(u, user) != null){
                                                %>
                                                    <button type="submit" class="btn btn-outline-info" name="btn_action" value="#">Request Sent</button>
                                                <%
                                                    }else {
                                                %>
                                                     <button type="submit" class="btn btn-outline-info" name="btn_action" value="addtofriend">Add to Friends</button>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                    <%
                                }
                            }
                        }else{
                            if(DBManager.checkRequestStatus(user) != null){
                                ArrayList<Classes.FriendsRequest> friendsRequests = DBManager.checkRequestStatus(user);
                    %>
                        <div class="card mb-3" style="max-width: 540px;">
                            <div class="card-header">
                                You have <%=friendsRequests.size()%> new requests
                            </div>
                    <%
                                for(FriendsRequest friendsRequest : friendsRequests){
                    %>
                            <form action="/friendspage?friendrequest_id=<%=friendsRequest.getId()%>" method="post">
                                <div class="row no-gutters">
                                    <div class="col-md-4">
                                        <img src="<%=friendsRequest.getSender().getPicture_url()%>" class="card-img mt-3" alt="..." style="border-radius: 50%; width: 125px; height: 125px">
                                    </div>
                                    <div class="col-md-8">
                                        <div class="card-body">
<%--                                            <h5 class="card-title"><%=friendsRequest.getSender().getFull_name()%></h5>--%>
                                            <a href="/othersprofile?profile_id=<%=friendsRequest.getSender()%>" style="color: black"><h5 class="card-title"><%=friendsRequest.getSender().getFull_name()%></h5></a>
                                            <p class="card-text"><%=friendsRequest.getSender().getBirth_date()%></p>
                                            <button type="submit" name="btn_action" value="perform" class="btn btn-outline-info">Perform</button>
                                            <button type="submit" name="btn_action" value="reject" class="btn btn-outline-info">Reject</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                    <%
                                }
                    %>
                        </div>
                    <%
                            }
                            ArrayList<Friends> friendsList = DBManager.getAllFriends();
                            for(Friends friends: friendsList){
                                if(friends.getUser().getId() == user.getId()){
                    %>
                            <div class="card mb-3" style="max-width: 540px;">
                                <div class="row no-gutters">
                                    <div class="col-md-4">
                                        <img src="<%=friends.getFriend().getPicture_url()%>" class="card-img mt-3" alt="..." style="border-radius: 50%; width: 125px; height: 125px">
                                    </div>
                                    <div class="col-md-8">
                                        <div class="card-body">
                                            <a href="/othersprofile?profile_id=<%=friends.getFriend().getId()%>" style="color: black"><h5 class="card-title"><%=friends.getFriend().getFull_name()%></h5></a>
<%--                                            <h5 class="card-title"><%=friends.getFriend().getFull_name()%></h5>--%>
                                            <p class="card-text"><%=friends.getFriend().getBirth_date()%></p>
                                            <button type="button" class="btn btn-outline-info">Send message</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    <%
                                }else if(friends.getFriend().getId() == user.getId()){
                    %>
                            <div class="card mb-3" style="max-width: 540px;">
                                <div class="row no-gutters">
                                    <div class="col-md-4">
                                        <img src="<%=friends.getUser().getPicture_url()%>" class="card-img mt-3" alt="..." style="border-radius: 50%; width: 125px; height: 125px">
                                    </div>
                                    <div class="col-md-8">
                                        <div class="card-body">
                                            <a href="/othersprofile?profile_id=<%=friends.getUser().getId()%>" style="color: black"><h5 class="card-title"><%=friends.getUser().getFull_name()%></h5></a>
<%--                                            <h5 class="card-title"><%=friends.getUser().getFull_name()%></h5>--%>
                                            <p class="card-text"><%=friends.getUser().getBirth_date()%></p>
                                            <button type="button" class="btn btn-outline-info">Send message</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    <%
                                }
                            }
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
    <%
        }
    %>
</body>
</html>
