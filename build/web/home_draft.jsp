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
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Lato:100,300,300i,400,400i" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
       <script src="js/main.js"></script>
      
    </head>
    <body>
        <%
            //User user = (User) session.getAttribute("user");
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
            String statusUser = "Log In";
            String visibility = "visible";
            String urlLogOut_In = "login.jsp";
            String image = (String) session.getAttribute("image");
            String upload="login.jsp";
           
            if(user_name !=""){
                upload = "upload.jsp";
                
            }
            MediaDAO mediaDAO = new MediaDAO();
            UserDAO userDAO = new UserDAO();
            ArrayList<Media> listMedia = mediaDAO.getListMedias();
            LikeDAO likeDAO = new LikeDAO();
        %>
           <nav role="navigation" class="navbar navbar-inverse navbar-fixed-top">
               <div class="container-fluid">
                   <div class="navbar-header">
                       <a class="navbar-brand color" href="#" style="margin-left: 50px; font-size: 150%;"> Flickr</a>
                       <button type="button" class="navbar-toggle" data-target="#navbarCollapse" data-toggle="collapse">
                           <span class="sr-only">Menu</span>
                           <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                       </button>
                   </div>
                   <div class="navbar-collapse collapse" id="navbarCollapse">
                       <ul class="nav navbar-nav">
<!--                           <li><a href="#"><span class="glyphicon glyphicon-picture"></span> Photos <span class="badge">0</span></a></li>
                           <li><a href="#"><span class="glyphicon glyphicon-facetime-video"></span> Videos <span class="badge">0</span></a></li>-->
                            <li><a class="color" href=<%=upload %>> Upload</a></li>
<!--                           <li><a href="#">Categories <span class="caret"></span></a></li>-->
                       </ul>
                       <form class="navbar-form navbar-left" role="search">
                       <div class="input-group">
<!--                           <span class="input-group-btn">
                               <button class="btn btn-info">Go</button>
                           </span>-->
                           <label class="sr-only">Search</label>
                           <input type="text" id="search" class="form-control" placeholder="Photos, videos & group" size="50"><span class="glyphicon glyphicon-search form-control-feedback"></span>
                       </div>
                   </form>
                       <form class="nav navbar-nav navbar-right">
                           
                           <%  if(user_name !=""){ 
                               statusUser = "Log Out";
                               visibility = "hidden";
                               urlLogOut_In = "/project/LogOutServlet";
                           }
                           %>
                           <li><a class="color" href="#">Home</a></li>
                           <li><a class="color" href="#">Help</a></li>
                           <li><a class="color" href="#">Users</a></li>
                           <li class="dropdown">
                               <a href="#" class="dropdown-toggle color" data-toggle="dropdown">
                                   Account<b class="caret"></b>
                               </a>
                               <ul class="dropdown-menu">
                                   <li><a href="#">Profile</a></li>
                                   <li><a href="#">Setting</a></li>
                                   <li class="divider">
                                   <li>
                                       <a href="#">Log out</a>
                                   </li>
                               </ul>
                           </li>
                          
                           
<!--                           <a class="btn btn-primary" type="button" href=<</a>
                          
                           <a class="btn btn-primary" type="button" href="register.jsp" style="visibility:">Sign Up</a>-->
                       </form>
                       
                   </div>
               </div>
            </nav>
        
<!--        content-->
        
        <div class="container-fluid" style="margin-top: 100px; margin-left: 150px; margin-right: 150px;">
            <div class="row1">
                <% if(listMedia != null){ %>
                <% for(int i = listMedia.size() -1; i >= 0; i--){ 
                    //String btnLike_id = i +"a";
                    String quantity_like = i +"b";
                    String like_img = i + "c";
                    String btnState;
                    if(user_name == ""){
                        btnState = "img/like3.png";
                    } else{
                        if(likeDAO.checkLikeUser(user_id, listMedia.get(i).getMedia_id())){
                            btnState = "img/like.png";
                        } else{
                            btnState = "img/unlike.png";
                        }
                    }
                %>
                <div id="ok" style=" min-width: 0; margin: 2px; flex-basis: auto;" >
                   
                        <a href="#">
                            <img src=<%=listMedia.get(i).getMedia_url() %> alt="image" style="display:inline;" class="img-responsive">
                    </a>
                    <div class="caption" >
                        
                        <p><span style="font-style: italic;">by</span>&nbsp;&nbsp;<span style="font-weight: bold; font-size: 15px;"><%=userDAO.getUserFromUsers(listMedia.get(i).getUser_id()).getUser_name() %></span></p>
                        <p style="float: right;">
                        <img src="img/view.png" width="35" height="25"> &nbsp;<span id="view">0</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <img id=<%=like_img %> src = <%=btnState %> width="35" height="30">&nbsp;&nbsp;&nbsp;<span id=<%=quantity_like %>><%=listMedia.get(i).getMedia_like() %></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                             <script>
                                $(document).ready(()=>{
                                  
                                    $('#<%=like_img %>').click(() => {
                                            if(<%=user_id %> == 0){
                                                alert("Please login to continue");
                                            } else{
                                             var media_id = <%=listMedia.get(i).getMedia_id() %>;
                                            $.ajax({
                                                type: 'POST',
                                                data: {media_id: media_id, user_id: <%= user_id %>},
                                                url: 'LikeServlet',
                                                success: (data)=>{
                                                $('#<%=like_img %>').attr("src", data.btnLike);
                                                $('#<%=quantity_like %>').text(data.quantity);
                                                
                                            }
                                            });}
      
                                                                                   
                                    });
                                });
                                   
                            </script>
                            <img src="img/comments.png" width="42" height="30"></p>
                        </p>
                   
                    </div>
                </div>
                <% } }%>
                
      
            </div>
            
        </div>
        
        <div>
            
        </div>
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




