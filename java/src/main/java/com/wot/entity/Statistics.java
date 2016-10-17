package com.wot.entity;

/**
 * @author Yurii Krat
 * @version 1.0
 * @since 08.10.16.
 */
public class Statistics {

    /**
     * Personal rating
     */
    private Integer global_rating;

    /**
     * Average damage caused with your assistance
     */
    private Double avg_damage_assisted;

    /**
     * Average damage blocked by armor per battle
     */
    private Double avg_damage_blocked;

    /**
     * Average experience per battle
     */
    private Integer battle_avg_xp;

    /**
     * Battles fought
     */
    private Integer battles;

    /**
     * Base capture points
     */
    private Integer capture_points;

    /**
     * Damage caused
     */
    private Integer damage_dealt;

    /**
     * Damage received
     */
    private Integer damage_received;

    /**
     * Base defense points
     */
    private Integer dropped_capture_points;

    /**
     * Vehicles destroyed
     */
    private Integer frags;

    /**
     * Hit ratio
     */
    private Integer hits_percents;

    /**
     * Enemies spotted
     */
    private Integer spotted;

    /**
     * Battles survived
     */
    private Integer survived_battles;


    /**
     * Total experience
     */
    private Integer xp;

    /**
     * Victories
     */
    private Integer wins;

    /**
     * Winning rate
     */
    private Double winrate;

    /**
     * Defeats
     */
    private Integer losses;

    /**
     * Draws
     */
    private Integer draws;

    public Statistics() {

    }

    public Integer getGlobal_rating() {
        return global_rating;
    }

    public void setGlobal_rating(Integer global_rating) {
        this.global_rating = global_rating;
    }

    public Double getAvg_damage_blocked() {
        return avg_damage_blocked;
    }

    public void setAvg_damage_blocked(Double avg_damage_blocked) {
        this.avg_damage_blocked = avg_damage_blocked;
    }

    public Integer getBattle_avg_xp() {
        return battle_avg_xp;
    }

    public void setBattle_avg_xp(Integer battle_avg_xp) {
        this.battle_avg_xp = battle_avg_xp;
    }

    public Integer getBattles() {
        return battles;
    }

    public void setBattles(Integer battles) {
        this.battles = battles;
    }

    public Integer getDamage_dealt() {
        return damage_dealt;
    }

    public void setDamage_dealt(Integer damage_dealt) {
        this.damage_dealt = damage_dealt;
    }

    public Integer getDamage_received() {
        return damage_received;
    }

    public void setDamage_received(Integer damage_received) {
        this.damage_received = damage_received;
    }

    public Integer getFrags() {
        return frags;
    }

    public void setFrags(Integer frags) {
        this.frags = frags;
    }

    public Integer getXp() {
        return xp;
    }

    public void setXp(Integer xp) {
        this.xp = xp;
    }

    public Integer getWins() {
        return wins;
    }

    public void setWins(Integer wins) {
        this.wins = wins;
    }

    public Integer getLosses() {
        return losses;
    }

    public void setLosses(Integer losses) {
        this.losses = losses;
    }

    public Integer getDraws() {
        return draws;
    }

    public void setDraws(Integer draws) {
        this.draws = draws;
    }

    public Double getAvg_damage_assisted() {
        return avg_damage_assisted;
    }

    public void setAvg_damage_assisted(Double avg_damage_assisted) {
        this.avg_damage_assisted = avg_damage_assisted;
    }

    public Integer getCapture_points() {
        return capture_points;
    }

    public void setCapture_points(Integer capture_points) {
        this.capture_points = capture_points;
    }

    public Integer getDropped_capture_points() {
        return dropped_capture_points;
    }

    public void setDropped_capture_points(Integer dropped_capture_points) {
        this.dropped_capture_points = dropped_capture_points;
    }

    public Integer getHits_percents() {
        return hits_percents;
    }

    public void setHits_percents(Integer hits_percents) {
        this.hits_percents = hits_percents;
    }

    public Integer getSpotted() {
        return spotted;
    }

    public void setSpotted(Integer spotted) {
        this.spotted = spotted;
    }

    public Integer getSurvived_battles() {
        return survived_battles;
    }

    public void setSurvived_battles(Integer survived_battles) {
        this.survived_battles = survived_battles;
    }

    public Double getWinrate() {
        return winrate;
    }

    public void setWinrate(Double winrate) {
        this.winrate = winrate;
    }
}
