# 병행 제어

​        

### Real-Time Scheduling

* Hard real-time systems
  * 정해진 시간 안에 반드시 끝내도록 스케줄링
* Soft real-time computing
  * 일반 프로세스의 비해 높은 priority를 갖도록 함

​      

### Thread Scheduling

* Local Scheduling
  * User level thread의 경우 사용자 수준의 thread에 의해 어떤 thread를 스케줄할지 결정
* Global Scheduling
  * Kernel level thread의 경우 일반 프로세스와 마찬가지로 커널의 단기 스케줄러가 어떤 thread를 스케줄할지 결정

​         

### Algorithm Evaluation

* Queueing models
  * 확률 분포로 주어지는 arrival rate와 service rate 등을 통해  각종 performance index값을 계산
* Implementation(구현) & Measurement(성능 측정)
  * 실제 시스템에 알고리즘을 구현하여 실제 작업(workload)에 대해서 성능을 측정 비교
* Simulation(모의 실험)
  * 알고리즘을 모의 프로그램으로 작성 후 **trace**(input이 되는 데이터)를 입력으로 하여 결과 비교

​        

### 데이터의 접근

>  연산(Execution)하는 공간과 데이터를 저장(Storage)하는 공간이 각각 존재한다.

| E-box           | S-box                   |
| --------------- | ----------------------- |
| (1) CPU         | Memory                  |
| (2) 컴퓨터 내부 | 디스크                  |
| (3) 프로세스    | 그 프로세스의 주소 공간 |

​       

#### Multiprocessor system의 Race Condition

> 하나의 S-box를 가지고 여러 E-box가 공유하는 경우 Race Condition의 가능성이 있음

* 공유 메모리를 사용하는 프로세스들, 커널 내부 데이터를 접근하는 루틴들 간
  * ex) 커널모드 수행 중 인터럽트로 커널모드 다른 루틴 수행시

​          

#### Race Condition

1. 안 생기는 이유
   * 프로세스의 접근을 하기 위해서 주소 공간이 구분 되기 때문에 작업이 겹칠 수 없다.
2. 생기는 이유
   * 프로세스가 서로 공간 공유(공유 메모리)할 때 한 쪽이 인터럽트에 걸린 경우(blocked)
   * 커널 또한 공유 공간이다.
     * 시스템 콜로 커널을 불렀지만 타이머에 의해 인터럽트가 걸린다면 preempt 당하고 변수는 변한 상태 

​       

### 해결방법

* 무작정 공유 데이터에 lock을 거는 것이 아니라 lock까지 고려해서 효율적인 프로세스를 짜야한다.
  * Process Synchronization 문제 해결 = concurrent process(동시 프로세스)의 동기화 필요

​       

#### Critical-Section

* 각 프로세스가 공통적으로 수정하기 원하는 코드 부분

  ```bash
  entry section
  X = X + 1 (critical section)
  exit section
  ```

  > critical section 부분 주변에 위처럼 lock을 거는 방식으로 제어해준다.