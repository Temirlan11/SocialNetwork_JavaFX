<%@include file="user.jsp"%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="background-color: midnightblue">
    <a class="navbar-brand" href="/home">Aralasu.kz</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav">
            <%
                if(online){
            %>
            <li class="nav-item">
                <a class="nav-link" href="/profile"><%=currentUser.getFull_name()%></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/friendspage">My Friends</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Groups</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">My posts</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Messages</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Pictures</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Videos</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/logout">Log out</a>
            </li>
            <%
                }else{
            %>
            <li class="nav-item">
                <a class="nav-link" href="/home">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/signin">Sign in</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/registration">Registration</a>
            </li>
            <%
                }
            %>
        </ul>
    </div>
</nav>