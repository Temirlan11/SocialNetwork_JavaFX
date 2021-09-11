package Servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/othersdetails")
public class OthersMoreDetailsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String btn_action = request.getParameter("more");
        if(btn_action.equals("more")){
            Long postId = Long.parseLong(request.getParameter("moredetails_id"));
            Long user_id = Long.parseLong(request.getParameter("user_id"));
            request.setAttribute("postId", postId);
            request.setAttribute("user_id", user_id);
        }
        request.getRequestDispatcher("/othersMoreDetails.jsp").forward(request, response);
    }
}
