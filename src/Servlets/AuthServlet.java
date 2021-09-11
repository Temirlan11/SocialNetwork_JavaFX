package Servlets;

import Classes.DBManager;
import Classes.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/auth")
public class AuthServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        System.out.println(email + " EMAIL");
        System.out.println(password + " PASS");
        User user = DBManager.getUser(email);

        if(user != null){
            if(user.getPassword().equals(password)){
                System.out.println("KIRDI +++");
                request.getSession().setAttribute("CURRENT_USER", user);
                response.sendRedirect("/home");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
