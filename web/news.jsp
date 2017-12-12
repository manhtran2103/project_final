<%-- 
    Document   : news
    Created on : Dec 10, 2017, 8:07:08 AM
    Author     : manhtran
--%>

<%@page import="dao.FollowerDAO"%>
<%@page import="dao.ProfileDAO"%>
<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.UserDAO"%>
<%@page import="model.Media"%>
<%@page import="dao.MediaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>News Feed</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Lato:100,300,300i,400,400i" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/news.css">
    </head>
    <body>
        <%
            MediaDAO mediaDAO = new MediaDAO();
            UserDAO userDAO = new UserDAO();
            ProfileDAO profileDAO = new ProfileDAO();
            FollowerDAO followerDAO = new FollowerDAO();
           
            String user_name = "";
               long user_id = 0;
               Cookie[] cookies = request.getCookies();
                if(cookies !=null){
                    for(Cookie cookie : cookies){
                            if(cookie.getName().equals("user_name")){
                                user_name = cookie.getValue();
                            } 
                            if(cookie.getName().equals("user_id")){
                                user_id = Long.parseLong(cookie.getValue());
                                
                            }
                    }
                }
                 ArrayList<Media> listNewsFeed = mediaDAO.getNewsFeed(user_id);
                 ArrayList<User> listUnFollow = userDAO.getSuggestedPeople(user_id);
        %>
      <nav role="navigation" class="navbar navbar-inverse navbar-fixed-top">
               <div class="container-fluid">
                   <div class="navbar-header">
                       <a class="navbar-brand" href="index.jsp" style="margin-left: 70px; color:white"> Media</a>
                       <button type="button" class="navbar-toggle" data-target="#navbarCollapse" data-toggle="collapse">
                           <span class="sr-only">Menu</span>
                           <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                       </button>
                   </div>
                   <%
                       if(user_id != 0){
                   %>
                   <div class="navbar-collapse collapse" id="navbarCollapse">
                   <ul class="nav navbar-nav">                          
                       <li><a class="color" href="upload.jsp"> Upload</a></li>
                       </ul>
                       <form class="navbar-form navbar-left" role="search">
                       <div class="input-group">
                           <label class="sr-only">Search</label>
                           <input type="text" id="search" class="form-control" placeholder="Photos, videos & groups" size="50"><span class="glyphicon glyphicon-search form-control-feedback"></span>
                       </div>
                        </form>
                       <form class="nav navbar-nav navbar-right">                          
                           <li><a class="color" href="home.jsp?id=<%=user_id %>" >Home</a></li>
                           <li><a class="color" href="people.jsp">People</a></li>
                           <li><a class="color" href="news.jsp">News Feed</a></li>
                           <li class="dropdown" >
                               <a href="#" class="dropdown-toggle color" data-toggle="dropdown" >
                                   Account<b class="caret"></b>
                               </a>
                               <ul class="dropdown-menu">
                                   <li><a href="profile.jsp">Profile</a></li>
                                   <li><a href="#">Setting</a></li>
                                   <li class="divider"></li>
                                   <li>
                                       <a href="/project/LogOutServlet">Log out</a>
                                   </li>
                               </ul>
                           </li>                                               
                       </form>
               </div>
                  <%}%>
               </div>
        </nav>
        <div id="content">
            <div id="left">
                <h3>Top images</h3>
                <% if(user_id != 0){
                    for(Media media : mediaDAO.getTopMedia()){
                %>
                <div>
                    <a href="view.jsp?id=<%=media.getMedia_id() %>"><img src=<%=media.getMedia_url() %>></a>
                    <div class="caption">
                        <p>by <span><%=userDAO.getUserFromUsers(media.getUser_id()).getUser_name() %></span></p>
                        <p>Rate <span>100</span> &nbsp;&nbsp; Like <span><%=media.getMedia_like() %></span></p>
                    </div>
                </div>
                <%}}%>
               
            </div>
            <div id="center">
                <h3 style="margin-bottom: 20px;">News Feed</h3>
                <%
                   for(Media media : listNewsFeed){ 
                %>
                <div>
                    <a href="view.jsp?id=<%=media.getMedia_id() %>"><img src=<%=media.getMedia_url() %>></a>
                    <div>
                        <p><span style="margin-right: 5px;">by</span>
                            <span><%=userDAO.getUserFromUsers(media.getUser_id()).getUser_name() %></span>
                            <img style="float:right; margin-right: 10px;"
                                src="img/comments_home.png" width="28px" height="23px">
                             <span style="margin-right: 20px; float: right; font-size: 17px;">
                                 <%=media.getMedia_like() %></span>
                            <img style="margin-right:10px; float: right;"
                                src ="img/like_home.png" width="25px" height="23px">
                           
                            
                        </p>
                    </div>
                </div>
                <% } %>
            </div>
            
          
            <div id="right">
                <h3>Suggested People</h3>
                 <%
                    if(user_id != 0){
                    for(int i = 0; i < listUnFollow.size(); i++){
                        User user = listUnFollow.get(i);
                %>
                <div class="people" id="<%=i+"p" %>">
                    <div class="avatar"><img src=<%=profileDAO.getProfile(user.getUser_id()).getAvatar() %> width="60px" height="60px"></div>
                    <div class="info">
                        <p class="user-name"><a href="home.jsp?id=<%=user.getUser_id() %>"><%=user.getUser_name() %></a></p>
                        <p><img src="img/image.png" width="20px" height="15px">&nbsp;&nbsp;
                            <span class="posts"><%=mediaDAO.getNumberOfMedia(user.getUser_id()) %></span>&nbsp;&nbsp;
                            <img src="img/followers.png" width="20px" height="15px">&nbsp;&nbsp;
                            <span class="follower"><%=followerDAO.getNumberFollowers(user.getUser_id()) %></span></p>
                    </div>
                    <div class="follow" id="<%=i %>">
                        <div class="btn"><span>+</span> Follow</div>
                    </div>
                </div>
                    <script>
                        $('#<%=i %>').click(()=>{
                             $.post('/project/page/view/follow',{user_id: <%=user.getUser_id() %>, follower_id: <%=user_id %>},
                            (data) => {
                               console.log(data);
                               $('#<%=i+"p" %>').hide();
                            });
                        });
                    </script>
                <%}}%>
            </div>
        </div>
    </body>
</html>
