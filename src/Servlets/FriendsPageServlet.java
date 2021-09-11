package Servlets;

import Classes.DBManager;
import Classes.FriendsRequest;
import Classes.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(value = "/friendspage")
public class FriendsPageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("btn_action") != null) {
            String btn_action = request.getParameter("btn_action");
            if (btn_action.equals("perform")) {
                Long fr_id = Long.parseLong(request.getParameter("friendrequest_id"));
                FriendsRequest friendsRequest = DBManager.getFriendRequest(fr_id);
                if (DBManager.deleteFriendRequest(fr_id)) {
                    if (DBManager.addFriend(friendsRequest.getUser().getId(), friendsRequest.getSender().getId())) {
                        response.sendRedirect("/friendspage");
                    }
                }
            } else if (btn_action.equals("reject")) {
                Long fr_id = Long.parseLong(request.getParameter("friendrequest_id"));
                FriendsRequest friendsRequest = DBManager.getFriendRequest(fr_id);
                if (DBManager.deleteFriendRequest(fr_id)) {
                    response.sendRedirect("/friendspage");
                }
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("btn_action") != null){
         String btn_action = request.getParameter("btn_action");
            if(btn_action.equals("search")){
                String search_value = request.getParameter("search_value");
                search_value += "%";
                ArrayList<User> users  = DBManager.getSearchingUsers(search_value);
                request.setAttribute("search_result", users);
            }
        }
        request.getRequestDispatcher("/friendsPage.jsp").forward(request, response);
    }
}
