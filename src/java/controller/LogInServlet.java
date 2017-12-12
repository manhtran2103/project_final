/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;
import tools.MD5;

/**
 *
 * @author manhtran
 */
public class LogInServlet extends HttpServlet {

    UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       PrintWriter out = response.getWriter();
       String user_name = request.getParameter("user_name");
       String user_password = request.getParameter("user_password");
       String url = "";
       User user = userDAO.getUserFromUsersByName_Password(user_name, MD5.encryption(user_password));
       HttpSession session = request.getSession();
       session.removeAttribute("error");
       if(user != null){
           //session.setAttribute("user", user);
           Cookie loginID = new Cookie("user_id", user.getUser_id() + "");
           Cookie loginName = new Cookie("user_name", user.getUser_name());
           loginID.setMaxAge(60*60*24*365);
           loginName.setMaxAge(60*60*24*365);
           response.addCookie(loginID);
           response.addCookie(loginName);
         
           url = "/project/index.jsp";
           response.sendRedirect(url);
       } else{
//           String error = "User name or password invalid\nPlease try again";
//           request.setAttribute("error", error);
           url = "/project/login.jsp";
           session.setAttribute("error", "user or password not valid");
           response.sendRedirect(url);

       }
//        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
//        rd.forward(request, response);
        // can not use sendRedirect in this case
    }

   
}
