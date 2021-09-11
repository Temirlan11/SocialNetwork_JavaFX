package Servlets;

import Classes.DBManager;
import Classes.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/registration")
public class RegistrationPageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        String repass = request.getParameter("repass");
        String full_name = request.getParameter("full_name");
        String birth_date = request.getParameter("birth_date");

        String redirect = "/registration?passworderror";

        if(password.equals(repass)){
            redirect =  "/registration?emailerror";
            User user = DBManager.getUser(email);

            if(user == null){
                User newuser = new User(null, email, password, full_name, birth_date, null);

                if(DBManager.addUser(newuser)){
                    redirect = "/registration?success";
                }
            }
        }

        response.sendRedirect(redirect);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/registration.jsp").forward(request, response);
    }
}
