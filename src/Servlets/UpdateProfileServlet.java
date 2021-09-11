package Servlets;

import Classes.DBManager;
import Classes.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/updateprofile")
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("CURRENT_USER");
        String action = request.getParameter("action");

        if(action.equals("update_profile")){
            String email = user.getEmail();
            String full_name = request.getParameter("full_name");
            String birthdate = request.getParameter("birthdate");
            User newUser = new User(null, email, null, full_name, birthdate, null);
            if(DBManager.updateProfile(newUser)){
                User newCurrentUser = DBManager.getUser(user.getId());
                request.getSession().setAttribute("CURRENT_USER", newCurrentUser);
                response.sendRedirect("/home");
            }else{
                response.sendRedirect("/wrong.jsp");
            }
        }else if(action.equals("update_url")){
            String picture_url = request.getParameter("picture_url");
            if(DBManager.updatePictureUrl(user.getId(), picture_url)){
                User newCurrentUser = DBManager.getUser(user.getId());
                request.getSession().setAttribute("CURRENT_USER", newCurrentUser);
                response.sendRedirect("/home");
            }else{
                response.sendRedirect("/wrong.jsp");
            }
        }else if(action.equals("update_password")){
            String oldPass = request.getParameter("old_password");
            String new_password = request.getParameter("new_password");
            String re_new_password = request.getParameter("re_new_password");
            if(oldPass.equals(user.getPassword())){
                if(new_password.equals(re_new_password)){
                    if(DBManager.updatePassword(user.getId(), new_password)){
                        User newCurrentUser = DBManager.getUser(user.getId());
                        request.getSession().setAttribute("CURRENT_USER", newCurrentUser);
                        response.sendRedirect("/home");
                    }else{
                        response.sendRedirect("/wrong.jsp");
                    }
                }else{
                    response.sendRedirect("/wrong.jsp");
                }
            }else{
                response.sendRedirect("/wrong.jsp");
            }
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
