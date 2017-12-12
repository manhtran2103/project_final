
<%-- 
    Document   : newjsp
    Created on : Nov 13, 2017, 9:28:44 PM
    Author     : manhtran
--%>

<%@page import="dao.LikeDAO"%>
<%@page import="dao.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Media"%>
<%@page import="dao.MediaDAO"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <meta name="viewport" content="width = device-width, initial-scale=1.0, user-scalable=yes">
        
       <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Lato:100,300,300i,400,400i" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        
        <link rel="stylesheet" href="css/main.css">
      
    </head>
    <body>
        <%
            String user_name = "";
            long user_id = 0;
            //get cookies
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
            String statusUser = "Log In";
            String visibility = "visible";
            String urlLogOut_In = "login.jsp";           
            String upload="login.jsp";
            String display_home_account = "none";
            String display_login_register = "block";
            if(user_name !=""){
                upload = "upload.jsp";
                display_home_account = "block";
                display_login_register = "none";
            }
            MediaDAO mediaDAO = new MediaDAO();
            UserDAO userDAO = new UserDAO();
            ArrayList<Media> listMedia = mediaDAO.getListMedia();
            LikeDAO likeDAO = new LikeDAO();
        %>
           <nav role="navigation" class="navbar navbar-inverse navbar-fixed-top">
               <div class="container-fluid">
                   <div class="navbar-header">
                       <a class="navbar-brand color" href="#" style="margin-left: 50px; font-size: 150%;"> Media</a>
                       <button type="button" class="navbar-toggle" data-target="#navbarCollapse" data-toggle="collapse">
                           <span class="sr-only">Menu</span>
                           <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                       </button>
                   </div>
                   <div class="navbar-collapse collapse" id="navbarCollapse">
                       <ul class="nav navbar-nav">                          
                            <li><a class="color" href=<%=upload %>> Upload</a></li>
                       </ul>
                       <form class="navbar-form navbar-left" role="search">
                       <div class="input-group">
                           <label class="sr-only">Search</label>
                           <input type="text" id="search" class="form-control" placeholder="Photos, videos & groups" size="50"><span class="glyphicon glyphicon-search form-control-feedback"></span>
                       </div>
                        </form>
                       <form class="nav navbar-nav navbar-right" style="display:<%= display_home_account %>">                          
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
                               <form class="navbar-form navbar-right" style="display:<%= display_login_register %>">
                                   <a class="color" href="#">Help</a>
                                   <a type="button" class="btn btn-primary" style="margin-left:20px;" href="login.jsp">Log In</a></li>
                                   <a tyep="button" class="btn btn-primary" style="margin-left: 7px;" href="register.jsp">Sign Up</a>
                               </form>                
                   </div>
               </div>
            </nav>
        
<!--        content-->
         <div id="myModal">
                    <span id="close">&times;</span>
                    <img id="img01">
         </div>  
        <div id="media">
           
                <% if(listMedia != null){
                for(int i = listMedia.size() -1; i >= 0; i--){               
                %>
                <div>                   
                    <img src=<%=listMedia.get(i).getMedia_url() %> alt="image" class="image" id=<%= i + "img"%> >
                    <div>
                        <p><span style="font-style: italic; color: white">by</span>&nbsp;&nbsp;<span style="font-weight: bold; font-size: 15px; color: white;"><%=userDAO.getUserFromUsers(listMedia.get(i).getUser_id()).getUser_name() %></span>&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="#" id="<%= i + "a" %>"><img src ="img/like_home.png" width="25px" height="23px"></a>&nbsp;&nbsp;&nbsp;<span style="color: white"><%=listMedia.get(i).getMedia_like() %></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="#" id="<%= i %>"><img src="img/comments_home.png" width="28px" height="23px"></a></p>
                    </div>
                         

                     <script>
                               
                                  "use strict";
                                    document.querySelector("[id='<%= i + "a" %>']").addEventListener("click", ()=>{
                                        if(<%=user_id %> === 0){
                                                alert("Please login to continue");
                                            } else{
                                                window.location = "view.jsp?id=<%= listMedia.get(i).getMedia_id() %>";
                                             }            
                                    });
                                    document.querySelector("[id='<%= i %>']").addEventListener("click", ()=>{
                                        if(<%=user_id %> === 0){
                                                alert("Please login to continue");
                                            } else{
                                                window.location = "view.jsp?id=<%= listMedia.get(i).getMedia_id() %>";
                                             }            
                                    });
                       
                            </script>
                </div>
                <% }}%>
        
        </div>
          <script src="js/main.js"></script>
        <!--footer-->
     
        <footer class="footer">
            <div class="container">
            <small>
                Media App by NoName Team
            </small>
            <nav>
                <ul>
                    <li><a href="#">About</a></li>
                    <li><a href="#">Contact</a></li>
                    <li><a href="#">News</a></li>
                </ul>
            </nav>
            </div>
        </footer>
        
    </body>
</html>
