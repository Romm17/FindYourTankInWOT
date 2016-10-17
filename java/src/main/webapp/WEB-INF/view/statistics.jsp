<%@ page session="false"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Statistics</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/index.css">
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-9">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th rowspan="2">${nickname}</th>
                        </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>Global rating</td>
                        <td>${global_rating}</td>
                    </tr>
                    <tr>
                        <td>Battles</td>
                        <td>${battles}</td>
                    </tr>
                    <tr>
                        <td>Winning Rate <span class="glyphicon glyphicon-flag"></span></td>
                        <td>${winrate}</td>
                    </tr>
                    <tr>
                        <td>Wins</td>
                        <td>${wins}</td>
                    </tr>
                    <tr>
                        <td>Draws</td>
                        <td>${draws}</td>
                    </tr>
                    <tr>
                        <td>Defeats</td>
                        <td>${losses}</td>
                    </tr>
                    <tr>
                        <td>Survived battles</td>
                        <td>${survived_battles}</td>
                    </tr>
                    <tr>
                        <td>Average experience per battle <span class="glyphicon glyphicon-star"></span></td>
                        <td>${battle_avg_xp}</td>
                    </tr>
                    <tr>
                        <td>Total capture points</td>
                        <td>${capture_points}</td>
                    </tr>
                    <tr>
                        <td>Total dropped capture points</td>
                        <td>${dropped_capture_points}</td>
                    </tr>
                    <tr>
                        <td>Hits percents <span class="glyphicon glyphicon-screenshot"></span></td>
                        <td>${hits_percents}</td>
                    </tr>
                    <tr>
                        <td>Average damage assisted per game</td>
                        <td>${avg_damage_assisted}</td>
                    </tr>
                    <tr>
                        <td>Average damage blocked per game</td>
                        <td>${avg_damage_blocked}</td>
                    </tr>
                    <tr>
                        <td>Total experience <span class="glyphicon glyphicon-star"></span></td>
                        <td>${xp}</td>
                    </tr>
                    <tr>
                        <td>Total frags</td>
                        <td>${frags}</td>
                    </tr>
                    <tr>
                        <td>Total spotted enemies <span class="glyphicon glyphicon-eye-open"></span></td>
                        <td>${spotted}</td>
                    </tr>
                    <tr>
                        <td>Total damage dealt <span class="glyphicon glyphicon-fire"></span></td>
                        <td>${damage_dealt}</td>
                    </tr>
                    <tr>
                        <td>Total damage received</td>
                        <td>${damage_received}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <nav class="col-md-3">
                <ul class="nav nav-pills nav-stacked" data-spy="affix-top" data-offset-top="105">
                    <li class="active"><a href="#">General Statistics</a></li>
                    <li><a href="#">Vehicles</a></li>
                    <li><a href="#">Recommendations</a></li>
                </ul>
            </nav>
        </div>
    </div>

</body>
</html>
