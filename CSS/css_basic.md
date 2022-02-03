# CSS

> 스타일을 지정하기 위한 언어(Cascading Style Sheets)
>
> **선택**하고 **스타일**을 지정한다

​    

```
! + tab
```

​     

## 문법

```css
h1 { /* 선택자(Selector) */
	color: blue; /* 선언(Declaration) */
	font-size: 15px;
/* 속성(Property): 값(Value) */
}
```

* 중괄호 안에서 속성과 값 하나의 쌍으로 이루어진 선언을 진행

  * 속성(Property) : 어떤 스타일 기능을 변경할지 결정
  * 값(Value) : 어떻게 스타일 기능을 변경할지 결정

  ​    

#### CSS 정의 방법

1. 인라인(inline)

   ```css
   <h1 style="color: blue;">Hello</h1>
   ```

2. 내부 참조(embedding) - \<style>

   ```css
   /* HTML 문서 내부에 넣음 */
   <style>
   	h1{
     	color: blue;
   	}
   <style>
   ```

3. 외부 참조(link file) - 분리된 CSS 파일

   * style.css 파일을 만들고 link 태그를 이용해 불러옴

     ```html
       <link rel="stylesheet" href="../style.css">
     ```

   ​    

​    

### Global CSS Property Usage

> 자주 사용하는 속성 위주로 익혀준다

   

### CSS with 개발자 도구

* styles : 해당 요소에 선언된 모든 CSS
* computed : 해당 요소에 적용된 최종 CSS

​      

​     

## 선택자(Selector) 유형

```css
    /* 전체 선택자 */
    *{
      color: blue;
    }

    /* 요소 선택자 */
    h2 {
      color: orange;
    }

    h3, h4 { /* 여러 요소 선택 ',' */
      color: purple;
      font-size: 10px;
    }

    /* 클래스 선택자 */
    .green{
      color:green;
    }

    /* id 선택자 */
    #purple{
      color: purple;
    }

    /* 자식 결합자 */
    .box > p {
      font-size: 1px;
    }

    /* 자손 결합자 */
    .box p {
      color: indianred;
    }
```

​    

* 기본 선택자

  * 전체 선택자, 요소 선택자

  * 클래스 선택자, 아이디 선택자, 속성 선택자

    ​    

* 결합자(Combinators)

  ​    

  * 자손 결합자

    ```css
    li p { }
    ```

    * selectorA 하위의 모든 selectorB 요소

      ​    

  * 자식 결합자

    ```css
    li > p { }
    ```

    * selectorA 바로 아래의 selectorB 요소

      ​    

  * 일반 형제 결합자

    ```css
    p ~ span {
    	color: red;
    }
    ```

    * selectorA의 형제 요소 중 뒤에 위치하는 selectorB 요소를 모두 선택    

      ​    

  * 인접 형제 결합자

    ```css
    p + span {
    	color: red;
    }
    ```

    * selectorA의 형제 요소 중 뒤에 위치하는 selectorB 요소를 선택

    ​        

* 의사 클래스/요소(Pseudo Class)

  * 링크, 동적 의사 클래스
  * 구조적 의사 클래스, 기타 의사 클래스, 의사 엘리먼트, 속성 선택자

​                

#### CSS 적용 우선순위(cascading order)

1. 중요도(Importance) - 사용시 주의

```css
!important
```

2. 우선 순위(Specify)

   * 인라인 > id > class, 속성, pseudo-class > 요소, pseudo-element

3. CSS 파일 로딩 순서

   * 같은 순위를 가졌을 경우 **가장 마지막에 있는 속성**이 우선순위가 높다.

     > CSS 상 로딩 순서지 html 에서 언급된 순서가 아님을 주의한다

​     

#### 주의

> class 이름은 띄어쓰기가 안된다
>
> 만약 ```class green box``` 로 써져있다면 green 과 box class가 적용된 것이다.

​     

#### CSS 상속

* CSS 상속을 통해 부모 요소의 속성을 자식에게 상속한다
  * 속성(프로퍼티) 중에는 상속이 되는 것과 되지 않는 것들이 있다
  * 상속 되는 것
    * Ex) Text 관련 요소(font,color,text-align), opacity, visibility
  * 상속 되지 않는 것
    * Box model 관련 요소(width, height, margin, padding, border, box-sizing, display)
    * position 관련 요소(position, top/right/bottom/left, z-index) 등

​    

## CSS 기본 스타일

​    

### 크기 단위

* px(픽셀)
  * 모니터 해상도의 한 화소인 '픽셀' 기준
  * 픽셀의 크기는 변하지 않기 때문에 고정적인 단위
* %
  * 백분율 단위
  * 가변적인 레이아웃에서 자주 사용

* em
  * (부모 요소에 대한) 상속의 영향을 받음
  * 배수 단위, 요소에 지정된 사이즈에 상대적인 사이즈를 가짐
* rem
  * (부모 요소에 대한) 상속의 영향을 받지 않음
  * 최상위 요소(html)의 사이즈를 기준으로 배수 단위를 가짐

```css
  <style>
    .em {
      font-size: 1.5em;
    }

    .rem {
      font-size: 1.5rem;
    }
  </style>
```

```html
  <ul class="em">
    <li class="em">1.5em</li> <!--1) 위 em을 적용한 배수의 1.5배만큼 다시 크게 만듦-->
    <li class="rem">1.5rem</li> <!--2) em에 영향 받지 않고 기본 폰트 크기 1.5배-->
    <li>no class</li> <!--3) em만 적용-->
  </ul> <!-- 결론: 1 = 3 -->
```

​     

### 색상 단위

* 색상 키워드

  ```css
  p { color: black; }
  ```

  * 대소문자를 구분하지 않음
  * red, blue, black 같은 특정 색을 **글자로** 나타냄

* RGB 색상

  ```css
  p { color: #000000; }
  ```

  ```css
  p { rgba(0,0,0,0.5); }
  ```

  * 16 진수 표기법
  * 함수형 표기법을 사용해서 특정 색을 표현하는 방식
    * r, g, b, a(투명도)

* HSL 색상

  ```css
  p { color: hsla(120, 100%, 0.5); }
  ```

  * 색상, 채도, 명도를 통해 특정 색을 표현하는 방식

​    

​      

## CSS Box model

> 모든 요소는 **네모(박스모델)**이고
>
> **Normal flow**: 위에서부터 아래로, 왼쪽에서 오른쪽으로 쌓인다 (**좌측 상단 배치**)

​     

#### Box Model

> shorthand를 활용해 간단하게 표현 가능하다

* 모든 HTML 요소는 box 형태로 되어있음

* 하나의 박스는 네 부분(영역)으로 이루어짐

  * content : 실제 내용

  * padding : 안쪽 여백

    ​    

  * border : 테두리

    ```css
    .border{
    	border: 2px dashed black;
    }
    ```

    * width - style - color 

    ​    

  * margin : 테두리를 기준으로 밖의 공간

    ````css
    margin: 10px;
    margin: 10px 20px;
    margin: 10px 20px 30px 40px; /*상우하좌*/
    ````

    * top/right/bottom/left

    ​     

* 실습예제

      ```css
      		.box1 {
            width: 500px;
            /* dashed border */
            border: 2px dashed black;
            padding-left: 50px;
            margin-right: 10px;
            margin-bottom: 20px;
          }
      
          .box2 {
            width: 500px;
            /* solid border */
            border: 2px solid black;
            padding: 20px;
          }
      ```

​     

​     

## CSS Display

> 모든 요소는 네모(박스모델)이고, 좌측상단에 배치
>
> **display**에 따라 크기와 배치가 달라진다.

​    

```css
display: block
```

* 줄 바꿈이 일어나는 요소
* 화면 크기 전체의 가로 폭을 차지한다.
* 블록 레벨 요소 안에 인라인 레벨 요소가 들어갈 수 있음

> div / ul, ol, li / p / hr / form

​     

````css
display: inline
````

* 줄 바꿈이 일어나지 않는 행의 일부 요소
* content 너비만큼 가로 폭을 차지한다
* width, height, margin-top, margin-bottom을 지정할 수 없다.
* 상하 여백은 line-height로 지정한다.

>  span / a / img / input, label / b, em, i, strong 등     

​     

```css
display: inline-block
```

* block과 inline 레벨 요소의 특징을 모두 가짐
* inline 처럼 한 줄에 표시 가능하고, block처럼 width, height, margin 속성을 모두 지정할 수 있음

​    

```css
display: none
```

* 해당 요소를 화면에 표시X, 공간 부여X
* 이와 비슷한 visibility: hidden은 해당 요소가 공간은 차지하나 화면에 표시만 하지 않는다

​     

​      

## CSS Position

* 문서 상에서 요소를 위치에 지정

* static: 모든 태그의 기본 값(기준 위치)

  * 일반적인 요소의 배치 순서에 따름(좌측 상단)

  * 부모 요소 내에서 배치될 때는 부모 요소의 위치를 기준으로 배치

    ​      

* 아래는 좌표 프로퍼티(top, bottom, left, right)를 사용하여 이동 가능

  ​    

  * relative : 상대 위치 **[내 자리 기준 이동]**

    * 자기 자신의 static 위치를 기준으로 이동 (normal flow) , **다른 absolute에 의해 겹침 가능**
    * 레이아웃에서 요소가 차지하는 공간은 static일 때와 같음

    ​    

  * absolute : 절대 위치 **[부모 기준 이동]**

    * 요소를 일반적인 문서 흐름에서 제거 후 **레이아웃에 공간을 차지 하지 않음** = **겹침 가능**
      * 자신의 기준(static)이 없으므로 가까운 부모의 위치를 기준으로 함
    * **static이 아닌** 가장 가까이 있는 부모/조상 요소를 기준으로 이동

    ​      

  * fixed : 고정 위치

    * 요소를 일반적인 문서 흐름에서 제거 후 **레이아웃에 공간을 차지 하지 않음** = **겹침 가능**
    * 부모 요소와 관계없이 viewport를 기준으로 이동
      * 스크롤 시에도 항상 같은 곳에 위치

    ​     

  * sticky

    * 자기자리는 유지하지만 화면을 넘어가는 순간 같이 따라서 나옴
    * 부모 영역까지는 또 유지되고 부모영역을 벗어나면 완전히 사라짐
    * relative + fixed

  ​     

  ​    

## CSS 원칙

* CSS 원칙 I, II : Normal flow
  * 모든 요소는 네모(박스모델), 좌측상단에 배치
  * display에 따라 크기와 배치가 달라짐
* CSS 원칙 III
  * position으로 위치의 기준을 변경
    * relative : 본인의 원래 위치
    * absolute : 특정 부모의 위치
    * fixed : 화면의 위치

​     

​       

#### MDN

> MDN 문서를 사용해 사용법 익히기

​     

#### Emmet

**약어로 html을 빠르게 작성 가능**

> HTML & CSS 보다 **빠른 빌드업** 가능
>
> 단축키, 약어 등을 사용
>
> 대부분의 텍스트 에디터에서 지원

https://emmet.io/

https://docs.emmet.io/cheat-sheet/