# Ajax와 JSON

> Ajax를 이용해 자바스크립트 내부로 로컬 JSON 파일을 가져올 수 있었다

### 주의사항

* JSON 파일에 문제가 있는 경우 오류가 발생하지 않고 로드가 되지 않는다.
* 이 때문에 가지고 있는 JSON 파일이 온전한 파일인지 확인하는 작업이 필요하다.
* https://kr.piliapp.com/json/validator/ 같은 사이트에서 해당 JSON파일이 완전한지 확인해준다.

​          

### 불러오기 및 사용

> $.getJSON을 통해 JSON 파일의 URL을 써주고 그 내부 data를 바로 함수로 받아준다.
>
> 받아준 data를 다시 $.each(data, function(i.e){}) 를 통해 순회할 수 있다.

```javascript
$(function () {
  
    //API 연결하면 읽어서 반환하는 부분
        let len = 0;
        $.getJSON("../data/data.json", function (data) {
    
            //JSOM 파일의 RESULT 키 값의 VALUE만 가져옵니다
            let a = data.RESULT;
            len = a.length;
            let html = '';
        $.each(a, function (i, e) {
    
            let address = e.address;
            let apt = e.apt;
            let cost = e.cost;
            html += `
            <div class="col-3">
            <div class="apt-name">${apt} 아파트</div>
            <p>${address}</p>
            <p>${cost}</p>
        </div>`;
        })
        $('#test-content').html(html);
        
        $('.apt-name').on("click", function () {
            let apt_save = this.innerHTML;
            console.log(apt_save.substring(0,apt_save.length-4));
            localStorage.aptSearch = apt_save.substring(0, apt_save.length - 4);
            //로컬 스토리지 값이 계속 변경됩니다.
            let search2 = '../member/search2.html';
            location.href = search2;
        })
        });
    })
```

