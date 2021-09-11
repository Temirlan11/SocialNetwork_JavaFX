package Servlets;

import Classes.DBManager;
import Classes.Post;
import Classes.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/addPost")
public class AddPostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String short_content = request.getParameter("short_content");
        String content = request.getParameter("content");
        String btn_action = request.getParameter("btn_action");
        User user = (User) request.getSession().getAttribute("CURRENT_USER");
        System.out.println(title + " TITLE");
        System.out.println(short_content + " SHORT CONTENT");
        if(btn_action.equals("add")){
            Post post = new Post(null, user, title, short_content, content, null);
            if(DBManager.addPost(post)){
                response.sendRedirect("/home");
            }else{
                response.sendRedirect("wrong.jsp");
            }
        }else if(btn_action.equals("update")){
            String new_title = request.getParameter("new_title");
            String new_short_content = request.getParameter("new_short_content");
            String new_content = request.getParameter("new_content");
            Long postId = Long.parseLong(request.getParameter("update_id"));
            Post post = new Post(postId, null, new_title, new_short_content, new_content, null);
            if(DBManager.updatePost(post)){
                response.sendRedirect("/home");
            }else{
                response.sendRedirect("wrong.jsp");
            }
        }else if(btn_action.equals("delete")){
            Long postID = (Long.parseLong(request.getParameter("delete_id")));
            if(DBManager.deletePost(postID)){
                response.sendRedirect("/home");
            }else{
                response.sendRedirect("wrong.jsp");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
