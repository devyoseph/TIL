# 입출력 시스템

## 디스크의 구조

* 트랙(Track): 하나하나의 원판(동심원)
* 섹터(sector): 저장 최소 단위
  * cylinder: 상대적으로 동심원상 같은 위치에 있는 섹터들
* 헤드(head): 모든 헤드들은 각각 움직이는 것이 아니라 같이 움직인다.

<img src="CS_IO.assets/image-20220305023023773.png" alt="image-20220305023023773" style="zoom:67%;" />

* 디스크 내부 = 디스크 컨트롤러: 물리적 위치를 파악하는 역할 (섹터의 위치) - header와 trailer 이용

  * 섹터 0: 최외곽 실린더의 첫 트랙의 첫번째 섹터(**부팅을 위해 존재**)

* 디스크 외부(Host) = CPU: 물리적인 위치가 아닌 논리적인 블록(logical block)을 통한 접근

  <img src="CS_IO.assets/image-20220305023631810.png" alt="image-20220305023631810" style="zoom:67%;" />

​        

​          

## Disk Management

* physical formatting(Low-level formatting) **[물리]**

  * 디스크 컨트롤러가 읽고 쓸 수 있도록 섹터들로 나누는 과정
  * **각 섹터의 구성**: header + 실제 data(보통 521bytes) + trailer
  * header+trailer = sector number, ECC(Error-Correcting Code, **원래 데이터 축약한 코드=512바이트 데이터를 읽을 때 그 코드를 다시 축약해 비교하고 오류인 것을 탐지**) 정보저장, disk controller가 직접 접근/운영

* Partitioning **[논리 1단계]**

  * 디스크를 하나 이상의 실린더 그룹으로 나누는 과정
  * OS는 이것을 독립적인 disk로 취급(logical disk)

* Logical formatting **[논리 2단계]**

  * **파일 시스템을 만드는 것**
  * FAT, inode, free space 등의 구조

* Booting **[전원을 켰을 때]**

  > 메모리는 DRAM으로 휘발성이지만 그 옆에 비휘발성인 ROM이 붙어있다.
  >
  > ROM에는 디스크 0번 섹터에 있는 내용을 올리고 기계어를 실행하라는 명령어가 있다.
  >
  > * 0번 섹터에는 디스크에서 OS의 위치를 찾고 메모리에 올리라는 명령어가 있다.

  * ROM에 있는 "small bootstrap loader" 실행
  * sector 0을 load = full Bootstrap loader program
  * OS를 디스크에서 load하여 실행

​          

​              

## Disk Scheduling

<img src="CS_IO.assets/image-20220305025420113.png" alt="image-20220305025420113" style="zoom:67%;" />

* Seek Time > Rotational latency(Seek time의 10분의 1) > Transfer time(굉장히 작은 시간)
  * Seek Time을 줄이는 것이 핵심이다: Seek time = Seek distance
* Disk bandwidth (대역폭, 처리량)

​        

​        

## Disk Scheduling Algorithm

​      

### 1. FCFS(First Come First Served)

### 2. SSTF(Shortest Seek Time First)

* starvation 문제

​        

## 3. SCAN

> 디스크 스케줄링의 대표적인 방식
>
> * disk arm이 디스크의 한쪽 끝에서 다른쪽 끝으로 이동하며 가는 길목에 있는 모든 요청을 처리한다.
> * 다른 한쪽 끝에 도달하면 역방향으로 이동하며 위와 같은 방식으로 길목의 요청들을 처리한다.
>   * **문제점**: 실린더의 현재 위치에 따라 대기 시간이 영향을 받는다(편차 발생).

​       

### 3-1. C-SCAN

* SCAN의 방식에서 문제점을 개선

  * **다른쪽 끝에 도달했으면 요청을 처리하지 않고 곧바로 출발점으로 다시 이동**

    * 균일한 대기 시간 제공

      <img src="CS_IO.assets/image-20220305030918159.png" alt="image-20220305030918159" style="zoom:50%;" />     

  * 어쨋든 SCAN 종류기 때문에 199 끝까지 찍고 되돌아 오는 모습을 확인할 수 있다.

  ​            

### 3-2. N-SCAN

* SCAN의 방식 + 이미(방금) 지난 곳에 생긴 요청은 다시 턴을 할 때 처리(service)

​       

### 3-3. LOOK and C-LOOK

* SCAN은 한 쪽 **끝**(0)에서 다른 쪽 **끝**(100)으로 이동하는 알고리즘이다.
* LOOK 종류는 헤드가 진행 중이다가 그 방향에 더 이상 요청이 없으면 반대 반향으로 이동하는 알고리즘이다.

<img src="CS_IO.assets/image-20220305031455618.png" alt="image-20220305031455618" style="zoom:67%;" />

* Look 방식은 SCAN과 달리 끝 점을 찍지 않고 돌아갈 수 있다.

​         

### 디스크 스케줄링 알고리즘의 결정

![image-20220305031644578](CS_IO.assets/image-20220305031644578.png)

* 교체 가능하도록 묘둘화할 것

​       

​        

## Swap-space Management

> 컴퓨터 전원이 나가더라도 존재하지만 어차피 사라질 정보이므로 저장 방식이 기존과 다르다.

<img src="CS_IO.assets/image-20220305031745717.png" alt="image-20220305031745717" style="zoom:80%;" />

* **block 크기나 저장 방식이 일반 파일시스템과 다르다.**
  * 헤드 이용의 최소화(Seek time): 속도가 중요하다.

​       

​       

## RAID

* **성능(병렬적 처리) + 신뢰성 향상**

* 완전 중복~ 최소한의 중복까지 버전이 존재한다.
  * Parity: 축약 정보(마지막 디스크에는 나머지 3개의 디스크 내용을 축약해 저장하는 방식)
    * 다른 디스크가 손상됐을 때 parity와 다른 디스크의 내용을 이용해 복원 가능

<img src="CS_IO.assets/image-20220305032052710.png" alt="image-20220305032052710" style="zoom:67%;" />

​         

​                              

## UNIX 파일 시스템

<img src="CS_IO.assets/image-20220305032729538.png" alt="image-20220305032729538" style="zoom:80%;" />

* inode 블럭 하나에 inode 여러 개가 들어간다.

  <img src="CS_IO.assets/image-20220305032751973.png" alt="image-20220305032751973" style="zoom:80%;" />

​         

## 파일시스템의 변천사

<img src="CS_IO.assets/image-20220305032912353.png" alt="image-20220305032912353" style="zoom:80%;" />

​            

## Ext2 : 블록의 그룹화

* inode 가 오리지널과 별로 다른점은 없다.
  * Direct : 12개
  * Indirect : 3개 (single, double, triple 하나씩 배분)

<img src="CS_IO.assets/image-20220305032942832.png" alt="image-20220305032942832" style="zoom:80%;" />

* 블록의 그룹화

​	<img src="CS_IO.assets/image-20220305033213497.png" alt="image-20220305033213497" style="zoom:80%;" />

* 만약 기존 유닉스 파일시스템처럼 i-node와 data block을 따로 구분하면 디스크의 헤드의 움직임이 매우 커진다.

  * 이유: Meta 정보 확인 후 - 실제 데이터를 탐색하므로

  <img src="CS_IO.assets/image-20220305033846569.png" alt="image-20220305033846569" style="zoom:67%;" />

* 해결점: 블록을 그룹으로 나눠서  각각의 그룹 안에 Super + Inode + Data가 모두 존재한다.

  * Super Block은 중복 저장되는 것
  * **그룹 디스크립터(Group Descripter)**
    * 각각을 쪼개어 저장했기 때문에 그룹마다 다시 시작 위치를 저장해주어야 한다.
      * 데이터 블록 비트맵의 시작 위치 / 아이노드 시작 위치 / 첫번째 아이노드 시작 주소 / 가용 아이노드 수
  * 비트맵 사용: 빈 공간을 표시하기 위해 배열 (0과 1로 이루어짐)을 사용
    * 데이터 블록 비트맵
    * 아이노드 비트맵

​       

​       

## Ext4 : 저널링

* Ext2 의 블록 그룹구조는 거의 유사하다.

  <img src="CS_IO.assets/image-20220305034254622.png" alt="image-20220305034254622" style="zoom:67%;" />

* 메모리의 버퍼캐시에 있는 내용이 일부분만 전달되어 파일시스템에 저장된 상태로 전원OFF
  * 시스템 Crash 발생
  * 디스크를 깨지게 하는 중간 데이터가 없도록 설계

​        

#### 저널링

<img src="CS_IO.assets/image-20220305034724157.png" alt="image-20220305034724157" style="zoom:80%;" />

* 저널영역: 파일시스템과 다른 **별도의 영역**을 할당
  * 온전히 옴겨졌다면 표시를 해놓고(Checkpointing) 표시가 없다면 그 데이터를 날린다.

​         

### Ext4 저널링 방법 2가지

1. 메타데이터만 저널링: 메타데이터만 저널영역(빨간색)에 위치했다가 옮긴다
   * 메타데이터는 안전: 파일 시스템 구조 자체가 깨지는 것만 방지
   * 각각의 데이터는 저널링X : 각각의 일반 데이터는 깨져서 보일 수 있다.

<img src="CS_IO.assets/image-20220305035147241.png" alt="image-20220305035147241" style="zoom:67%;" />

2. 메타데이터와 일반데이터 모두 저널 영역
   * 데이터가 훼손되지 않는다는 것은 아니다, 반드시 최신 정보로 업데이트 되는 것도 보장하는 것은 아니다.
   * 다만 **의미단위로 중간 영역의 데이터는 존재하지 않는다.**

​         

<img src="CS_IO.assets/image-20220305035514875.png" alt="image-20220305035514875" style="zoom:80%;" />

​          

## LRFU 알고리즘 = LFU + LRU

<img src="CS_IO.assets/image-20220305035542468.png" alt="image-20220305035542468" style="zoom:80%;" />

* LFU : 참조된 횟수만큼 **덧셈**으로 더해줌
* LRU : 최근 참조를 **지수승**으로 반영
  * p(로)가 1보다 작은 수라면 감소함수 형태이다.

​       

* 단점

  * Space overhead: 모든 참조횟수를 기록하는 것에 오버헤드가 크지 않은가?
  * Time overhead: 최소 logN 안에 판단해주어야 하는데 위 방법으로는 어렵다.

* 개선

  * Space Complexity
    * 현재 t1시간과 이전 t2시간의 Value만을 이용해 그 시간의 차이(t1-t2)를 지수승으로 반영해 곱한다. 

  <img src="CS_IO.assets/image-20220305040240963.png" alt="image-20220305040240963" style="zoom:67%;" />

  * Time Complexity
    * a와 b의 가치가 이미 결정된 경우 아무리 시간이 지나도 둘의 대소 관계는 변하지 않는다.
  * 힙(Heap) 이용
    * 위 두 개를 종합해 재사용된 프로세스만 저장된 값에 [p(로)의 지수승]과 곱해 다시 정렬을 하면된다.
    * 다른 재사용되지 않는 프로세스는 시간이 지나도 그 상하관계는 변하지 않는다.
    * O(logN)
  * 효율
    * LRU와 LFU보다 효율이 개선된다.