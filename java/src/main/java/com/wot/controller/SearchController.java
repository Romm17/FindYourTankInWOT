package com.wot.controller;

import com.wot.entity.RequestManager;
import com.wot.entity.Statistics;
import com.wot.entity.User;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletRequest;

/**
 * @author Yurii Krat
 * @version 1.0
 * @since 08.10.16.
 */

@Controller
public class SearchController {

    private final static String APP_ID = "a0b5d158684b7a16dc2d577a1aac3ae0";

    @RequestMapping(value = "/search")
    public String searchPlayer( HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String name = request.getParameter("nickname");
        String server = request.getParameter("server");

        String url = "https://api.worldoftanks." + server + "/wot/account/list/?application_id=" + APP_ID +
                "&search=" + name + "&limit=1";
        try {
            String response = RequestManager.getJSON(url, "GET");
            JSONObject jsonObject = (JSONObject) new JSONParser().parse(response);
            JSONArray jsonArray = (JSONArray)jsonObject.get("data");
            jsonObject = (JSONObject)jsonArray.get(0);
            Integer account_id = Integer.parseInt(jsonObject.get("account_id").toString());
            String username = jsonObject.get("nickname").toString();
            Statistics statistics = new Statistics();
            User user = new User(username, account_id, statistics, server);
            redirectAttributes.addFlashAttribute("user", user);

        } catch (ParseException e) {
            e.printStackTrace();
        }

        return "redirect:base_statistics";

    }
}
