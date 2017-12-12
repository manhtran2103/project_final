<%-- 
    Document   : home
    Created on : Dec 8, 2017, 5:44:49 PM
    Author     : manhtran
--%>

<%@page import="model.User"%>
<%@page import="dao.ProfileDAO"%>
<%@page import="dao.FollowerDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Media"%>
<%@page import="dao.UserDAO"%>
<%@page import="dao.MediaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Home</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Lato:100,300,300i,400,400i" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/home.css">
    </head>
    <body>
      
           <%
               MediaDAO mediaDAO = new MediaDAO();
               UserDAO userDAO = new UserDAO();
               FollowerDAO followerDAO = new FollowerDAO();
               ProfileDAO profileDAO = new ProfileDAO();
               long user_id = Long.parseLong(request.getParameter("id"));
               String user_name = userDAO.getUserFromUsers(user_id).getUser_name();
               int number_posts = mediaDAO.getNumberOfMedia(user_id);
               ArrayList<Media> listMedia = mediaDAO.getListMediaByUser(user_id);
               //get cookies
               String user_name_visitor = "";
               long user_id_visitor = 0;
               Cookie[] cookies = request.getCookies();
                if(cookies !=null){
                    for(Cookie cookie : cookies){
                            if(cookie.getName().equals("user_name")){
                                user_name_visitor = cookie.getValue();
                            } 
                            if(cookie.getName().equals("user_id")){
                                user_id_visitor = Long.parseLong(cookie.getValue());
                            }
                    }
                }
                //-----
                String display = "none";
                if (user_id == user_id_visitor) {
                        display = "block";
                    }
//                String src = "img/user.png";
//                if(profileDAO.checkProfile(user_id)){
//                    src = profileDAO.getProfile(user_id).getAvatar();
//                }
                 ArrayList<User> listFollowing = followerDAO.getListFollowing(user_id);
                 ArrayList<User> listFollowers = followerDAO.getListFollowers(user_id);
                 
               
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
                       if(user_id_visitor != 0){
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
                           <li><a class="color" href="home.jsp?id=<%=user_id_visitor %>" >Home</a></li>
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
        
        <!---->
        
        <div id="user-information">
            <div id="avatar">
                <div id="img">
                    <img id="img-avatar" src=<%=profileDAO.getProfile(user_id).getAvatar() %> width="120px" height="120px">
                </div>
                <div id="user">
                 <span id="user-name"><%=user_name %></span>
                 <br>
                 <a href="profile.jsp" style="display: <%=display %>">Edit profile</a>
                </div>
            </div>
            <div id="information">
            <div>Posts <span id="post"><%=number_posts %></span></div>
            <div id="a">Following <span id="following"><%=followerDAO.getNumberFollowing(user_id) %></span>
             <div id="listfollowing">
                <% 
                    for(User user : listFollowing){
                %>
                <a href="home.jsp?id=<%=user.getUser_id()%>" ><%=user.getUser_name() %></a>
                <%}%>
             </div>
            </div>
           
            <div id="b">Followers <span id="followers"><%=followerDAO.getNumberFollowers(user_id) %></span>
                <div id="listfollowers">
                <% 
                    for(User user : listFollowers){
                %>
                <a href="home.jsp?id=<%=user.getUser_id() %>" ><%=user.getUser_name() %></a>
                <%}%>
                </div>
            </div>
            <div style="display: <%=display %>">Groups</div>
            <div style="display: <%=display %>">Apps</div>
            <div style="display: <%=display %>">Others</div>
            </div>
        </div>
        <div id="user-post">
            <%
                if(user_id_visitor != 0){
                for(int i = listMedia.size() - 1; i >=0; i--){    
                
            %>
            <div>
                <img id="<%=i %>" src=<%=listMedia.get(i).getMedia_url() %> class="post" >
             <div>
                 <p><img src ="img/like_home.png" width="25px" height="23px">&nbsp;&nbsp;&nbsp;;&nbsp;
                     <span style="color: white"><%=listMedia.get(i).getMedia_like() %></span></p>
            </div>
            </div>
            <script>
                $('#<%=i %>').click(()=>{
                    window.location = "view.jsp?id=<%= listMedia.get(i).getMedia_id() %>";
                });
            </script>
            <% }} %>
        </div>
        
    </body>
</html>
