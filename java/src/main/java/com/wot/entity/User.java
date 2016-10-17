package com.wot.entity;

/**
 * @author Yurii Krat
 * @version 1.0
 * @since 08.10.16.
 */
public class User {

    /**
     * Player name
     */
    private String nickname;

    /**
     * Player account ID
     */
    private Integer account_id;

    /**
     * Player statistics
     */
    private Statistics statistics;

    /**
     * Game server
     */
    private String server;

    public User() {
    }

    public User(String nickname, Integer account_id, Statistics statistics, String server) {
        this.nickname = nickname;
        this.account_id = account_id;
        this.statistics = statistics;
        this.server = server;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public Integer getAccount_id() {
        return account_id;
    }

    public void setAccount_id(Integer account_id) {
        this.account_id = account_id;
    }

    public Statistics getStatistics() {
        return statistics;
    }

    public void setStatistics(Statistics statistics) {
        this.statistics = statistics;
    }

    public String getServer() {
        return server;
    }

    public void setServer(String server) {
        this.server = server;
    }
}
