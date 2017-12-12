<%-- 
    Document   : people
    Created on : Dec 8, 2017, 9:40:21 PM
    Author     : manhtran
--%>

<%@page import="dao.ProfileDAO"%>
<%@page import="dao.FollowerDAO"%>
<%@page import="dao.MediaDAO"%>
<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>People</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Lato:100,300,300i,400,400i" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/people.css">
    </head>
    <body>
        <%
            UserDAO userDAO = new UserDAO();
            MediaDAO mediaDAO = new MediaDAO();
            FollowerDAO followerDAO = new FollowerDAO();
            ProfileDAO profileDAO = new ProfileDAO();
            ArrayList<User> listUser = userDAO.getListUsers();
            //get cookies
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
                //-----
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
        
        <!---->
        <h3 style="text-align:center; color: #1fa1e2;">
            Media members</h3>
        <div id="content">
            
            <%  
                for(int i = 0; i < listUser.size(); i++){
                    User user = listUser.get(i);
                    if(user.getUser_id() == user_id){continue;}
            %>
            <div class="people">
                <div class="avatar"><img src=<%=profileDAO.getProfile(user.getUser_id()).getAvatar() %> width="60px" height="60px"></div>
                <div class="info">
                    <p class="user-name"><a href="home.jsp?id=<%=user.getUser_id() %>"><%=user.getUser_name() %></a></p>
                    <p><img src="img/image.png" width="20px" height="15px">&nbsp;&nbsp;
                        <span class="posts"><%=mediaDAO.getNumberOfMedia(user.getUser_id()) %></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <img src="img/followers.png" width="20px" height="15px">&nbsp;&nbsp;
                        <span class="follower" id="<%=i+"a" %>"><%=followerDAO.getNumberFollowers(user.getUser_id()) %></span></p>
                </div>
                <div class="follow">
                    <div class="btn" id="<%=i %>"><span>+</span> Follow</div>
                </div>
            </div>
                <script>
                  
                    if(<%=followerDAO.checkFollower(user.getUser_id(), user_id) %>){
                        $('#<%=i %>').html("Followed");
                        $('#<%=i %>').css({"background-color":"#c9cbcc", "color":"black"});
                    }
                   
                    $('#<%=i %>').click(() => {
                       
                        if(<%=user_id == 0 %>){
                            alert("Please login to continue");
                        } else{
                           
                            $.post('/project/page/view/follow',{user_id: <%=user.getUser_id() %>, follower_id: <%=user_id %>},
                            (data) => {
                               $('#<%=i+"a" %>').html(data.followers);
                               $('#<%=i %>').html(data.html);
                               $('#<%=i %>').css({"background-color":data.background, "color":data.color});
                            });
                       }
                    });
                </script>
            <% } %>
        </div>
    </body>
</html>
