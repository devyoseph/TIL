## Ajax 다양한 파일 형식

>  서버와 클라이언트는 주고 받을 data 형식을 맞춰야 함       

### CSV

> 쉼표(,)로 구분한 텍스트형식의 데이터.
>
> 많은 양의 데이터 전송 시 유리하다.

1. HTML의 위치에서 서버의 정보 받아오기

```html
    <script type="text/javascript">
      $(document).ready(function () {
        $('#listBtn').click(function () {
          // server에서 넘어온 data
          $.ajax({
        	  url: '1-05csv.jsp',
        	  type: 'GET',
        	  success: function(data) { //성공했을 때 데이터 받기
        		  makeList(data); // 가공 메서드
        	  }
          });
        });
</script>
```

2. CSV 파일을 가공해주기

```javascript
function makeList(data) {
  var students = data.split('\n');
  $('#studentinfo').empty();
  $.each(students, function(index, item) {
    var student = item.split(',');
    var tr = $('<tr>');
    $.each(student, function(i, info) {
      $(`<td>${info}</td>`).appendTo(tr);
    });
    $('#studentinfo').append(tr);
  });
  $('tr:first').css('background', 'darkgray').css('color', 'white');
  $('tr:odd').css('background', 'lightgray');
}
```

​          

### XML

> xml은 tag로 data를 표현한다.
>
> tag에 사용자 정의 속성을 넣을 수 있어 복잡한 data를 전달할 수 있다.