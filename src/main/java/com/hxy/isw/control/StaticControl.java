package com.hxy.isw.control;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/static")
public class StaticControl {
	
	@RequestMapping(method = RequestMethod.GET, value = "/index")
	public void login(HttpServletRequest request){
		/**
		 * String Modelpath = request.getRealPath("/") + "/news/listNewsMoban.html"; //ģ���ļ���ַ
���� String OutHTMLpath = request.getRealPath("/") + "/news/listNews.html";//��̬ҳ�ļ���ַ
����
���� try {
���� FileStreamHelp fsh = new FileStreamHelp();//ʵ�����ļ�����������
����
���� String htmlcode = fsh.ReadFile(Modelpath);//��ȡģ���ļ�
����
���� int i = 0;
���� List listnews = new ArrayList();
���� BaseDao dao = new NewsDaoImpl();
���� try {
���� listnews = dao.listObject();
���� } catch (Exception e) {
���� e.printStackTrace();
���� }
���� Iterator it = listnews.iterator();
���� while (it.hasNext() && i <= 5) {
���� News news = (News) it.next();
���� i++;
���� htmlcode=htmlcode.replaceAll("###i"+i+"###", String.valueOf(i));
���� htmlcode=htmlcode.replaceAll("###title"+i+"###", news.getTitle());
���� htmlcode=htmlcode.replaceAll("###author"+i+"###", news.getAuthor());
���� htmlcode=htmlcode.replaceAll("###release_date"+i+"###", news.getRelease_date());
���� htmlcode=htmlcode.replaceAll("###id"+i+"###",String.valueOf(news.getId()));
���� }
����
���� fsh.WriteFile(htmlcode, OutHTMLpath);//������ҳ�ļ�
���� } catch (Exception e) {
���� e.printStackTrace();
���� }
���� session.setAttribute("updateTime",new Date().getTime());
���� response.sendRedirect(request.getContextPath() + "/index.jsp");
		 */
	}
	
}
