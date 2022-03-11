## HTML에서 살펴보기

### GET

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="" method="get">
        <input type="text" name="addr" id="iddr"><br>
        <input type="text" name="age" id="age"><br>
        <input type="submit" value="전송">
    </form>
</body>
</html>
```

* `action`: get으로 전송할 때 이동할 페이지

* `iddr`에 abcd를 입력하고 `age`에 20을 입력하면 URL이 다음처럼 바뀐다.

  ```
  http://localhost:8080/sam/chap1/method.html?addr=abcd&age=20
  ```

​               

### GET 방식의 응용

* 꼭 form 태그를 이용하지 않고 전송할 수 없을까? = **가능**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="" method="get">
        <input type="text" name="addr" id="iddr"><br>
        <input type="text" name="age" id="age"><br>
        <input type="submit" value="전송">
    </form>
  
  	<a href = "process.jsp?addr=gumi&age=26">process.jsp</a>
</body>
</html>
```

​         

#### submit 중복 송신에 주의

```html
<head>    
		<script>
        function aa(){
            console.log('aa');
        }
    </script>
</head>
<body>
    <form action="process.jsp" method="get" onsubmit="aa();">
        <input type="text" name="addr" id="iddr"><br>
        <input type="text" name="age" id="age"><br>
        <input type="submit" value="전송">
    </form>
</body>
```

