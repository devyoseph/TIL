# IO & Stream

> 키보드의 입력은? byte 형태 = char로 변환하는 과정이 필요 = InputStreamReader

* Input(입력)과 Output(출력)
* 데이터는 한쪽에서 주고 한쪽에서 받는 구조
  * Node: 입력과 출력의 끝단
  * Stream: 두 노드를 연결하고 데이터를 전송할 수 있는 개념
    * 스트림은 단방향으로만 통신이 가능하며 하나의 스트림으로 입력과 출력을 같이할 수 없음
    * InputStream / OutputStream

​        

​       

## Node Stream

> Node에 연결되는 스트림
>
> 상대경로로 "." 의 위치? = 이클립스 상으로는 project의 루트폴더지만 더 정확히는 **java파일이 실행되는 위치**이다.

* 데이터 타입에 따라
  * byte: XXStream
  * char: XXer
* 방향에 따라
  * 입력: InputStream / Reader
  * 출력: OutputStream / Writer
* 노드 타입에 따라 최종 노드 스트림 결정
  * 키보드 : InputStream / Reader
  * 모니터 : OutputStream / Writer
  * 파일 : FileInputStream / FileOutputStream. FileReader / FileWriter
  * ByteArray : ByteArrayInputStream / ByteArrayOutputStream, CharArrayReader / CharArrayWriter
  * Pipe : PipedInputStream / PipedOutputStream, PipedReader / PipedWriter
  * String : StringReader / StringWriter

​              

​            

### InputStream 의 주요 메서드

* read()

  * byte 하나를 읽어서 int로 반환하다. 더 이상 읽을 것이 없으면 -1을 리턴

  | 선언부와 설명                                                |
  | ------------------------------------------------------------ |
  | `public abstract int read() throws IOException`              |
  | `public int read(byte b[]) throws IOException`               |
  | `public int read(byte b[], int offset, int len) throws IOException` |

  * 3번째 코드 설명: 최대 len 만큼 데이터를 읽어서 b의 offset부터 b에 저장하고 바이트 개수를 리턴

  ```java
  import java.io.*;
  import java.util.*;
  
  
  public class Main {
  	public static void main(String[] args) throws IOException{
  		String data = "자바는 객체지향 언어입니다."; //한글은 유니코드로 이루어져있고 한 글자가 3바이트기 때문에 깨질 수 있다.
  		byte[] buffer = new byte[10];
  		
  		try(InputStream input = new ByteArrayInputStream(data.getBytes())) {
  			int read = -1;
  			while((read = input.read(buffer))>0) {
  				System.out.printf("읽은 개수 : %d, 문자열 : %s%n",read,new String(buffer));
  			}
  		}catch(IOException e) {
  			e.printStackTrace();
  		}
  	}
  }
  ```

* close()

  * 스트림을 종료해서 자원을 반납한다

    `public void close() throws IOException`

​           

### Reader의 주요 메서드

* read()

  ```java
  import java.io.*;
  import java.util.*;
  
  
  public class Main {
  	public static void main(String[] args) throws IOException{
  		String data = "자바는 객체지향 언어입니다."; //한글은 유니코드로 이루어져있고 한 글자가 3바이트기 때문에 깨질 수 있다.
  		char[] buffer = new char[10];
  		
  		try(Reader input = new CharArrayReader(data.toCharArray())) {
  			int read = -1;
  			while((read = input.read(buffer))>0) {
  				System.out.printf("읽은 개수 : %d, 문자열 : %s%n",read,new String(buffer));
  			}
  		}catch(IOException e) {
  			e.printStackTrace();
  		}
  	}
  }
  ```

  

  ​       

### OutputStream 의 주요 메서드

* write()
* close()
* flush()

​        

### Writer 의 주요 메서드

* write()
* append()
* close()
* flush()

​       

​           

## File

* 가장 기본적인 입출력 장치 중 하나로 파일과 디렉토리를 다루는 클래스

> txt 뿐 아니라 디렉토리를 포함하는 개념

* File()

  | 선언부                                    | 설명                                                         |
  | ----------------------------------------- | ------------------------------------------------------------ |
  | `public File(String pathname)`            | pathname에 해당하는 파일을 생성한다. 경로없이 생성하면 애플리케이션을 시작한 경로 |
  | `public File(String parent,String child)` | parent 경로 아래 child를 생성                                |
  | `public File(URI uri)`                    | file로 시작하는 URI객체를 이용해 파일을 생성한다             |

* createNewFile()

  `public boolean createNewFile() throws IOException`

  * 새로운 물리적인 파일을 생성한다.

* mkdir()

  `public boolean mkdir()`

  * 새로운 디렉토리를 생성한다.

* mkdirs()

  `public boolean mkdirs()`

  * 경로상에 없는 모든 디렉토리를 생성한다.

* delete()

  `public boolean delete()`

  * 파일 또는 디렉토리를 삭제한다.

* 그 외 메서드
  * getName(), getPath(), getAbsolutePath(), getCanonicalPath(), isDirectory(), IsFile(), length(), listFiles()

* 같은 패키지 내부 특정 파일을 실행할 때

  ```java
  URL url = UseFileStream.class.getResource("readme.txt");
  String file = url.getFile();
  ```

​      

## 노드 스트림의 활용

* FileInputStream()

  ```java
  public FileInputStream(String name) throws FileNotFoundException
  // name 경로의 파일을 읽는 FileInputStream을 생성한다.
  ```

* FileOutputStream()

  ```java
  public FileOutputStream(String name) throws FileNotFoundException
  // name 경로의 파일에 출력하는 FileOutputStream을 생성한다.
    
  public FileOutputStream(String name, boolean append) throws FileNotFoundException
  // name 경로의 파일에 출력하는 FileOutputStream을 생성한다. 기존에 파일이 있다면 뒤에 이어 쓴다.
  ```

* FileReader, FileWriter

​           

​              

​              

# 보조 스트림

* 보조 스트림 : Filter Stream, Processing Stream
  * 다른 스트림에 부가적인 기능을 제공하는 스트림
  * 본래 노드 스트림 : 단순한 byte와 char의 전달
* 스트림 체이닝(Stream Chaining)
  * 필요에 따라 여러 보조 스트림을 연결해서 사용 가능

​       

## 보조 스트림의 종류

| 기능                               | byte 기반                                     | char 기반                          |
| ---------------------------------- | --------------------------------------------- | ---------------------------------- |
| byte 스트림을 char 스트림으로 변환 | InputStreamReader<br />OutputStreamWriter     |                                    |
| 버퍼링을 통한 속도 향상            | BufferedInputStream<br />BufferedOutputStream | BufferedReader<br />BufferedWriter |
| 객체 전송                          | ObjectInputStream<br />ObjectOutputStream     |                                    |

* 생성 - 이전 스트림을 생성자의 파라미터에 연결

  ```java
  new BufferedInputStream(System.in);
  
  new DataInputStream(new BufferedInputStream(new FileInputStream()));
  ```

* 종료

  * 보조 스트림의 close()를 호출하면 노드 스트림의 close()까지 호출