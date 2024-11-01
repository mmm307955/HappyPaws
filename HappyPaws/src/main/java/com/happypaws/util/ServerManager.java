package com.happypaws.util;

import java.awt.Desktop;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class ServerManager implements ServletContextListener {
	private String url = "http://localhost:8090/";
	private boolean isSecret = true;
	private boolean isAutoStart = false; // 서버 실행시 자동 실행 여부

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		if (!isAutoStart) {
			return;
		}

		try {
//			defaultBrowser(); // 기본 브라우저의 새 탭에서 실행
			edgeBrowser(); // 엣지 브라우저의 새 창에서 실행
//			chromeBrowser(); // 크롬 브라우저의 새 창에서 실행
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// Do Somethings...
	}

	/** 기본 브라우저에서 그냥 열기 */
	public void defaultBrowser() throws IOException, URISyntaxException {
		if (Desktop.isDesktopSupported())
			Desktop.getDesktop().browse(new URI(url));
	}

	/** edge 새 창에서 열기 */
	public void edgeBrowser() throws IOException {
		String browserPath = "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe";
		new ProcessBuilder(browserPath, isSecret ? "-inprivate" : "--new-window", url).start();
	}

	/** chrome 새 창에서 열기 */
	public void chromeBrowser() throws IOException {
		String browserPath = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe";
		if (isSecret) {
			new ProcessBuilder(browserPath, "--incognito", "--new-window", url).start();
		} else {
			new ProcessBuilder(browserPath, "--new-window", url).start();
		}
	}
}