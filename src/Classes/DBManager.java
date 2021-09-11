package Classes;

import java.sql.*;
import java.util.ArrayList;

public class DBManager {
    private static Connection conn;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/task5?useUnicode=true&serverTimezone=UTC", "root", "");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static User getUser(String email){
        User user = null;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM users WHERE email = ?");
            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();

            if(resultSet.next()){
                user = new User(
                        resultSet.getLong("id"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("full_name"),
                        resultSet.getString("birth_date"),
                        resultSet.getString("picture_url")
                );
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return user;
    }

    public static User getUser(Long id){
        User user = null;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM users WHERE id = ?");
            statement.setLong(1, id);
            ResultSet resultSet = statement.executeQuery();

            if(resultSet.next()){
                user = new User(
                        resultSet.getLong("id"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("full_name"),
                        resultSet.getString("birth_date"),
                        resultSet.getString("picture_url")
                );
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return user;
    }

    public static ArrayList<User> getSearchingUsers(String name){
        ArrayList<User> users = new ArrayList<>();
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM users WHERE full_name LIKE ?");
            statement.setString(1, name);
            ResultSet resultSet = statement.executeQuery();

            while(resultSet.next()){
                users.add(new User(
                        resultSet.getLong("id"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("full_name"),
                        resultSet.getString("birth_date"),
                        resultSet.getString("picture_url")
                ));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return users;
    }

    public static boolean addUser(User user){
        int rows = 0;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "INSERT INTO users(id, email, password, full_name, birth_date, picture_url) " +
                    "VALUES (null, ?, ?, ?, ?, ?)");
            statement.setString(1, user.getEmail());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getFull_name());
            statement.setString(4, user.getBirth_date());
            statement.setString(5, "img/tima.png");

            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static boolean updateProfile(User user){
        int rows = 0;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "UPDATE users SET full_name = ?, birth_date = ? WHERE email = ?");
            statement.setString(1 ,user.getFull_name());
            statement.setString(2, user.getBirth_date());
            statement.setString(3, user.getEmail());
            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows > 0;
    }

    public static boolean updatePictureUrl(Long id, String url){
        int rows = 0;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "UPDATE users SET picture_url = ? WHERE id = ?");
            statement.setString(1 , url);
            statement.setLong(2, id);
            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows > 0;
    }

    public static boolean updatePassword(Long id, String password){
        int rows = 0;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "UPDATE users SET password = ? WHERE id = ?");
            statement.setString(1 , password);
            statement.setLong(2, id);
            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows > 0;
    }

    public static boolean addPost(Post post){
        int rows = 0;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "INSERT INTO posts(id, authod_id, title, short_content, content, post_date) " +
                    "VALUES (null, ?, ?, ?, ?, ?)");
            statement.setLong(1, post.getAuthor().getId());
            statement.setString(2, post.getTitle());
            statement.setString(3, post.getShortContent());
            statement.setString(4, post.getContent());
            java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
            statement.setTimestamp(5, date);

            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static ArrayList<Post> getPosts(){
        ArrayList<Post> posts = new ArrayList<>();
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM posts");
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()){
                posts.add(new Post(
                        resultSet.getLong("id"),
                        getUser(resultSet.getLong("authod_id")),
                        resultSet.getString("title"),
                        resultSet.getString("short_content"),
                        resultSet.getString("content"),
                        resultSet.getDate("post_date")
                ));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return posts;
    }

    public static ArrayList<Post> getPosts(Long author_id){
        ArrayList<Post> posts = new ArrayList<>();
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM posts WHERE authod_id = ?");
            statement.setLong(1, author_id);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()){
                posts.add(new Post(
                        resultSet.getLong("id"),
                        getUser(resultSet.getLong("authod_id")),
                        resultSet.getString("title"),
                        resultSet.getString("short_content"),
                        resultSet.getString("content"),
                        resultSet.getDate("post_date")
                ));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return posts;
    }


    public static Post getPost(Long id){
        Post post = null;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM posts WHERE id = ?");
            statement.setLong(1, id);
            ResultSet resultSet = statement.executeQuery();

            if(resultSet.next()){
                post = new Post(
                        resultSet.getLong("id"),
                        getUser(resultSet.getLong("authod_id")),
                        resultSet.getString("title"),
                        resultSet.getString("short_content"),
                        resultSet.getString("content"),
                        resultSet.getDate("post_date")
                );
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return post;
    }

    public static boolean deletePost(Long id){
        int rows = 0;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "DELETE FROM posts WHERE id = ?");
            statement.setLong(1, id);
            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static boolean updatePost(Post post){
        int rows = 0;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "UPDATE posts SET title=?, short_content=?, content=?, post_date=? WHERE id=?");
            statement.setString(1, post.getTitle());
            statement.setString(2, post.getShortContent());
            statement.setString(3, post.getContent());
            java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
            statement.setTimestamp(4, date);
            statement.setLong(5, post.getId());
            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static ArrayList<Friends> getFriends(Long id){
        ArrayList<Friends> friends = new ArrayList<>();
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM friends WHERE user_id = ?");
            statement.setLong(1, id);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()){
                friends.add(new Friends(
                        resultSet.getLong("id"),
                        getUser(resultSet.getLong("user_id")),
                        getUser(resultSet.getLong("friend_id")),
                        resultSet.getTime("added_time")
                ));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return friends;
    }

    public static Friends getFriends(Long user_id, User friend){
        Friends friends = null;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM friends WHERE user_id != ? AND friend_id != ?");
            statement.setLong(1, user_id);
            statement.setLong(2, friend.getId());
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()){
                friends = new Friends(
                        resultSet.getLong("id"),
                        getUser(resultSet.getLong("user_id")),
                        getUser(resultSet.getLong("friend_id")),
                        resultSet.getTime("added_time")
                );
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return friends;
    }

    public static Friends getFriendstoDelete(Long user_id, User friend){
        Friends friends = null;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM friends WHERE user_id = ? AND friend_id = ?");
            statement.setLong(1, user_id);
            statement.setLong(2, friend.getId());
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()){
                friends = new Friends(
                        resultSet.getLong("id"),
                        getUser(resultSet.getLong("user_id")),
                        getUser(resultSet.getLong("friend_id")),
                        resultSet.getTime("added_time")
                );
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return friends;
    }

    public static Friends getFriendstoDelete2(User friend, Long user_id){
        Friends friends = null;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM friends WHERE user_id = ? AND friend_id = ?");
            statement.setLong(1, friend.getId());
            statement.setLong(2, user_id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()){
                friends = new Friends(
                        resultSet.getLong("id"),
                        getUser(resultSet.getLong("user_id")),
                        getUser(resultSet.getLong("friend_id")),
                        resultSet.getTime("added_time")
                );
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return friends;
    }

    public static ArrayList<Friends> getAllFriends(){
        ArrayList<Friends> friends = new ArrayList<>();
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM friends");
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()){
                friends.add(new Friends(
                        resultSet.getLong("id"),
                        getUser(resultSet.getLong("user_id")),
                        getUser(resultSet.getLong("friend_id")),
                        resultSet.getTime("added_time")
                ));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return friends;
    }

    public static boolean sendRequest(Long receiver_id, Long sender_id){
        int rows = 0;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "INSERT INTO friends_requests(id, user_id, request_sender_id, sent_time) " +
                    "VALUES (null, ?, ?, ?)");
            statement.setLong(1, receiver_id);
            statement.setLong(2, sender_id);
            java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
            statement.setTimestamp(3, date);

            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static ArrayList<FriendsRequest> checkRequestStatus(User receiver){
        ArrayList<FriendsRequest> friendsRequests = new ArrayList<>();
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM friends_requests WHERE user_id = ?");
            statement.setLong(1, receiver.getId());
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()){
                friendsRequests.add(new FriendsRequest(
                        resultSet.getLong("id"),
                        getUser(resultSet.getLong("user_id")),
                        getUser(resultSet.getLong("request_sender_id")),
                        resultSet.getTime("sent_time")
                ));
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return friendsRequests;
    }

    public static FriendsRequest checkRequestStatus(User receiver, User sender){
        FriendsRequest friendsRequest = null;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM friends_requests WHERE user_id = ? AND request_sender_id = ?");
            statement.setLong(1, receiver.getId());
            statement.setLong(2, sender.getId());
            ResultSet resultSet = statement.executeQuery();

            if(resultSet.next()){
                friendsRequest = new FriendsRequest(
                        resultSet.getLong("id"),
                        getUser(resultSet.getLong("user_id")),
                        getUser(resultSet.getLong("request_sender_id")),
                        resultSet.getTime("sent_time")
                );
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return friendsRequest;
    }

    public static FriendsRequest getFriendRequest(Long id){
        FriendsRequest friendsRequest = null;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "SELECT * FROM friends_requests WHERE id = ?");
            statement.setLong(1, id);;
            ResultSet resultSet = statement.executeQuery();

            if(resultSet.next()){
                friendsRequest = new FriendsRequest(
                        resultSet.getLong("id"),
                        getUser(resultSet.getLong("user_id")),
                        getUser(resultSet.getLong("request_sender_id")),
                        resultSet.getTime("sent_time")
                );
            }
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return friendsRequest;
    }

    public static boolean deleteFriendRequest(Long id){
        int rows = 0;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "DELETE FROM friends_requests WHERE id = ?");
            statement.setLong(1, id);
            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static boolean addFriend(Long user_id, Long friend_id){
        int rows = 0;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "INSERT INTO friends(id, user_id, friend_id, added_time) " +
                    "VALUES (null, ?, ?, ?)");
            statement.setLong(1, user_id);
            statement.setLong(2, friend_id);
            java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
            statement.setTimestamp(3, date);

            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static boolean deleteFriend(Long id){
        int rows = 0;
        try{
            PreparedStatement statement = conn.prepareStatement("" +
                    "DELETE FROM friends WHERE id = ?");
            statement.setLong(1, id);
            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

//    public static ArrayList<Friends> getFriends(String name){
//        ArrayList<Friends> friends = new ArrayList<>();
//        try{
//            PreparedStatement statement = conn.prepareStatement("" +
//                    "SELECT * FROM friends WHERE user_id = ?");
//            statement.setLong(1, id);
//            ResultSet resultSet = statement.executeQuery();
//
//            while (resultSet.next()){
//                friends.add(new Friends(
//                        resultSet.getLong("id"),
//                        getUser(resultSet.getLong("user_id")),
//                        getUser(resultSet.getLong("friend_id")),
//                        resultSet.getTime("added_time")
//                ));
//            }
//            statement.close();
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//        return friends;
//    }

}
