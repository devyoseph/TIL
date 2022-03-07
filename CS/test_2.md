1. 프로세스에서 다른 프로세스로 CPU 제어권이 넘어가는 과정을 자유롭게 설명해주세요

   1. 배당된 시간이 끝나면 타이머가 CPU에 인터럽트를 발생
   2. Running 중인 프로세스를 중단시키면 그 프로세스는 자식 프로세스를 차례차례 종료하면서 마지막에 자신을 종료시킴
      1. 현재까지의 수정된 내용을 code,stack, data에 기록 큐 맨뒤로 넘김
      2. 다음 큐에 존재하는 Ready 상태의 프로세스를 꺼내고 Run함

2. CPU 스케줄링의 SJF 방식의 장점과 단점, 해결방안

3. Multilevel queue

   1. Foreground = RR (80%)
   2. Background = FCFS (20%)
   3. 배분된 수행시간에 끝내지 못하면 하위큐로 넘어감

4. Race Condition: 프로세스들은 Share box를 공유하면서 발생

   1. Kernel 수행 중에 인터럽트(context switch) 발생: 다른 프로세스가 그 값을 바꿔버림(critical section)

      1. 근본적인 이유: 인터럽트 자체가 preemptive 하기 때문에

      2. 해결책1: 크리티컬 섹션의 접근은 하나의 프로세스에게만 허용(상호배제: Mutual Exclusion)

         1. Progress: critical section이 사용중이 아니면 들어갈 수 있도록 만들기
         2. Bounded Waiting: 요청한 이후 다른 프로세스들이 들어가는 횟수에 한계가 존재

         * Turn(과잉양보) , flag(과잉양보), Peterson(busy waiting-spin lock: while문으로 대기= 낭비)
         * Synchronization HardWare: 하드웨어적으로 처리 = lock을 걸어줌(atomic하게)
         * Semaphore: while문 방식에서 block and wake up 방식 (이름은 block이지만 suspend시켜서 큐에 넣는다)

5. Deadlock

   1. Bounded Buffer
   2. Reader-Writer
      1. 시간간격을 두고 접근 배분
   3. Dining-Philosophers Problem

6. 데드락 발생의 4가지 조건

   1. 상호배제
   2. No preemption
   3. Hold and wait
   4. circular wait

7. 데드락 해결 알고리즘: Banker's Algorithm(프로세스가 필요한 최대자원 고려)

   1. Detection and Recovery: 자유롭게 주되 데드락이 걸리면 프로세스를 전체 종료, 하나만 종료

8. 현대 데드락: DeadLock Ignorance

9. 메모리를 효율적으로 관리하는 방법? 가장 중요한요소는?

10. 주소바인딩

    1. compile time binding: 이후에도 똑같은 주소사용
    2. Load time binding: 로드할때마다 바뀌기 가능
    3. Runtime binding: 실행중에도 바뀌기 가능 =하드웨어적 지원필요

11. Dynamic linking: stub라는 작은 코드 사용

12. hole 관리 = compaction = 효율 낮음

13. page : valid invalid bit

14. TLB 단점?: associate register를 이용해 병렬적인 탐색

15. Segmentation: 의미단위로 자르기 때문에 크기로 정해진게 아니라서 크기를 저장하는 STLR(LENGTH) STBR(어디에 위치하는지 base)

16. FIFO / LRU, LFU

키워드 : preemptive / nonpreemptive, race Condition / critical section / Semaphore(추상화) - mutex / readcount / Monitor / Address Binding / Memory Management Unit (Hardware) / Dynamic **Loading=메모리에 올리는것** / swap = suspended / linking(라이브러리) / page table은 메모리 안에 있다 / **TLB** (translation looks aside buffer: 일종의 버퍼) / Demand Paging

​       

= page 교체

데드락: 프로세스가 서로 자원을 기다리면서 무한정 기다리는 상태

​         

>  **질문내용**
>
> 1. Paging 기법에서 TLB를 사용하는데 사용하는 이유, TLB의 단점은 무엇인지, 극복하는 방안으로는 무엇이 있는지
>
>    * TLB: 캐싱 기법을 사용해 메모리에 직접 접근하지 않고 자주 사용하는 페이지를 탐색, 일일히 수동으로 탐색해야하는데 이것을 극복하기 위해 associative register 사용
>
> 2. 주소바인딩 방식에 compile time binding, Load time binding, Runtime binding 이 있는데 간단히 설명해주실 수 있나요? (암기보다는 한계성 측면에서)
>
>    * complie time binding: absolute 한 주소
>    * Load time binding: Loader 책임 하에 로드할 때마다 주소 변경가능
>    * Runtime binding: 실행 중에도 주소 변경 가능
>
> 3. Non-contiguous 한 메모리 관리 방법 중에는 크게 Paging, Segmentation 방식으로 분류할 수 있는데 Segmentation이 Paging 기법과 비교한 장점과 단점을 설명해주세요.
>
>    * 문맥 단위로 잘라서 메모리에 배분, 내부조각X
>
>    * 구현이 복잡하고 page와 다르게 의미단위로 저장하기 때문에 길이 정보도 따로 저장한다.
>
>      