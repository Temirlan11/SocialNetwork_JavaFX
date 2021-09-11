package Servlets;

import Classes.DBManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/addfriend")
public class AddFriendServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String btn_action = request.getParameter("btn_action");
        if(btn_action.equals("addtofriend")){
            Long senderId = Long.parseLong(request.getParameter("request_sender_id"));
            Long receiverId = Long.parseLong(request.getParameter("request_receiver_id"));
            if(DBManager.sendRequest(receiverId, senderId)){
                response.sendRedirect("/friendspage");
            }else{
                response.sendRedirect("wrong.jsp");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("friendsPage.jsp").forward(request, response);
    }
}
