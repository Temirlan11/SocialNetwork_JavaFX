package Classes;

import java.util.Date;

public class FriendsRequest {
    private Long id;
    private User user;
    private User sender;
    private Date sent_time;

    public FriendsRequest(){}

    public FriendsRequest(Long id, User user, User sender, Date sent_time) {
        this.id = id;
        this.user = user;
        this.sender = sender;
        this.sent_time = sent_time;
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

    public User getSender() {
        return sender;
    }

    public void setSender(User sender) {
        this.sender = sender;
    }

    public Date getSent_time() {
        return sent_time;
    }

    public void setSent_time(Date sent_time) {
        this.sent_time = sent_time;
    }
}
