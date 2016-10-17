package com.wot.controller;

import com.wot.entity.RequestManager;
import com.wot.entity.Statistics;
import com.wot.entity.User;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Yurii Krat
 * @version 1.0
 * @since 14.10.16.
 */

@Controller
public class BaseStatistics {

    private final static String APP_ID = "a0b5d158684b7a16dc2d577a1aac3ae0";

    @RequestMapping(value = "/base_statistics")
    public String showBaseStatistics(Model model, @ModelAttribute("user") User user) {

        String url = "https://api.worldoftanks." + user.getServer() + "/wot/account/info/?application_id=" + APP_ID +
        "&account_id=" + user.getAccount_id() + "&extra=statistics.random";
        String response = RequestManager.getJSON(url, "GET");
        Statistics statistics = user.getStatistics();
        JSONObject jsonObject;
        try {
            jsonObject = (JSONObject) new JSONParser().parse(response);
            JSONObject jsonObject1 = (JSONObject) jsonObject.get("data");
            jsonObject = (JSONObject) jsonObject1.get(user.getAccount_id().toString());
            statistics.setGlobal_rating(Integer.parseInt(jsonObject.get("global_rating").toString()));
            jsonObject1 = (JSONObject) jsonObject.get("statistics");
            jsonObject = (JSONObject) jsonObject1.get("random");
            statistics.setAvg_damage_assisted(Double.parseDouble(jsonObject.get("avg_damage_assisted").toString()));
            statistics.setAvg_damage_blocked(Double.parseDouble(jsonObject.get("avg_damage_blocked").toString()));
            statistics.setBattle_avg_xp(Integer.parseInt(jsonObject.get("battle_avg_xp").toString()));
            statistics.setBattles(Integer.parseInt(jsonObject.get("battles").toString()));
            statistics.setCapture_points(Integer.parseInt(jsonObject.get("capture_points").toString()));
            statistics.setDamage_dealt(Integer.parseInt(jsonObject.get("damage_dealt").toString()));
            statistics.setDamage_received(Integer.parseInt(jsonObject.get("damage_received").toString()));
            statistics.setDraws(Integer.parseInt(jsonObject.get("draws").toString()));
            statistics.setDropped_capture_points(Integer.parseInt(jsonObject.get("dropped_capture_points").toString()));
            statistics.setFrags(Integer.parseInt(jsonObject.get("frags").toString()));
            statistics.setHits_percents(Integer.parseInt(jsonObject.get("hits_percents").toString()));
            statistics.setLosses(Integer.parseInt(jsonObject.get("losses").toString()));
            statistics.setSpotted(Integer.parseInt(jsonObject.get("spotted").toString()));
            statistics.setSurvived_battles(Integer.parseInt(jsonObject.get("survived_battles").toString()));
            statistics.setWins(Integer.parseInt(jsonObject.get("wins").toString()));
            statistics.setXp(Integer.parseInt(jsonObject.get("xp").toString()));
            statistics.setWinrate((double)statistics.getWins()/statistics.getBattles() * 100);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Map<String, String> userMap = new HashMap<>();
        userMap.put("nickname", user.getNickname());
        userMap.put("global_rating", statistics.getGlobal_rating().toString());
        userMap.put("battles", statistics.getBattles().toString());
        userMap.put("winrate", statistics.getWinrate().toString());
        userMap.put("wins", statistics.getWins().toString());
        userMap.put("draws", statistics.getDraws().toString());
        userMap.put("losses", statistics.getLosses().toString());
        userMap.put("survived_battles", statistics.getSurvived_battles().toString());
        userMap.put("battle_avg_xp", statistics.getBattle_avg_xp().toString());
        userMap.put("capture_points", statistics.getCapture_points().toString());
        userMap.put("dropped_capture_points", statistics.getDropped_capture_points().toString());
        userMap.put("hits_percents", statistics.getHits_percents().toString());
        userMap.put("avg_damage_assisted", statistics.getAvg_damage_assisted().toString());
        userMap.put("avg_damage_blocked", statistics.getAvg_damage_blocked().toString());
        userMap.put("xp", statistics.getXp().toString());
        userMap.put("frags", statistics.getFrags().toString());
        userMap.put("spotted", statistics.getSpotted().toString());
        userMap.put("damage_dealt", statistics.getDamage_dealt().toString());
        userMap.put("damage_received", statistics.getDamage_received().toString());
        model.addAllAttributes(userMap);
        return "statistics";
    }

}
