# 가상 메모리

> 물리 메모리의 주소변환 = OS가 관여
>
> **Vitual Memory 기법은 전적으로 OS가 관여**

### TLB MISS

* 페이지 구간을 약 128개 가지고 있음(4MB * 100 = 약 400MB)
* TLB miss의 경우 **Exception** handler가 도와주어야 하기에 오버헤드가 매우 크다.
  * TLB의 구조 : `fully associative`
  * TLB Miss는 Exception의 한 종류이기에 명령문을 100줄이상 수행한다.
    * 보통 Cache 미스는 하드웨어가 해주어 오버헤드가 TLB Miss 보다 작다.
  * TLB를 first-leve, second level로 나눠서 관리한다. (I-TLB, D-TLB : first-level)
  * Exception 이후 Page Work를 수행한다(페이지를 통한 인덱스 접근).

​        

​            

## Demand Paging

> 메모리 관리를 페이징 기법을 사용하는 것으로 가정한다.
>
> 실제로 대부분의 시스템은 페이징 기법을 사용한다.
>
> 실제 물리 공간인 디스크에서 메모리로 올리는 작업은 매우 느리다(I/O)

* 요구 페이징(Demanding Paging) : 요청이 있으면 그 페이지를 메모리에 올린다.
  * 페이지 테이블에서 엔트리에 invalid = 물리적 메모리에 올라와 있지 않은 페이지
  * 만약 invalid 상태의 공간이라면? : 디스크 -> 메모리 [I/O 작업, 사용자 프로세스가 직접 불가]

*  장점

  * I/O 양의 감소 : 프로세스 내 빈번히 사용하는 부분은 일부기에 요구한 페이지만 올려놓는 것은 효율적
  * 물리 메모리 사용 감소 : 더 많은 프로세스가 메모리에 올라갈 수 있다.
  * 응답 시간의 감소

* 효율

  * 페이지 폴트의 빈도에 따라 결정 : 0(페이지 폴트 횟수 = 0) ~ 1(모든 요청이 페이지 폴트 발생)

    * 실제로는 거의 발생X

    ​      

### Page Fault

> 프로그램이 자신의 주소 공간에는 존재하나 시스템의 RAM에는 실제로 없는 경우 발생

* 페이지 폴트 트랩(trap): CPU가 MMU에게 가상 메모리 주소를 요청 -> 해당 페이지 테이블에 invalid 발견 -> MMU는 CPU를 인터럽트(page fault trap) -> OS의 page fault handler 작동
* **Page fault handler의 처리 순서**
  * 잘못된 요청인가? : 프로세스가 실행하지 않는 주소(address 오류)인 경우 -> abort
  * 잘못된 요청이 아니라면?
    * 메모리가 비어있는지 확인 (**Free Frame = 빈 공간**)
      * **Page replacement** : 꽉 차있다면 하나를 내쫓는다 (Memory -> Swap)
      * **Replacement Algorithm** 
    * 디스크 -> 메모리로 올림 (느린 작업: I/O작업)
    * I/O 작업이 마칠 때까지 프로세스는 blocked(다시 큐??)
    * CPU 사용권은 다른 프로세스로 이동
    * I/O작업이 수행 완료되고(CPU에게 인터럽트?) 페이지를 valid로 수정
    * 프로세스가 다시 CPU를 잡고 running

​          

### Replacement 알고리즘

​       

#### 1) Optimal Algorithm

* MIN(OPT) : 가장 먼 미래에 참조되는 page를 replace
  * 미래의 참조 조사: Offline algorithm 이라고도 함 = 온라인에서는 사실상 사용 불가
* 아무리 좋은 알고리즘을 만들어도 이보다 좋게 만들 수 없다
  * 다른 알고리즘 성능에 대한 upper bound 제공: 최적 알고리즘이 곧 기준이 됨
    * Belady's optimal algorithm, MIN, OPT 등으로 불림

​        

#### 2) FIFO

* 먼저 들어온 것을 내쫓는다
* **FIFO Anomaly** : 메모리 크기를 늘려주어도 성능이 더 나빠지는 상황이 발생

​         

#### 3) LRU(Least Recently Used) Algorithm

* 제일 오래된 것을 지운다 = 최근에 사용된 것이 더 많이 사용될 것이라 판단
* 가장 많이 사용된다
* O(1) 복잡도 : 한 줄의 배열: 현재 사용하는 프로세스가 맨 아래 가지로 감

​        

#### 4) LFU(Least Frequently Used) Algorithm

* 가장 덜 빈번하게 사용된 것을 지운다
* 장기적인 시간 규모를 보기에 page의 인기도를 좀 더 정확하게 반영가능
* 단점 : 참조시점의 최근성 반영X - 최근에 많이 사용되더라도 인식을 못함
* LRU보다 구현이 복잡
* O(n) 복잡도 : 최소 힙(Heap): 현재 사용하는 프로세스를 찾고(n) 재연산

​        

#### 5) Clock Algorithm

<img src="CS_vm.assets/image-20220226175217735.png" alt="image-20220226175217735" style="zoom:67%;" />

* 시계 바늘이 이동하면서 동작하는 방식
  * Second chance Algorithm: 기회를 한 번 더 준다
  * NRU Algorithm(Not Recently Used): 최근에 사용되지 않은 알고리즘을 쫓아냄
* 페이징 시스템에서 쓸 수 있는 알고리즘
* LRU의 근사 알고리즘
* **작동방식** : Circular Linked List (원형 큐)
  * reference bit를 이용해 프로세스가 최근에 1번 이상 참조되었는지 판단
    * 이 외 modified bit 사용(dirty bit) : 내보낼때 수정사항을 변경해서 내보낼 것인지 판단 척도
  * 하드웨어: CPU가 해당 페이지를 사용하면 reference bit이 1로 변경 (페이지가 참조됨)
  * 운영체제: 시계 바늘을 돌리면서 이미 1이면 0으로 세팅, 다음 시계 바늘로 이동
  * 0인 것을 찾으면 그 페이지를 내보내고 CPU가 요청한 페이지로 교체
    * Modified bit에 따라 최근에 변경됐는지 확인하고 디스크로 보내기전 변경사항 저장(I/O 장치 이용)

​        

​         

## Page Frame의 Allocation

* 빈번히 사용하는 페이지만 올려놓을 수 있다면 프로세스마다 얼만큼씩 할당해주어야 하는가?
* 어떤 프로세스 내에 자주 사용되는 부분이 페이지로 따지면 3개가 있는데 이 프로세스에 2개만 할당한다면 페이지 폴트가 자주 발생할 것이다.

​       

### Allocation의 종류

* Equal allocation : 모든 프로세스에게 똑같은 개수 할당
* Proportional allocation : 프로세스의 크기에 비례해 할당
* Priority allocation : 프로세스의 우선순위에 따라 할당

​       

### Global replacement

* LRU, LFU 같은 교체 알고리즘에 의해 알아서 어느 정도 할당이 되는 효과
* 다른 프로그램의 페이지를 내쫓는 방법

​     

### Local replacement

* 자기 자신한테 할당된 페이지를 쫓아내는 방법
* 여기서도 LRU, LFU를 적용 가능

​       

### Thrashing

* 페이지 폴트가 자주 일어나는 상황

<img src="CS_vm.assets/image-20220226181205588.png" alt="image-20220226181205588" style="zoom:67%;" />

* x 축은 지금 메모리에 올라와 있는 프로그램 개수
* y 축은 CPU 사용률
* 프로세스가 너무 적으면 CPU가 놀아서 CPU 사용량이 낮음
* 프로세스가 너무 많으면 페이지 배분이 너무 적어 page fault rate이 높아지고 CPU의 통제권이 자주 OS로 넘어감
  * 최악의 경우 CPU는 MPD(Multiprogramming degree)를 높혀야 한다고 판단해서 프로세스를 더 추가한다
    * 처리율이 낮아짐
* **Working-Set Algorithm, PFF Algorithm**
  * 쓰레싱을 막기 위해 동시 실행 프로세스의 수(degree of multiprogramming)을 조절해주어야 함.
    * 이 때 사용되는 알고리즘이 Working-Set, PFF 알고리즘

​            

### 가상 메모리를 사용하는 이유

> 프로세스 전체가 메모리에 올라오지 않아도 프로그램을 실행할 수 있도록 한다.
>
> 프로세스를 쪼개서 작은 바구니에 필요한 부분만 담는 것이다.
>
> 즉 프로그램 원래 물리 메모리보다 적은 메모리를 사용해 프로그램을 실행할 수 있다.

* 물리 메모리 = 한정성, 가상 메모리 = 더 큰 공간 활용
* 메모리 할당과 관리가 효율적: 물리적으로 연속적이지 않지만 가상 메모리 상에서는 연속적으로 사용 가능
* 보안성, 안정성 : 물리 메모리가 아닌 자신만의 공간이 배정되기에 다른 메모리 공간에 침입하지 못한다.
* 스왑 디스크 : 메모리의 페이지를 임시적으로 저장함으로 메모리를 좀 더 효율적으로 관리