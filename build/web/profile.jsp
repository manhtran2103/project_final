<%-- 
    Document   : profile
    Created on : Dec 9, 2017, 10:05:26 AM
    Author     : manhtran
--%>

<%@page import="model.Profile"%>
<%@page import="dao.ProfileDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Lato:100,300,300i,400,400i" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/profile.css">
    </head>
    <body>
        <%
            ProfileDAO profileDAO = new ProfileDAO();
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
//               Profile profile = null;
//                String src = "";
//                String name = "";
//                String gender = "";
//                String description = "";
//                if(profileDAO.checkProfile(user_id)){
//                     profile = profileDAO.getProfile(user_id);
//                     src = profile.getAvatar();
//                     name = profile.getName();
//                     gender = profile.getGender();
//                     description = profile.getDescription();
//                }
                     Profile profile = profileDAO.getProfile(user_id);
                     String src = profile.getAvatar();
                     String name = profile.getName();
                     String gender = profile.getGender();
                     String description = profile.getDescription();
               
               
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
        <div id="content">
            <h3>Your profile</h3>
           
                <div>
                    <form id="upavatar" method="post" action="ProfileServlet" enctype="multipart/form-data">
<!--                    <input type="hidden" name="user_id" value=<%=user_id %>>-->
                        <img id="avatar" src="${image}" width="150px" height="150px" style="margin: 10px;"><br>
                        <input type="file" name="uploadFile" accept=".png, .jpg, .jpeg" ><br>
                    <input type="submit" value="Upload" />
                    </form>
                </div>
              <form id="save">
                <div>
                    <label>Publishing Name</label><br>
                    <input id="name" type="text" name="name" size="40px" >
                </div>         
                <div>
                    <p>Gender:</p>
                    <input type="radio" name="gender" value="male"><label>Male</label>
                    <input type="radio" name="gender" value="female"><label>Female</label>
                    <input type="radio" name="gender" value="none"><label>No Answer</label>
                </div>
                <div>
                    <label>Describe yourself</label><br>
                    <textarea rows="4" cols="50" id="description" name="description"></textarea>
                </div>
                <div>
                    <input class="btn" type="submit" value="Save">
                </div>
                  <p id="msg" style="color: blue"></p>
                  <a href="home.jsp?id=<%=user_id %>">Back to home page</a>
            </form>
        </div>
        <script>
            "use strict";
             let image = "${image}";
             
                if(image === ""){
                    document.getElementById("avatar").src = "<%=src %>"; 
                } else{
                    document.getElementById("avatar").src = image;
                }
                $('#name').val("<%=name %>");
                $("[name=gender]").val(["<%=gender %>"]);
                $('#description').val("<%=description %>");
            
            const save = (evt)=>{
                evt.preventDefault();
               let user_id = <%=user_id %>;
               let name = $('#name').val();
               let gender = $("input[name=gender]:checked").val();
               let description = $('#description').val();
               let avatar = document.getElementById("avatar").src;
               if(user_id !== 0){
                   $.post('/project/page/view/saveprofile',{user_id: user_id, name: name, gender: gender, description: description, avatar: avatar},(data)=>{
                       console.log(data);
                       $('#msg').html("Your data was saved");
                   });
             }};
             document.querySelector('#save').addEventListener('submit', save);
        </script>
          
    </body>
</html>
