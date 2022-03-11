# 파일 시스템

> File : 일반적으로 비휘발성의 보조기억장치에 저장
>
> **운영체제** : 다양한 저장 장치를 file이라는 동일한 논리적 단위로 볼 수 있게 해 줌

* 파일의 연산(Operation)

  * create, read, write, reposition(현재 접근하는 위치를 수정), delete, open, close

* File attribute(혹은 파일의 metadata)

  * open 명령어를 통해 파일의 metadata를 메모리에 올려놓는다.

    <img src="CS_filesys.assets/image-20220301201843297.png" alt="image-20220301201843297" style="zoom:33%;" />

  * 파일 자체의 내용이 아니라 **파일을 관리하기 위한** 각종 정보들

    * 파일 이름, 유형, 저장 위치, 파일 사이즈
    * 접근 권한(읽기/쓰기/실행), 시간(생성/변경/사용), 소유자 등

* **File system**

  * 운영체제에서 파일을 관리하는 부분
  * 파일 및 파일의 metadata, 디렉토리 정보 등을 관리
  * 파일의 저장 방법 결정
  * 파일 보호 등

* Directory : 하나의 파일이다.

  * 파일의 메타데이터 중 일부를 보관하고 있는 일종의 특별한 파일
    * 그 디렉토리에 속한 파일 이름 및 파일 attribute 들
    * operation: search / create / delete / list / rename / traverse

* Partition(=Logical Disk)

  * 하나의 (물리적) 디스크 안에 여러 파티션을 두는게 일반적
  * 여러 개의 디스크를 하나의 파티션으로 구성하기도 함
  * 각각의 파티션에 file system을 깔거나 swapping 등 다른 용도로 사용 가능

​        

### open ( )

> 시스템 콜의 일종 : I/O 처리 후 - 결과값 리턴(찾고자하는 최종 파일의 위치 리턴) - 배열에 저장하기에 이미 있다면 재탐색X
>
> (=마치 DP와 같음)
>
> root directory의 메타데이터는 미리 알려져있다.

* open("/a/b/c")

  * 목표 : 디스크로부터 파일 c의 메타데이터를 메모리로 가져옴

  <img src="CS_filesys.assets/image-20220301202853920.png" alt="image-20220301202853920" style="zoom:50%;" />

  * open 과정 : 이를 위해 directory path를 search

    * 루트 디렉토리 "/"를 open하고 그 안에서 파일 "a"의 위치 획득
    * 파일 "a"를 open하고 read해서 그 안 파일 "b"의 위치 획득
    * 파일 "b"를 open하고 read해서 그 안 파일 "c"의 위치 획득
    * 파일 "c" open

  * read 과정 : 역시 시스템콜 (제어권 : 운영체제) - 메모리에 캐싱되어있는지 확인

    * 파일의 내용을 메모리에 copy한 후 그 복사한 내용을 read를 호출한 프로세스에 리턴

      * **buffer caching**

      ​      

​      

### File Protection

> 파일을 보호하기 위한 권한 접근 방법은 3개가 있다.(rwx = read, write, execution)

<img src="CS_filesys.assets/image-20220301203739292.png" alt="image-20220301203739292" style="zoom:80%;" />

* Access control Matrix
  * 2차원 배열을 사용하면 정보량이 매우 많음 = 파일을 기준으로 리스트로 만들 수 있음

* Grouping (현대 체제)

  * 전체 user를 owner, group, public 의 세 그룹으로 구분
  * 각 파일에 대해 세 그룹의 접근 권한(rwx)을 3비트씩 표기
  * ex) [owner] rwx / [group] r__ / [other] r__

* Password

  * 파일마다 비밀번호를 둔다
  * 모든 접근 권한에 대해 하나의 password = all or nothing (모 아니면 도)

  * 접근 권한변 password : 암기 문제, 관리 문제

​         

### Mounting

* 서로 다른 파일 시스템에 접근할 수 있도록 하는 방식

<img src="CS_filesys.assets/image-20220301204756443.png" alt="image-20220301204756443" style="zoom:80%;" />

​         

### 파일 접근 방법(Access Method)

1. 순차 접근(sequential access)
   1. 카세트 테이프 방식처럼 접근 (a - b - c 가 있을 때 b를 반드시 거쳐야 c로 가능)
   2. 읽거나 쓰면 offset이 자동적으로 증가
2. 직접 접근(direct access, random access = 임의 접근)
   1. LP 레코드 판 방식처럼 접근 (제한 조건없이 접근 가능)
   2. 파일을 구성하는 레코드를 임의의 순서로 접근 가능



​        

​         

# 디스크 파일 할당 방법(3가지)

​           

## Contiguous Allocation(연속 할당)

> 하나의 파일이 디스크에 연속적으로 저장되는 방법

<img src="CS_filesys.assets/image-20220302180850322.png" alt="image-20220302180850322" style="zoom:67%;" />

* 장점
  * Fast I/O
    * 데이터의 연속성: 한번의 seek/rotation으로 많은 바이트가 transfer
    * Realtime file용: 이미 run 중이던 process의 swapping용
      * swapping에서는 효율보단 속도가 중요하기 때문
  * Direct access(=random access) 가능
* 단점
  * 외부조각이 생길 수 있다.(할당되지 않은 메모리 공간의 크기가 제각각)
  * file grow(파일의 크기가 커지는 것)이 어려움
    *  hole 발생: file grow를 미리 예측해서 할당한다면 낭비가 발생함

​     

​       

## Linked Allocation

<img src="CS_filesys.assets/image-20220302181503359.png" alt="image-20220302181503359" style="zoom: 67%;" />

* 장점
  * 외부조각X
* 단점
  * No random access: 처음 위치부터 접근해서 순차적으로 접근해야 원하는 정보에 도달
  * Reliability: 한 sector이 고장나면 많은 부분이 유실
  * Pointer를 위한 공간이 block의 일부가 되어 공간 효율성을 저하
    * 다음 데이터를 가르키는 좌표 저장에 공간 낭비
* 변형
  * FAT: File Allocation Table
    * 포인터를 별도의 위치에 보관해 reliability와 공간 효율성 문제 해결

​      

​       

## Indexed Allocation

> 블록 하나에 파일의 자료가 들어있는 인덱스 정보를 저장

<img src="CS_filesys.assets/image-20220302182210072.png" alt="image-20220302182210072" style="zoom:67%;" />

* 장점
  * 외부조각X
  * direct access
* 단점
  * 작은 파일인 경우 공간 낭비 (실제로 대부분이 작음)
  * 너무 큰 파일이면 하나의 블럭에 모두 저장X
    * linked scheme: 마지막 인덱스는 파일의 인덱스가 아닌 다음 인덱스 블록의 위치
    * Multilevel index: 하나의 인덱스가 또 다른 인덱스 블록을 가리킴 (paging에서 사용하던 기법과 비슷)

​         

​         

## UNIX 파일시스템의 구조

<img src="CS_filesys.assets/image-20220302182657210.png" alt="image-20220302182657210" style="zoom:67%;" />

<img src="CS_filesys.assets/image-20220302182817236.png" alt="image-20220302182817236" style="zoom:67%;" />

* Boot block : 파일 시스템의 공통적인 부분
* Super block : 현재 파일시스템을 관리하기 위한 블록, 어디가 빈 블록이고 데이터를 담고 있는지 등 저장
* Inode list : 파일 하나당 inode가 배분
  * indexed Allocation 방식: inode의 크기는 고정되어있다. 
    * 크기에 작은 순으로 direct blocks > single indirect > double indirect > triple indirect 

​         

## FAT File System

<img src="CS_filesys.assets/image-20220302183548792.png" alt="image-20220302183548792" style="zoom:67%;" />

* directory file에는 해당 파일마다 시작점만
  * FAT부분에 그 다음 번호들이 저장 = 직접 접근 가능

​         

​           

# Free-Space Management

​      

<img src="CS_filesys.assets/image-20220302184341759.png" alt="image-20220302184341759" style="zoom:67%;" />

​         <img src="CS_filesys.assets/image-20220302184739311.png" alt="image-20220302184739311" style="zoom:67%;" />

* Linked list: 직접 따라가봐야하기 때문에 연속적인 공간 찾기 어려움
* Grouping: 첫번째 블록이 인덱스 역할, 연속적인 공간 찾기 어려움
* Counting: 첫번째 빈블럭을 찾고 몇번째까지 빈블럭인지 표기

​        

​            

## Directory Implementation

<img src="CS_filesys.assets/image-20220302185121090.png" alt="image-20220302185121090" style="zoom:80%;" />

* Linear List: 구현은 간단하지만 폴더 찾는데 시간이 오래 걸린다.
* Hash Table: 해시함수를 적용 = 이름을 숫자화해서 검색이 빨라짐

<img src="CS_filesys.assets/image-20220302185806695.png" alt="image-20220302185806695" style="zoom:80%;" />

* 긴 이름의 파일
  * 어느정도 길이를 한정하고 마지막 부분에 포인터를 둬서 가리키는 부분을 적어주기

​       

### VFS, NFS

> 사용자가 파일에 접근하기 위해서 **시스템 콜**이 필수
>
> 바로 파일에 접근하는 것이 아니라 **VFS**에 접근 : 동일한 시스템콜 인터페이스를 통해 파일에 접근
>
> 어차피 파일에 접근하기 위해선 VFS에 접근해야하기 때문에 네트워크를 통해 다른 서버에 접근할 때에도 그 컴퓨터 내부에선 VFS 인터페이스로 접근해 파일을 가져온다.

<img src="CS_filesys.assets/image-20220302215619952.png" alt="image-20220302215619952" style="zoom: 67%;" />

​         

### Page Cache and Buffer Cache

> Page Cache는 page fault가 일어나지 않으면 (BLT의 작용은 99퍼센트 적중률) 기록이 남지 않기 때문에 clock 알고리즘을 사용해 하드웨어가 관여하도록 하고, Buffer Cache는 시스템 콜이 무조건 일어나기 때문에 기록이 무조건 남음으로 clock 알고리즘 말고도 LRU나 LFU의 사용이 자유롭다.

<img src="CS_filesys.assets/image-20220302220122534.png" alt="image-20220302220122534" style="zoom:67%;" />

* 최근에는 Unified Buffer Cache
  * 버퍼 캐시를 페이지 단위로 관리하고 같이 관리한다.
* Memory Mapped I/O
  * 파일 일정부분을 메모리 영역에 매핑: 메모리에 명령하는 것이 마치 파일에 명령하는 것으로 인식되게 함