# HTML TIP

### 1. 이미지와 div 태그 딱 붙이기

> 이미지가 들어있는 div태그의 높이를 0으로 바꾼다

```css
line-height: 0;
```

​           

### 2. 요소를 어떤 요소 가운데로 넣어주기

* 부모 요소

```css
position: relative;
```

* 자식 요소: 혹은 translate 사용

```css
position: absolute;
top: 50%;
bottom: 50%;

margin-top: -50px;
margin-left: -50px;
/* 세부조정 */
```

​      

### 3. 이미지를 가운데로 넣어주기

> 이미지가 있는 div 태그에 세로줄을 만들어 위에서 밀어준다

```css
line-height: 100px;
```

​      

### 4. 커서 할 때 마우스 모양 바꾸기

```css
#up_button:hover{
    cursor: pointer;
}
```

​          

### 5. 클래스가 많아지면서 빠르게 선택하고 수정할 때 사용하는 키

* 하나를 드래그 하고 내리면서 클릭하면 같은 이름의 클래스가 자동 선택됩니다.

> Ctrl + d

