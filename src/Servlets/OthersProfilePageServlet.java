package Servlets;

import Classes.DBManager;
import Classes.Friends;
import Classes.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/othersprofile")
public class OthersProfilePageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String btn_action = request.getParameter("btn_action");
        System.out.println(btn_action + " BTN ACTION");
        if(btn_action.equals("delete_friend")){
            Long id = Long.parseLong(request.getParameter("delete_id"));
            User curr_user = (User) request.getSession().getAttribute("CURRENT_USER");
            Friends friends = null;
            if(DBManager.getFriendstoDelete(curr_user.getId(), DBManager.getUser(id)) != null){
                friends =  DBManager.getFriendstoDelete(curr_user.getId(), DBManager.getUser(id));
            }else {
                friends =  DBManager.getFriendstoDelete2(DBManager.getUser(id), curr_user.getId());
            }
            System.out.println(friends.getId() + " ?????????");
            if(DBManager.deleteFriend(friends.getId())){
                response.sendRedirect("/friendspage");
            }else{
                response.sendRedirect("/wrong.jsp");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("profile_id"));
        request.setAttribute("user_id", id);
        request.getRequestDispatcher("/othersProfile.jsp").forward(request, response);
    }
}
