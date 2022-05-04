### const

* 선언시 값을 할당해야 한다.

​          

### object

* 내부에 value값이 없어도 변수명으로 호출이 가능하다.

  ```javascript
  const member2 = {
        id,
        name,
        age,
        info: function () {
          console.log('member2 - info');
        },
      };
      //값으로 들어갔지만 변수로 호출이 가능하다.
      console.log(member2.id, member2.name, member2.age);
      member2.info();
  ```

* function 키워드 제거

  ```javascript
  // 객체의 함수 단축 : function 키워드를 제거
      const member3 = {
        id,
        name,
        age,
        info() {
          console.log('member3 - info');
        },
      };
      console.log(member3.id, member3.name, member3.age);
      member3.info();
  ```

* Arrow 표현식에서 단일 인자인 경우 (소괄호) 생략가능

  ```javascript
  func2 = num => {
        console.log('실행이 된다.', num);
      };
  func2(3);
  ```

* return 값을 생략할 수 있다.

  ```javascript
  func1 = num => num * num; // {} 없이 사용할 경우에는 return 문을 생략한다. return 쓰면 에러                 
  console.log(func1(1)); // 1
  ```

​             

### lamda 표현식

* arguments 키워드와 같이 사용할 수 없다.

  ```javascript
  const func1 = () => {
          console.log('func1');
          for (let v of arguments) {
            // 에러 : Uncaught ReferenceError: arguments is not defined
            console.log(v);
          }
  };
  ```

  ​                   

  



### destructuring

* 객체 return문에 익숙해질 것

  ```javascript
  function getMember() {
        return {
          id: 'aaa',
          name: 'bbb',
          age: 22,
        };
  }
  ```

* 객체 내부의 인자값을 매핑해줄 수 있다.

  ```javascript
  function showMember2({ id, name, age, tel }) {
        console.log("아이디 :", id);
        console.log("이름 :", name);
        console.log("나이 :", age);
      }
  		
      let member = {
        id: 'aaa',
        name: 'bbb',
        age: 22,
      };
      
      showMember2(member);
  ```

​               

### spread

> `...`을 이용해 iterable한 객체를 쪼갤 수 있다.
> 배열, 문자열, 객체 등을 개별 요소로 분리한다.
> 객체의 경우 spread를 통해 합칠 때 맨 뒤에 있는 property값을 기준으로 바뀐다.

```javascript
const obj1 = { id: 'mlec', name: 'mlec site', email: 'm@co.kr' };
const obj2 = { email: 'mlec@co.kr', ...obj1 };
const obj3 = { ...obj1, email: 'mlec@co.kr' }; //뒤 이메일을 기준으로 덮어씌워진다.
console.log(obj2);
console.log(obj3);
```

​                     

### 문자열 메서드

* .unshit()

  ```javascript
  // 기존 배열의 앞에 추가하기
        const arr5 = [1, 2, 3];
        arr5.unshift(...arr1);
        console.log(arr5);
  ```

  

* .push()

  ```javascript
  // 기존 배열에 추가하기
        const arr4 = [1, 2, 3];
        arr4.push(...arr1);
        console.log(arr4);
  ```

  

* .splice(a, b, c): a에 c를 끼워넣고 c 이후 a의 원소 b개 제거

  ```javascript
  // 기존 배열의 중간에 추가하기
        const arr6 = [1, 2, 3];
        arr6.splice(1, 0, ...arr1);
        console.log(arr6);
  ```

  



