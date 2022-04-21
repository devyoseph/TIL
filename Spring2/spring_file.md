# MVC / FileUpload

> File Upload를 위해서는
> Pom.xml에 **commons-fileupload library**를 추가해준다.
>
> https://mvnrepository.com/artifact/commons-fileupload/commons-fileupload
>
> ```xml
> <!-- https://mvnrepository.com/artifact/commons-fileupload/commons-fileupload -->
> <dependency>
>     <groupId>commons-fileupload</groupId>
>     <artifactId>commons-fileupload</artifactId>
>     <version>1.3.3</version>
> </dependency>
> ```
>
> ​        

​            

## 1. FileUpload

> xml 단계에서도 설정해주어야하지만 jsp/html 단계에서도 form 태그의 속성값을 설정해주어야 한다.

​          

#### servlet-context.xml

* property
  * maxUploadSize: 최대 업로드 가능한 파일의 바이트 크기
  * maxInMemorySize: 디스크에 임시 파일을 생성하기 전에 메모리에 보관할 수 있는 최대 바이트 크기

```xml
<beans:bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
	<beans:property name="defaultEncoding" value="UTF-8"/>
  <beans:property name="maxUploadSize" value="52428800"/> <!--50MB-->
  <beans:property name="maxInMemorySize" value="1048576"/> <!--1MB-->
</beans:bean>
```

​             

#### form 태그 속성

* **enctype: 필수설정**, input의 type `file`, multiple은 한 번에 여러개 올리게 해준다.

  ```jsp
  <form id="writeform" method="post" enctype="multipart/form-data" action="">
    
    <input type="file" class="form-control" name="upfile" multiple="multiple">
    
  </form>
  ```

​           

### 실습 예제1

* GuestBookDto

  ```java
  public class GuestBookDto {
  	private int articleNo;
  	private String userId;
  	private String userName;
  	private String subject;
  	private String content;
  	private String regTime;
  	private List<FileInfoDto> fileInfos; //파일에 대한 정보를 담은 Arraylist
    
    ...
  }
  ```

* FileInfoDto.java

  ```java
  public class FileInfoDto {
  	
    //데이터베이스에는 파일 자체를 저장하는 것이 아니라 pc에 일단 저장하고 그 저장한 곳의 폴더이름과 그곳의 경로를 저장해야한다.
  	private String saveFolder; // 저장폴더
  	private String originFile; // 원본 파일
  	private String saveFile; // 저장 폴더
  
   ...
  }
  ```

* GuesstBookController.java

  ```java
  @Controller
  @RequestMapping("/guestbook")
  public class GuestBookController {
  
  	private static final Logger logger = LoggerFactory.getLogger(GuestBookController.class);
  
  	@Autowired
  	private ServletContext servletContext;
  	
  	@Autowired
  	private GuestBookService guestBookService;
  
  	@GetMapping("/register")
  	public String register() {
  		return "guestbook/write";
  	}
  
  	@PostMapping("/register") //  guestbook/register URL로 들어오면 upfile 파라미터를 잡아서 files에 넣는다.
  	public String register(GuestBookDto guestBookDto, @RequestParam("upfile") MultipartFile[] files, Model model,
  			HttpSession session, RedirectAttributes redirectAttributes)
      throws Exception { //제목, 내용 = GuestBookDto로 들어감, 파일 = upfile로 받음
  		MemberDto memberDto = (MemberDto) session.getAttribute("userinfo");
  		guestBookDto.setUserId(memberDto.getUserId());
  
  //		FileUpload 관련 설정.
  		
      logger.debug("MultipartFile.isEmpty : {}", files[0].isEmpty());
  		if (!files[0].isEmpty()) {
  			String realPath = servletContext.getRealPath("/upload");
        // upload하는 실제 경로를 얻어오는 것: C
  
        //String realPath = servletContext.getRealPath("/resources/img");
  			
        String today = new SimpleDateFormat("yyMMdd").format(new Date());
  			String saveFolder = realPath + File.separator + today;
  			//저장할 폴더명을 오늘 날짜를 붙여서 만든다.
        
        logger.debug("저장 폴더 : {}", saveFolder);
  			File folder = new File(saveFolder);
  			if (!folder.exists()) //파일을 만든적이 없다면
  				folder.mkdirs();
  			List<FileInfoDto> fileInfos = new ArrayList<FileInfoDto>();
  			for (MultipartFile mfile : files) {
  				FileInfoDto fileInfoDto = new FileInfoDto();
  				String originalFileName = mfile.getOriginalFilename();
  				if (!originalFileName.isEmpty()) {
  					String saveFileName = UUID.randomUUID().toString()
  							+ originalFileName.substring(originalFileName.lastIndexOf('.'));
  					fileInfoDto.setSaveFolder(today);
  					fileInfoDto.setOriginFile(originalFileName);
  					fileInfoDto.setSaveFile(saveFileName);
  					logger.debug("원본 파일 이름 : {}, 실제 저장 파일 이름 : {}", mfile.getOriginalFilename(), saveFileName);
  					mfile.transferTo(new File(folder, saveFileName)); //중요!!
  				}
  				fileInfos.add(fileInfoDto);
  			}
  			guestBookDto.setFileInfos(fileInfos);
  		}
  
  		guestBookService.registerArticle(guestBookDto);
  		redirectAttributes.addAttribute("pg", 1);
  		redirectAttributes.addAttribute("key", "");
  		redirectAttributes.addAttribute("word", "");
  		redirectAttributes.addFlashAttribute("msg", "글작성 성공!!!");
  		return "redirect:/guestbook/list";
  //		return "redirect:/guestbook/list?pg=1&key=&word=";
  	}
  ```

* GuestBookServiceImpl.java: Dao가 사라진다

  * @Transactional: My-Batis: Dao를 삭제해도 된다.

    ```java
    @Override
    @Transactional
    public void writeArticle(GuestBookDto guestBookDto) throws Exception {
    	if(guestBookDto.getSubject() == null || guestBookDto.getContent() == null){
    		throws new Exception();
      }
      ...
    }
    ```

    

* GuestBookDaoImpl

  ```java
  @Override
  	public void registerArticle(GuestBookDto guestBookDto) throws Exception {
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs = null;
  		try {
  			conn = dataSource.getConnection();
  			conn.setAutoCommit(false); // CRUD에서 AutoCommit이 true기 때문에 false로 하고 작업한다.
  ```

  * 이후 작업이 잘 되었다면

    ```java
    conn.commit();
    ```

  * 잘 안되었다면

    ```java
    conn.rollback();
    ```

    ​          

* guestbook.xml
  * Dao를 만들지 않아도 이제는 xml을 통해 DB와 연결할 수 있다.



### 실습 예제2         

* 예제1에서는 `ServletContext` 타입으로 생성했지만

```java
@Autowired
private ServletContext servletContext;
```

* 예제 2에서는 `ResourceLoader` 를 사용한다.

```java
@Autowired
private ResourceLoader resLoader;
```

​             

#### 메서드 작성

* MultipartFile을 배열로 받지 않고 단일 객체로 받는 케이스도 있다.
* ServletContext을 쓰지 않고 ResourceLoader를 사용할 수도 있다.

```java
package com.sofia.hw.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sofia.hw.dto.User;

// 이 클래스가 컨트롤러 임을 어노테이션으로 설정, 컴포넌트 스캔을 통해 빈으로 등록
@Controller
public class UserController {
	
	// 파일처리를 위해 시스템 정보를 가져오는 로더 (빈으로 주입)
	@Autowired
    private ResourceLoader resLoader;
	
	/**
	 * '/' 또는 '/index' 요청이 get 방식으로 들어왔을 때 index로 연결한다.
	 * @return
	 */
	@GetMapping({"/", "/index" })
	public String showIndex() {
		return "index";
	}
	
	/**
	 * '/regist' 요청이 get 방식으로 들어왔을 때 regist로 연결한다.
	 * @return
	 */
	@GetMapping("/regist")
	public String showRegistForm() {
		return "regist";
	}

	/**
	 * '/regist' 요청이 post 방식으로 들어왔을 때 전달된 User 객체를 regist_result로 연결한다. 
	 * @param movie
	 * @return
	 */
	@PostMapping("/regist")
	// Img파일은 MultipartFile 타입으로 받는다고 따로 명시한다.
	public ModelAndView doRegist(User user, @RequestParam("userImg") MultipartFile file) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		// 파일을 업로드할 경로
		Resource res = resLoader.getResource("resources/upload");
		
		if(file != null && file.getSize() > 0) {
			// 파일 이름 가져와서 user 객체의 setter를 통해 설정
			user.setImg(file.getName());
			// 지정한 경로에 이미지 파일 저장
			file.transferTo(new File(res.getFile().getCanonicalPath() + "/" + user.getImg()));
		}
		// 어디로 연결할지 설정
		mav.setViewName("regist_result");
		// 전달할 객체
		mav.addObject("user", user);
		return mav;
	}
}
```



​                                   

## 2. FileDownload

* javascript

  ```javascript
  //file download
  $('.filedown').click(function() {
   
    alert("원본 :  " + $(this).attr('ofile') + "      실제 :  " + $(this).attr('sfile'));
    $(document).find('[name="sfolder"]').val($(this).attr('sfolder'));
    $(document).find('[name="ofile"]').val($(this).attr('ofile'));
    $(document).find('[name="sfile"]').val($(this).attr('sfile'));
    $('#downform').attr('action', '${root}/guestbook/download').attr('method', 'get').submit();
  
  });
  ```

* form: hidden으로 숨어있는 input값에 현재 내가 선택한 파일의 값들을 집어넣고 다운로드를 요청한다. 

  ```jsp
  <form id="downform">
  		<input type="hidden" name="sfolder">
  		<input type="hidden" name="ofile">
  		<input type="hidden" name="sfile">
  </form>
  ```

* servlet-context.xml

  ```xml
  <!-- fileDownload -->
  	<beans:bean id="fileDownLoadView" class="com.sofia.guestbook.view.FileDownLoadView"/>
  	<beans:bean id="fileViewResolver" class="org.springframework.web.servlet.view.BeanNameViewResolver">
  		<beans:property name="order" value="0" />
  	</beans:bean> 
  ```

  * 위의 xml은 특정 자바파일을 가져온다: 

    ```java
    import java.io.File;
    import java.io.FileInputStream;
    import java.io.IOException;
    import java.io.OutputStream;
    import java.net.URLEncoder;
    import java.util.Map;
    
    import javax.servlet.ServletContext;
    import javax.servlet.http.HttpServletRequest;
    import javax.servlet.http.HttpServletResponse;
    
    import org.springframework.util.FileCopyUtils;
    import org.springframework.web.servlet.view.AbstractView;
    
    public class FileDownLoadView extends AbstractView {
    
    	public FileDownLoadView() {
    		setContentType("apllication/download; charset=UTF-8");
    	}
    	
    	@Override
    	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    		ServletContext ctx = getServletContext();
    		String realPath = ctx.getRealPath("/upload"); //실제 파일이 어디 저장되는지 가져옴
    		
    		Map<String, Object> fileInfo = (Map<String, Object>) model.get("downloadFile"); // 전송받은 모델(파일 정보)
            
        // 정보를 빼내서 분석
            String saveFolder = (String) fileInfo.get("sfolder");    // 파일 경로
            String originalFile = (String) fileInfo.get("ofile");    // 원본 파일명(화면에 표시될 파일 이름)
            String saveFile = (String) fileInfo.get("sfile");    // 암호화된 파일명(실제 저장된 파일 이름)
            File file = new File(realPath + File.separator  + saveFolder, saveFile);
    		
            response.setContentType(getContentType());
            response.setContentLength((int) file.length());
            
        
        //공식처럼 암기해라
            String header = request.getHeader("User-Agent");
            boolean isIE = header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1;
            String fileName = null;
            // IE는 다르게 처리
            if (isIE) {
            	fileName = URLEncoder.encode(originalFile, "UTF-8").replaceAll("\\+", "%20");
            } else {
                fileName = new String(originalFile.getBytes("UTF-8"), "ISO-8859-1");
            }
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
            response.setHeader("Content-Transfer-Encoding", "binary");
            OutputStream out = response.getOutputStream();
            FileInputStream fis = null;
            try {
                fis = new FileInputStream(file); //파일스트림 연결
                FileCopyUtils.copy(fis, out); //실제로 다운
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if(fis != null) {
                    try { 
                        fis.close(); 
                    }catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
            out.flush();
        }
    }
    
    ```

    

* GuestBookController

  ```java
  @GetMapping(value = "/download")
  	public ModelAndView downloadFile(@RequestParam("sfolder") String sfolder, @RequestParam("ofile") String ofile,
  			@RequestParam("sfile") String sfile, HttpSession session) {
  		MemberDto memberDto = (MemberDto) session.getAttribute("userinfo");
  		if (memberDto != null) {
  			Map<String, Object> fileInfo = new HashMap<String, Object>();
  			fileInfo.put("sfolder", sfolder);
  			fileInfo.put("ofile", ofile);
  			fileInfo.put("sfile", sfile);
  
  			return new ModelAndView("fileDownLoadView", "downloadFile", fileInfo);
  		} else {
  			return new ModelAndView("redirect:/");
  		}
  	}
  ```

  

​              