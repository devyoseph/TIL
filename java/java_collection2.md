# Collection 공통 메서드

| 분류 | Collection                                                   |
| ---- | ------------------------------------------------------------ |
| 추가 | add(E e) <br />addAll(Collection<? extends E> c)             |
| 조회 | contains(Object o)<br />containsAll(Collection<?> c)<br />equals()<br />isEmpty()<br />iterator()<br />size() |
| 삭제 | clear()<br />remove()<br />removeAll(Collection<?> c)<br />retainAll(Collection<?\> c) |
| 수정 |                                                              |
| 기타 | toArray()                                                    |

​                        

​                          

## List 메서드

| 분류 | List                                                         |
| ---- | ------------------------------------------------------------ |
| 추가 | add(int index, E element)<br />addAll(int index, Collection<? extends E> c) |
| 조회 | get(int index)<br />indexOf(Object o)<br />lastIndexOf(Object o)<br />listIterator() |
| 삭제 | remove(int index)                                            |
| 수정 | set(int index, E element)                                    |
| 기타 | subList(int fromIndex, int toIndex)                          |

​    

​           

## Set 활용

* Iterator을 이용한 조회 : set내부 iterator() 메서드 사용
* for문을 사용한 조회

```java
Set<Object> hset = new HashSet<Object>();
Iterator<Object> iter = hset.iterator();

while(iter.hasNext()){
    System.out.println("iter : "+iter.next());
}

for(Object sobj : hset){
	System.out.println("데이터 조회: "+sobj);
}
```

* Set에 String데이터를 넣는 경우 같은 문자열이라도 두 개가 들어가 중복이 된다.

  * 비교하는 class 기준으로 `equals()`메서드를 재정의한다.

  ```java
  @Override
  public boolean equals(Object obj){
  	if(obj != null && obj instanceOf SmartPhone){
          SmartPhone sp = (SmartPhone) obj;
          return this.number.equals(sp.number);
  	}
      return false;
  }
  ```

  * hashCode() 값을 재정의한다.

  ```java
  @Override
  public int hashCode(){
  	return this.number.hashCode(); //번호가 겹치면 안되므로 번호자체를 해시코드화
  }
  ```

  ​                   

  ​                     

  ## Map

  > Key와 Value를 하나의 Entry로 묶어서 데이터 관리
  >
  > Python에서는 Entry = item
  >
  > Map의 Entry를 모두 불러온 다음(entrySet() 이용)

* Key는 Object 형태로 중복X, Value는 Object 형태로 중복O

  | 분류 | Map<K,V>                                                     |
  | ---- | ------------------------------------------------------------ |
  | 추가 | put(K key, V value)<br />pullAll(Map<? extends K, ? extends V> m) |
  | 조회 | containsKey(Object key)<br />containsValue(Object value)<br />entrySet()<br />keySet()<br />get(Object key)<br />values()<br />size()<br />isEmpty() |
  | 삭제 | clear()<br />remove(Object key)                              |
  | 수정 | put(K key, V value)<br />putAll(Map<? extends K, ? extends V> m) |

  ​                  

* Map 실습

```java
Map<String, String> hMap = new HashMap<>();
hMap.put("andy","1234"); //들어감
hMap.put("kate","1234"); //들어감
hMap.put("andy","9999"); //안들어감
hMap.putIfAbsent("kate","1234"); //안들어감

System.out.println(hMap.containsKey("kate"));

Set<String> keys = hMap.keySet();

for(String key : keys){ //key를 이용해 value도 순회할 수 있다
	System.out.println("iterator : "+hMap.get(key));
}

Set<Entry<String, String>> entrySet = hMap.entrySet(); // java.util.Map에 있는 Entry 사용

for(Entry<String,String> entry : entrySet){
    if(entry.getValue().equals("4567")){ // value가 같을 때 Key값 구하기
        System.out.println(entry.getKey());
	}
}
```

