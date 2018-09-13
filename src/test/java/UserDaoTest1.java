import static org.junit.Assert.*;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import org.junit.BeforeClass;
import org.junit.Test;

import bean.User;
import dao.DatabaseDao;
import dao.UserDao;
import tools.PageInformation;

public class UserDaoTest1 {

	static protected UserDao userDao;
	static protected PageInformation pageInformation;
	static protected DatabaseDao databaseDao;
	static protected User user;
	
	@BeforeClass
	static public void beforeClass() throws Exception {
		userDao = new UserDao();
		user=new User();
		pageInformation = new PageInformation();
		pageInformation.setPage(1);
		pageInformation.setPageSize(2);
		pageInformation.setTableName("user");
		pageInformation.setOrderField("userId");
		pageInformation.setOrder("desc");
		databaseDao = new DatabaseDao();
	}

	@Test
	public void testGetOnePage() throws SQLException {	
		//Tool.getPageInformation("user", request, pageInformation);
		List<User> users=userDao.getOnePage(pageInformation, databaseDao);
		assertEquals(new Integer(users.size()), pageInformation.getPageSize());
	}
	
	@Test
	public void testHasUser()   throws SQLException {	
         user.setName("eeeeeeeeee");
         userDao.hasUser(user, databaseDao);
         assertTrue(userDao.hasUser(user, databaseDao));
	}
	
	@Test
	public void testLogin()   throws Exception {	
        user.setName("eeeeeeeeee");
        user.setPassword("eeeeee");
        assertSame(1,userDao.login(user));
	}
	
	@Test
	public void testRegister()   throws Exception {	
        user.setName("ab123cdefg");
        user.setPassword("123456");
    	user.setType("user");
    	user.setEnable("use");
    	user.setRegisterDate(Timestamp.valueOf("2017-06-09 08:38:17"));
    	userDao.register(user,databaseDao);
       // assertSame(1,userDao.register(user,databaseDao));
	}


}
