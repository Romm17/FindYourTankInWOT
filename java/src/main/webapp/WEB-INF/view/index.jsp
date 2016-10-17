<%@ page session="false"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Find your tank in WOT</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/index.css">
</head>
<body>
    <div class="container-fluid">
        <div class="page-header">
            <h1>Find your tank in World of Tanks</h1>
        </div>
        <h3>Welcome to the World of Tanks Statistics and Recommendations Service!!!</h3>
            <form action="/search" method="post" class="form-inline">
                <select class="form-control" id="server" name="server">
                    <option value="ru">RU</option>
                    <option value="eu">EU</option>
                    <option value="na">NA</option>
                </select>
                <input class="input-lg" type="text" size="40" name="nickname" placeholder="Enter nickname" />
                <button class="btn-lg btn-primary" type="submit" name="submit"><span class="glyphicon glyphicon-search"></span>Search</button>
            </form>
    </div>
</body>
</html>