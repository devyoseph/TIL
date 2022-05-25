# Vue Happy House

​             

### 1. 댓글 CRUD 실시간 반영하기

* 해당 View 파일에서는 computed를 이용해 vuex 내부 state 데이터 목록을 실시간 업데이트 한다.

  > 해당 View 파일에서 전체 조회하는 Actions를 실행하는 경우 비동기 통신이기 때문에 수정 중에 미리 값을 불러온다.
  > 그러므로 vuex 내부의 actions끼리 통신해서 비동기 통신이 끝난 후(then() 내부)에 조회를 하도록 해야한다.

  ```vue
  <script>
  import { mapActions, mapState } from "vuex";
  const replyStore = "replyStore";
  import ReplyItem from "@/components/header/item/ReplyItem.vue";
  import ReplyBar from "@/components/header/item/ReplyBar.vue";
  
  export default {
    name: "ReplyList",
    components: {
      ReplyItem,
      ReplyBar,
    },
    props: ["articleno"],
    computed: {
      ...mapState(replyStore, ["replies"]), // computed로 state 내부의 값을 실시간 업데이트
    },
    methods: {
      ...mapActions(replyStore, ["updateReplies"]),
    },
    created() {
      //댓글 초기화
      this.updateReplies(this.articleno);
    },
  };
  </script>
  ```

* 추가, 삭제, 갱신할 때 commit 뿐만 아니라 dispatch를 통해 갱신해주는 actions 내부 메서드를 발동시킨다.

  ```js
   deleteReply({ commit, dispatch }, reply) {
     // 삭제에는 id만 있으면 되는데 회원 정보 모두를 가져오는 이유
        http
          .delete(`board/reply/` + reply.id)
          .then((response) => {
            commit();
            commit("SET_REPLIES", response.data); 
            dispatch("updateReplies", reply.articleno);
          // 댓글의 경우 해당 글의 article.no가 필요하기 때문에 삭제하는 id값 외에 추가적인 데이터가 필요하다.
          })
          .catch((error) => {
            console.log(error);
          });
      },
    },
  ```

* 이렇게 비동기 통신이 끝난 후인 `then()`내부에서 다시 전체 조회(select문)를 하는 메서드를 실행하면 state 내부의 값이 바뀌며 이에 따라 computed는 재계산함으로 실시간 값을 반영해준다.

​             

### 2. 게시글 id 부여하기

* 게시글의 id를 Auto_Increment로 했을 때 만약 삭제한다면 다음 생성되는 글의 번호가 섞이며 참조무결성이 위협받는다.

* 이에 글의 id를 자동이 아닌 현재 id의 최대값 + 1을 조회해 부여하는 방식을 사용한다.

  ```xml
  <!-- 게시글 관련: board -->
  	<insert id="registerArticle" parameterType="BoardDto">
  
  		<selectKey keyProperty="articleno" resultType="int"
  			order="BEFORE">
  			select IFNULL(max(articleno)+1, 0) from board
  		</selectKey>
  
  		insert into board values (#{articleno}, #{userid}, #{username},
  		#{subject}, #{content}, now(), 0)
  
  	</insert>
  ```

* 이 때 한 개도 등록되어있지았다면 `null`이 발생하므로 여기서 1을 더해도 오류가 발생한다.

* 이를 방지하기 위해 `IFNULL`을 사용한다. 만약 null값이 발생하면 숫자가 없다는 뜻이므로 0의 값을 넣어준다.

​                

### 3. vuetify

```bash
vue add vuetify
```

* 이미 프로젝트가 진행 중일 때 라우터 구조가 바뀌면서 Home 라우터가 생성되고 App.vue 맨위에 템플릿이 생겨나 있다.
* 여러개의 컴포넌트를 사용하면 오류가 발생하는데 자세한 이유는 모르겠다(Prettier와의 충동)