<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원 등록123</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="email"] {
            width: 300px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<h2>회원 등록</h2>

<form action="/register" method="post">
    <div class="form-group">
        <label for="name">이름</label>
        <input type="text" id="name" name="name" required>
    </div>

    <div class="form-group">
        <label for="email">이메일</label>
        <input type="email" id="email" name="email" required>
    </div>

    <div class="form-group">
        <label for="phone">전화번호</label>
        <input type="text" id="phone" name="phone">
    </div>

    <button type="submit">등록</button>
</form>
</body>
</html>
