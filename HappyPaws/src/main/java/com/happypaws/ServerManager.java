package com.happypaws;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * @since 10.24
 * @version 0.0.0
 * @author 강동준
 * 클래스 생성
 */
@WebListener
public class ServerManager implements ServletContextListener {
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		String url = "http://localhost:8090/join";
		String browserPath = "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe"; // Edge에서 열기
//		String browserPath = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"; // 크롬에서 열기

		try {
//			if (Desktop.isDesktopSupported())
//				Desktop.getDesktop().browse(new URI(url)); // 기본 브라우저에서 그냥 열기
			new ProcessBuilder(browserPath, "--new-window", url).start(); // 새 창에서 열기
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// Do Somethings...
	}
}