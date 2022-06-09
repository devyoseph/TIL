# 8. Shell Script

> `.bashrc` 와 `.profile`  내부는 사용자가 로그아웃 하더라도 사라지지 않는다.
이를 이용해 alias 등 설정들을 저장할 수 있다.

실행문은 `(백틱) 내부에 넣는다.

`(( ))` 를 사용해 내부 연산을 할 수 있다.
> 

### 복습

**복습1**

```bash
$ df # 디스크 사용용량
$ df -h # 단위 표현

$ ll
$ du -sk .cache/ # .cache 차지 공간
$ du -sh .cache/ # 단위 표현

$ history | tail -5
```

**복습2**

```bash
$ vi .vimrc
```

```bash
set smartindent
set tabstop=4
set expandtab
set shiftwidth=4
```

```bash
:wq
$ cat .vimrc
```

# shell script

- #!/bin/sh 또는 #!/bin/bash(Linux면 되도록 이것을 사용)
- 실행권한: `chmod +x <name>`

**출력과 포멧팅**

```bash
$ echo "Hello Shell Script!"
$ printf "%s %s %d\n" aa bb 123

$ string="hello"
$ echo "${string} world" # $를 무조건 변수라고 인식하기 때문에 \(escaping)등을 활용
$ echo "$string world" # 붙이지만 않으면 인식 가능
```

**출력 실습**

- shell 내에서 “쌍따옴표"를 쓰지 않아도 문자열을 인식한다.

```bash
$ vi s1.sh
```

```bash
#!/bin/bash

echo "My name is David"

printf "Your name is %s\n" Jade

str="Hello "
echo ${str}World
```

```bash
:wq
```

```bash
$ bash s1.sh # bash 명령어로 실행
```

**표현식**

```bash
$ expr 1 + 2 # 띄어쓰기 주의: 1과 2의 연산값을 나타냄
$ echo `expr 1 + 2`

$ echo "$(( 5*2 ))" # 5와 2의 연산값을 나타냄
```

### 2) loop

- 1 ~ 100 loop
- 백틱(`) 사용에 주의

**loop 실습**

> loop 구문 구조
  1) for
  2) in: 뒤에 명령어, 숫자, range `{1..100}`
  2) do
  3) done;
> 

```bash
$ ls # ls로 보여지는 파일을 검색하고 그 목록을 가져오기

$ for i in `ls`; do echo $i; done # ls 명령어의 원소를 i에 담고 i를 출력
```

```bash
$ for i in 1 3 5; do echo $i; done
```

```bash
$ for i in {1..100}; do echo $i; done;
```

**loop 문제**

> 현재 폴더의 *.txt 파일들의 내용을 한번에 출력하는 스크립트를 작성하시오.
> 

```bash
$ echo "aaaaaaaaa" > a.txt
$ echo "bbbbbbbbb" > b.txt
```

```bash
$ for i in `ls *.txt`; do echo $i; cat $i; done;
```

**shell script**로 만들기

```bash
$ vi s2.sh
```

```bash
#!/bin/bash

for i in `ls *.txt`
do
	echo " =============== $i =================="
	cat $i
	echo " ====================================="
done
```

```bash
$ bash s2.sh # 실행
```

**실행권한부여**

```bash
$ for i in `ls *.sh`; do chmod +x $i; done # 전체 sh 파일에 실행 권한 부여
```

**구구단 출력**

```bash
$ vi gugu.sh
```

```bash
#!/bin/bash

for i in {2..9}
do
	for j in {1..9}
	do
		echo "$i * $j = $(( $i * $j ))"
	done
	echo "-------------------------"
done
```

```bash
:wq
```

```bash
$ chmod +x gugu.sh # 권한부여
$ ./gugu.sh # 실행
```

### 3) Variables

alias

- `.bashrc` 같은 공간에 저장해 컨테이너가 계속 기억하도록 한다.

```bash
$ alias s1='~/s1.sh'
$ s1 # 간단하게 별칭으로 실행: 그러나 로그아웃시 삭제
```

```bash
$ vi .bashrc # bashrc로 들어가 수정

:$
o
```

```bash
alias s1='~/s1.sh'
alias s2='~/s2.sh'

:wq
```

```bash
$ . .bashrc # 주의: 설정파일을 리로드해야 적용된다
```

**variables**

```bash
$ vi s3.sh
```

```bash
#!/bin/bash

## yy p 활용
echo "0=$0" # 첫번째 실행파일명
echo "1=$1" # 두번째 실행파일명
echo "#=$#" # 실행파일 개수
```

```bash
:w
:!bash s3.sh
```

**여러 파일 실행**

```bash
:!bash s3.sh s1 s2 # 3개 실행
```

![Untitled](8%20Shell%20Script%200a50e5ba44ba4774b208731e7754ccfb/Untitled.png)

**실습**

> 같이 실행할 때 다른 파일의 내용을 조회하는 쉘을 만드시오
> 

```bash
$ vi s4.sh
```

```bash
#!/bin/bash

cat $1 # s4.sh를 실행하고 뒤에 또 다른 파일을 실행한다면 뒤 파일을 불러와 cat으로 조회
```

```bash
:wq
```

```bash
bash s4.sh s1.sh # s4.sh 뒤에 오는 파일의 내용 조회(cat)
```

### 4) IF

- gt, eq, lt, ne, le, ge
- 파일: -f(존재유무), -r, -w, -x(권한들)

| gt | greater than | > |
| --- | --- | --- |
| eq | equal | == |
| lt | less than | < |
| ne | not equal | ≠ |
| le | less equal | ≤ |
| ge | greater equal | ≥ |
- if 구조
    - if [ ]
    - then
    - fi
    

**예시**

```bash
#!/bin/bash

MSG="empty"

if [ $# -gt 0 ]; then
	MSG="$1"
fi

echo $MSG
```

**실습**

- 사용법과 일치하지 않으면 경고문을 띄워준다

```bash
$ vi s5.sh
```

```bash
#!/bin/bash

if [ $# -eq 0 ]; then
        echo "Input the filename, please..." # 올바른 사용법 알려주기
        echo "usage) ./s4.sh <format-file> <data-file> <test-file>"
        exit 0 # 정상종료, 1 등 오류 코드를 내보낼 수 있다.
fi

cat $1
```

```bash
:wq
```

```bash
$ chmod +x s5.sh # 권한 부여
```

```bash
$ ./s5.sh # 실행
$ ./s5.sh s1.sh # cat 발동 
```

### 5) date

```bash
$ date
$ date +%Y-%m-%d %H:%M:%S
$ date +%Y-%m-%d --date=yesterday # 어제 날짜 옵션, 내일=tomorrow
$ date +%Y-%m-%d --date="2 day ago" # 이후: 2 day, 2 week
$ date +%Y-%m-%d --date="1 week ago"
```

**실습1**

```bash
$ vi s6.sh
```

```bash
#!/bin/bash
DATE=`date +%Y-%m-%d`
echo $DATE
```

```bash
:wq
```

```bash
$ chmod +x s6.sh # 권한부여
```

```bash
$ ./s6.sh
```

**실습2**

> 파일명을 입력받으면 오늘날짜(연월일).txt로 파일명 변경
> 

```bash
$ vi s6.sh
```

```bash
#!/bin/bash

if [ $# -eq 0 ]; then
        echo "Input the filename, please..." # 올바른 사용법 알려주기
        echo "usage) ./s6.sh <format-file>"
        exit 0 
fi

DATE=`date +%Y-%m-%d`
FN="${DATE}.txt"
echo "mv $1 $FN" : 처음엔 일단 출력 형태로 시도하고 성공 시 아래 구문을 적용
mv $1 $FN
```

```bash
:wq
```

```bash
$ echo "test for s6.sh" > test6.txt # 그냥 임시 파일 생성
```

```bash
$ ./s6.sh
$ ./s6.sh test6.txt # 적용하기
```

**실습3**

> 파일명을 2개 입력 받아 두 파일을 합친 후, 파일명을 `어제날짜.log`로 새롭게 만드시오.
> 

```bash
$ vi s6.sh
```

```bash
#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Input 2 files, please..." # 올바른 사용법 알려주기
    echo "usage) ./s6.sh <format-file>"
    exit 0
fi

DATE=`date +%Y-%m-%d --date=yesterday`
FN="${DATE}.log"

cat $1 > $FN
cat $2 > $FN
```

```bash
:wq
```

```bash
$ ./s6.sh aaa.txt b.txt # 실행
$ ll # 확인
```

### 6) Array

**선언**

```bash
$ declare -a arr
```

**예제**

```bash
$ vi s7.sh
```

```bash
#!/bin/bash

declare -a arr # 안써도 되는 구문
arr=("aaa" "bbb" "ccc" 123)

echo $arr # 첫번째 원소만 출력
echo ${arr[0]}
arr[4]="444444"
arr[8]="888888" # 들어갈 수 있나? = 8번째 인덱스에 잘 들어간다

len=${#arr[@]}
echo ${arr[@]} # 모든 원소 출력
echo "${#arr} : ${#arr[@]}" # 개수: 습관적으로 arr[@]을 쓰도록 한다. 

for a in ${arr[@]}
do
	echo $a
done
```

```bash
:wq
```

```bash
$ chmod +x s7.sh
$ ./s7.sh
```

### 7) Function

**예제**

```bash
$ vi s8.sh
```

```bash
#!/bin/bash

echo "$0 $#"

# 함수 내부에서 쓰이는 $는 parameter를 가르킨다 = 외부 $와 다르다
say_hello(){
	echo "Hello $@ by $2!! ($#)" # $#: 파라미터 개수
}

say_hello "Jade" "Jeon"
```

```bash
:wq
```

```bash
$ chmod +x s8.sh
$ ./s8.sh
```

### 8) IFS & AWK

> ls - al의 메모리 정보만 한 줄씩 나타내고 합을 나타내시오.
> 
- IFS: 문자열에 공백을 기준으로 잘라준다.
- AWK: 자른 문자열에서 선택해 가져온다.

**IFS**

- $IFS: 본래 존재하는 환경변수

```bash
$ vi s9.sh
```

```bash
#!/bin/bash

echo "IFS=${IFS}."

PRE_IFS=$IFS
IFS=" # 개행을 확실히 나타낼 것
"
 
for i in `ls -al`; do
	echo $i
	echo "${IFS}"
done

IFS=$PRE_IFS # 개행 초기화
```

**AWK**

- 한 줄 씩 받는다.
- 원하는 부분만 잘라서 가져올 수 있다.

```bash
$ ls -al | awk '{print $5}' # ls -al을 한 줄 씩 받아서 5번째만 호출

$ ls -al | awk '{print $9 " " $5}'
```

```bash

#!/bin/bash

echo "IFS=${IFS}."

PRE_IFS=$IFS
IFS=" # 개행을 확실히 나타낼 것
"
 
for i in `ls -al`; do
	echo $i | awk '{print $9 " " $5}' # 백틱이 아닌 작은 따옴표를 사용한다.
	echo "${IFS}"
done

IFS=$PRE_IFS # 초기화
```

**문제**

> /bin 디렉토리 아래에 존재하는 파일들의 이름과 크기를 한 개의 파일로 생성하시오.
(단, total 등은 제외)
그리고 메모리 사용의 합을 나타내어라
> 

**오답**

```bash
$ ll /bin | awk '{print $9 " " $4}' > practice9.txt # 오답: 맨 처음 줄을 예외처리
```

**정답**

```bash
$ vi practice9.sh # 만들기
```

```bash
#!/bin/bash

PRE_IFS=$IFS
IFS="
"
TOT=0

# 파일 생성: root 등에서 실행할 수 있으므로 권한 문제 발생
cd /home/dooo # 정확한 경로로 들어가 생성

FileName="bin_files.txt" # 파일 이름을 변수로 지정: 유지보수를 위해
touch $FileName

for i in `ls -al /bin`; do
    S=`echo $i | awk '{print $5}'`
    F=`echo $i | awk '{print $9}'`

    if [ "$F" == "." ] || [ "$F" == ".." ] || [ "$F" == "" ]; then
        continue
    fi
		# TOT=$(( $TOT + $S )): 문자열은 인식 불가
		TOT=`expr $TOT + $S` # 자동변환: expr은 자식 프로세스가 실행하기 때문에 자동변환 
		
    echo "$S $F" >> $FileName # 집어넣기
done
echo "Total Size is $TOT"

IFS=$PRE_IFS
```

```bash
:w
:!bash practice9.sh # 파일 생성

:!cat bin_files.txt # 확인
```