### CLI**(Command Line Interface)

```markdown
$ cd ..
>이전 디렉토리로 이동: change directory

$ cd ~
>Home 디렉토리로 이동

$ cd /
> 루트 디렉토리로 이동 ex) Window C드라이브
```

```markdown
$ ~/ssafy7
> home 디렉토리의 ssafy7 폴더로 이동
```

### **경로**

절대 경로: 어떤 위치에서도 접근할 수 있는 경로(모든 경로 직접 작성)

```powershell
/Users/abcd/abcdef
```

상대 경로: 현재 위치를 기준으로 계산된 상대적 경로

```markdown
$ ./
> .은 현재 위치를 의미함

$ ../
> ..은 상위 폴더로 이동
```
경로 확인

```markdown
$ pwd
```

## 터미널 명령어

**파일 생성 명령어**

```bash
$ touch 파일명
```

**폴더 생성 명령어**

```bash
$ mkdir 폴더명
```

**현대 위치에서 폴더/파일 보기**

```bash
$ ls
//폴더 탐색: list segments
$ ls -a

$ ls -al
```

**파일/폴더 이동하기**

```markdown
$ mv
> 폴더, 파일을 다른 위치로 이동하거나 이름을 변경할 때 사용

$ mv 파일명 이동하는위치

$ mv 파일/폴더명 변경할이름
> 해당 이름의 폴더가 없으면 이름이 변경된다
```

**파일/폴더 삭제**

```markdown
$ rm 삭제하려는파일명
> 폴더명을 넣으면 오류가 발생한다

$ rm -r 삭제하려는폴더명
> recursive 옵션을 입력

$ rm -rf 폴더/파일명
> rf: 강제삭제
```

**파일/폴더 열기**

```markdown
$ open 파일명
> Mac

$ start 파일명
> Window
```

위 명령문은 잘 사용하지 않고 아래 코드 사용

```bash
$ code .
```

**꿀 같은 단축키**

```markdown
위 아래 방향키 <!--과거 작성한 이력 조회-->
tab 키 1번  <!--자동 완성-->
tab 키 2번 <!--가능한 경우의 명령어 보이기-->
ctrl + l  <!--화면을 깔끔하게 만들어주는 단축키(기록 유지)-->
ctrl + insert  <!--복사-->
shift + insert <!--붙여넣기-->
```

### **예제**

```markdown
$ touch '###DONT TOUCH ME###' 
> 작은 따옴표 사용
```

