# 객체 직렬화(Serialization)

> 객체를 파일 등에 저장하거나 네트워크로 전송하기 위해 **연속적인 데이터로 변환**하는 것
>
> 반대의 경우 = 역 직렬화(deserialization)

* 직렬화의 조건

  * Serializable 인터페이스를 구현할 것
  * **클래스의 모든 멤버가 Serializable 인터페이스를 구현**해야함
    * ex) String 클래스 또한 Serializable 을 구현해서 String name; 을 쓰는 것이 가능하다
    * 만약 `implements Serializable` 된 현재 Class 내부에 `Address addr;` 로 변수가 설정되어있고 `Address` 클래스가 `implements Serializable`이 구현 안되었다면 해준다.
  * 직렬화에서 제외하려는 멤버 = transient 선언

  ```java
  class Person implements Serializable{
  	private String name;
  	private int age;
  	
  	private transient String ssn; //직렬화 제외
  	private LoginInfo lInfo;
  }
  ```

​                 

​                                

## serialVersionUID

> 클래스의 변경 여부를 파악하기 위한 유일 키
>
> 클래스에 변수하나만 추가되어도 serial의 버전이 아예 달라지기 때문에 읽지를 못한다.
>
> 이를 대비하기 위한 키이다.

* 직렬화 할 때의 UID와 역 직렬화 할 때의 UID가 다를 경우 예외 발생
* 직렬화되는 객체에 UID가 설정되지 않았을 경우 컴파일러가 자동 생성
  * 멤버 변경으로 인한 컴파일 시마다 변경 = InvalidClassException 초래
* 직렬화되는 객체에 대해서 serialVersionUID 설정 권장

​      

### 해결법

> serialVersionUID를 고정해줍니다

* 노란줄로 클래스가 표시되는 경우 generate ... 로 생성

  ```java
  private static final long serialVersion = -213213123123L; //자동 생성해줌
  // 클래스 내부 변수가 변경된다해도 변경된 객체직렬을 이 주소로 저장
  ```

  ​    

​                        

## ObjectInputStream, ObjectOutputStream

* ObjectOutputStream()

  ```java
  public ObjectOutputStream(OutputStream out) throws IOException
    //out을 이용해 ObjectOutputStream 객체 생성
  ```

* writeObject()

  ```java
  public final writeObject(Object obj) throws IOException
    //obj를 직렬화해서 출력
  ```

* ObjectInputStream()

  ```java
  public ObjectInputStream(InputStream in)throws IOExeption
    //in을 이용해 ObjectInputStream 객체를 생성한다
  ```

* readObject()

  ```java
  public final Object readObject() throws IOException, ClassNotFoundException
    //직렬화된 데이터를 역직렬화해서 Object로 리턴한다.
  ```

​      

### 실습

```java
public class Main {
	public static void main(String[] args) throws IOException{
		File target = new File("경로"); // 경로를 입력해 파일을 가상으로 가져옴
		write(target);
		read(target);
		
	}
	static void write(File target) { // 파일을 새로 생성하는 것 = 뱉어주는 것 = Output
		try(ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(target))){
      // try( resources : 여기서 객체를 만들면 자원을 나중에 자동으로 반납해줌)
			oos.writeObject("저장하려는 객체명"); // oos는 뱉어주는 빨대역할이고 oos.writeObject를 통해 해당 객체를 저장해줌
			System.out.println("저장 완료!");
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	
	static void read(File target) {
		try(ObjectInputStream ois = new ObjectInputStream(new FileInputStream(target))){
      // 빨아들이는 것은 InputStream
			Object obj = ois.readObject(); // 가져와야하기 때문에 임시 Object 변수로 받아줌
			if(obj != null && obj instanceof Person) { //null인지 검사해주고 instanceOf로 검사
				Person casted = (Person) obj;
				System.out.println(casted);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
```

