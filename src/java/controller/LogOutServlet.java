/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author manhtran
 */
public class LogOutServlet extends HttpServlet {

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("user");
        Cookie[] cookies = request.getCookies();
        if(cookies !=null){
           for(Cookie cookie : cookies){
               if(cookie.getName().equals("user_name")){
                   cookie.setValue("");
                   cookie.setMaxAge(0);
                   response.addCookie(cookie);
               }
               else if(cookie.getName().equals("user_id")){
                   cookie.setValue("");
                   cookie.setMaxAge(0);
                   response.addCookie(cookie);
               }
           } 
        }
        
        response.sendRedirect("/project/index.jsp");
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

}
