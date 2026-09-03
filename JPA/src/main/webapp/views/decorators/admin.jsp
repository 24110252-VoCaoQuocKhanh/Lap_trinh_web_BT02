<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Sitemesh</title>
</head>
<body style="background-color: #f4f4f4;">

    <h1 style="color: red; text-align: center;">ĐÂY LÀ HEADER CỦA SITEMESH</h1>

    
    <div style="border: 2px solid blue; padding: 20px; margin: 20px;">
        <sitemesh:write property='body'/>
    </div>

    <h1 style="color: red; text-align: center;">ĐÂY LÀ FOOTER CỦA SITEMESH</h1>

</body>
</html>