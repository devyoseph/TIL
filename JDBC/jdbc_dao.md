## JDBC

​           

### Dto

> 테이블의 한 데이터를 객체로 나타낸다.
>
> 테이블 값들을 내부 변수에 저장하고 리스트 등에 넣어 다룬다.
>
> 값을 getter, setter로 다룬다.

```java
public class HouseDto {

	private int aptCode;
	private String aptName;
	private String dongCode;
	private String dongName;
	private int buildYear;
	private String jibun;
	private String lat;
	private String lng;
	private String img;

	public int getAptCode() {
		return aptCode;
	}

	public String getAptName() {
		return aptName;
	}

	public String getDongCode() {
		return dongCode;
	}
  
	public String getDongName() {
		return dongName;
	}

	public int getBuildYear() {
		return buildYear;
	}

	public String getJibun() {
		return jibun;
	}

	public String getLat() {
		return lat;
	}

	public String getLng() {
		return lng;
	}

	public String getImg() {
		return img;
	}

	public void setAptCode(int aptCode) {
		this.aptCode = aptCode;
	}

	public void setAptName(String aptName) {
		this.aptName = aptName;
	}

	public void setDongCode(String dongCode) {
		this.dongCode = dongCode;
	}

	public void setDongName(String dongName) {
		this.dongName = dongName;
	}

	public void setBuildYear(int buildYear) {
		this.buildYear = buildYear;
	}

	public void setJibun(String jibun) {
		this.jibun = jibun;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}

	public void setImg(String img) {
		this.img = img;
	}
}
```

​         

### Dao

> 메소드를 통해 검색값을 받는다. prepareStatement 안에 **?**로 자리를 비워놓고 원하는 검색 조건에 맞추어 sql문을 작성한다. 리턴된 값을 외부에서 받은 다음 for문 등으로 순회해준다.

```java
public class HouseDaoImpl implements HouseDao {

	private static HouseDao houseDao;

	private HouseDaoImpl() {}

	public static HouseDao getHouseDao() {
		if (houseDao == null)
			houseDao = new HouseDaoImpl();
		return houseDao;
	}


	@Override
	public List<HouseDto> searchByDong(String dongName) {
		// TODO Auto-generated method stub
		List<HouseDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBConnection.getConnection();
			String sql = "select aptName, dongName, jibun ";
			sql += "from houseinfo \n";
			sql += "where dongName = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dongName);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				HouseDto houseDto = new HouseDto();
				houseDto.setAptName(rs.getString("aptName"));
				houseDto.setDongName(rs.getString("dongName"));
				houseDto.setJibun(rs.getString("jibun"));
				list.add(houseDto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		return list;
	}

	@Override
	public List<HouseDto> searchByApt(String aptName) {
		// TODO Auto-generated method stub
				List<HouseDto> list = new ArrayList<>();
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try {
					conn = DBConnection.getConnection();
					String sql = "select aptName, dongName, jibun ";
					sql += "from houseinfo \n";
					sql += "where aptName = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, aptName);

					rs = pstmt.executeQuery();
					while (rs.next()) {
						HouseDto houseDto = new HouseDto();
						houseDto.setAptName(rs.getString("aptName"));
						houseDto.setDongName(rs.getString("dongName"));
						houseDto.setJibun(rs.getString("jibun"));
						list.add(houseDto);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					DBClose.close(conn, pstmt, rs);
				}
				return list;
	}

}
```

