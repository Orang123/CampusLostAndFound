import java.text.SimpleDateFormat;
import java.util.Date;

public class test {

	public static void main(String[] args) {
		 // 使用默认时区和语言环境获得一个日历
	    //Calendar cale = Calendar.getInstance();
	    // 将 Calendar 类型转换成 Date 类型
	    Date tasktime = new Date(System.currentTimeMillis());
	    // 设置日期输出的格式
	    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	    // 格式化输出
	    System.out.println(df.format(tasktime));// 2017-12-11 15:05:07
	}

}
