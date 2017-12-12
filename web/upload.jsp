<%-- 
    Document   : upload
    Created on : Nov 14, 2017, 8:16:49 PM
    Author     : manhtran
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Upload</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Lato:100,300,300i,400,400i" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/upload.css">
    </head>
    <body>
        <!--navbar-->
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
                   <div class="navbar-collapse collapse" id="navbarCollapse">
                   <form class="nav navbar-nav navbar-right">
                       <li><a>Help</a></li>
                       <li><a>About</a></li>
                   </form>
               </div>
               </div>
        </nav>
        <!--content-->
      
        <div id="content" >
        <form method="post" action="UploadServlet" enctype="multipart/form-data">
            
            <label id="label">Choose your images to upload</label>
            <input id="input" type="file" name="uploadFile" accept=".png, .jpg, .jpeg" />
            <br/>
            <input id="upload" type="submit" value="Upload" class="btn" />
           
        </form>
        </div>
      
    </body>
</html>
