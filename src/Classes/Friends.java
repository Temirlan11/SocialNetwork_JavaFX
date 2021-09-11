package Classes;

import java.util.Date;

public class Friends {
    private Long id;
    private User user;
    private User friend;
    private Date added_time;

    public Friends(){}

    public Friends(Long id, User user, User friend, Date added_time) {
        this.id = id;
        this.user = user;
        this.friend = friend;
        this.added_time = added_time;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getFriend() {
        return friend;
    }

    public void setFriend(User friend) {
        this.friend = friend;
    }

    public Date getAdded_time() {
        return added_time;
    }

    public void setAdded_time(Date added_time) {
        this.added_time = added_time;
    }
}
